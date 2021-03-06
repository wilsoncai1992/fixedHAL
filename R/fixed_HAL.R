#' fitting fixed_HAL. outputs an object of the fit
#' use the old basis
#' use the old lambda
#' OPTIONAL: if the old object is squashed, only use the non-zero basis
#'
#' @param Y vector of target
#' @param X data.frame of feature
#' @param weights vector of weight
#' @param hal9001_object hal9001 object
#' @param family glm family Y
#' @param inflate_lambda scale the penalty factor
#' @importFrom stats glm
#' @export
fit_fixed_HAL <- function(
                          Y,
                          X,
                          weights = NULL,
                          hal9001_object,
                          family = stats::gaussian(),
                          inflate_lambda = 1) {
  if (is.null(weights)) weights <- rep(1, length(Y))
  basis_list <- hal9001_object$basis_list
  copy_map <- hal9001_object$copy_map
  if (!is.matrix(X)) X <- as.matrix(X)
  if (length(basis_list) > 0) {
    x_basis <- hal9001::make_design_matrix(X, basis_list)
    # deduplication
    unique_columns <- as.numeric(names(copy_map))
    x_basis <- x_basis[, unique_columns]
  }
  if (length(basis_list) == 0) x_basis <- matrix(1, ncol = 2, nrow = nrow(X))
  x_basis <- as.matrix(x_basis)

  # if the design matrix has too few columns, make glmnet dim >= 2
  IS_GLM <- FALSE
  if (dim(x_basis)[2] <= 1) {
    message("dim of X_basis < 2. make it larger")
    x_basis <- cbind(matrix(1, ncol = 1, nrow = nrow(X)), x_basis)
    x_basis <- cbind(matrix(0, ncol = 1, nrow = nrow(X)), x_basis)
    lasso_fit <- glm(Y ~ x_basis - 1, x = FALSE, y = FALSE, family = family)
    IS_GLM <- TRUE
  }

  # inflate lambda than CV select
  if (!is.numeric(inflate_lambda)) warning("non-numeric `inflate_lambda`!")
  inflate_lambda <- 1
  lambda <- inflate_lambda * hal9001_object$lambda_star

  # glmnet only takes character for family input
  if (class(family) == "family") family <- family$family
  if (!IS_GLM) {
    lasso_fit <- tryCatch({
      lasso_fit <- glmnet::glmnet(
        x = x_basis,
        y = Y,
        family = family,
        weights = weights,
        alpha = 1,
        lambda = lambda,
        intercept = FALSE,
        standardize = FALSE
      )
    },
    error = function(cond) {
      message("glmnet errors. use glm instead")
      message("Here's the original error message:")
      message(cond)
      # Choose a return value in case of error
      lasso_fit <- stats::glm.fit(
        x = x_basis,
        y = Y,
        family = family,
        weights = weights
      )
      IS_GLM <- TRUE
      return(lasso_fit)
    }
    )
  }

  object <- list(
    lasso_fit = lasso_fit,
    basis_list = basis_list,
    copy_map = copy_map,
    family = family,
    IS_GLM = IS_GLM
  )
  class(object) <- "fixed_HAL"
  return(object)
}

#' prediciton function for fixed_HAL object
#'
#' @param object class `fixed_HAL``
#' @param ... extra arguments into hal9001
#' @param new_data matrix with the same number of columns as in training
#'
#' @return a vector of predictions
#' @importFrom Matrix tcrossprod
#' @keywords internal
predict.fixed_HAL <- function(object, ..., new_data) {
  if (class(object) != "fixed_HAL") stop("object class not right!")

  # cast new data to matrix if not so already
  if (!is.matrix(new_data)) new_data <- as.matrix(new_data)
  # generate design matrix
  if (length(object$basis_list) > 0) {
    pred_x_basis <- hal9001::make_design_matrix(new_data, object$basis_list)
    pred_x_basis <- hal9001::apply_copy_map(pred_x_basis, object$copy_map)
    # make up the ncol for glm solution
    if (object$IS_GLM) {
      pred_x_basis <- cbind(
        matrix(1, ncol = 1, nrow = nrow(pred_x_basis)), pred_x_basis
      )
      pred_x_basis <- cbind(
        matrix(0, ncol = 1, nrow = nrow(pred_x_basis)), pred_x_basis
      )
    }
  }
  if (length(object$basis_list) == 0) {
    pred_x_basis <- matrix(1, ncol = 2, nrow = nrow(new_data))
  }

  # generate predictions
  beta_hat <- stats::coef(object$lasso_fit)
  beta_hat[is.na(beta_hat)] <- 0
  beta_hat <- as.matrix(beta_hat)

  if (length(beta_hat) > dim(pred_x_basis)[2]) {
    # glmnet situation
    preds <- as.vector(
      Matrix::tcrossprod(x = pred_x_basis, y = beta_hat[-1]) + beta_hat[1]
    )
  } else {
    # glm situation
    preds <- as.numeric(as.matrix(pred_x_basis) %*% beta_hat)
  }

  if (object$family == "gaussian") {} # do nothing if gaussian glm
  if (object$family == "binomial") preds <- stats::plogis(preds) # transform if binomial glm
  return(preds)
}

#
# SL wrappers
# ========================================================================

#' (Experimental) Super Learner wrapper for fixed HAL
#'
#' depend on an hal9001 object. which is the fit on the whole data.
#'
#' @param Y vector of target
#' @param X data.frame of feature
#' @param newX data.frame of features to generate prediction
#' @param obsWeights vector of weight
#' @param hal9001_object hal9001 object
#' @param family glm family Y
#' @param inflate_lambda scale the penalty factor
#' @param ... other arguments
#'
#' @export
basic_fixed_HAL <- function(Y,
                            X,
                            hal9001_object = NULL,
                            newX = NULL,
                            family = stats::gaussian(),
                            obsWeights = rep(1, length(Y)),
                            inflate_lambda = 1,
                            ...) {
  if (is.null(hal9001_object)) stop("missing hal9001_object!")
  # fit HAL
  fitted_out <- fit_fixed_HAL(
    Y = Y,
    X = X,
    hal9001_object = hal9001_object,
    family = family,
    inflate_lambda = inflate_lambda
  )

  # compute predictions based on `newX` or input `X`
  if (!is.null(newX)) {
    pred <- predict.fixed_HAL(object = fitted_out, new_data = newX)
  } else {
    pred <- predict.fixed_HAL(object = fitted_out, new_data = X)
  }

  # build output object
  fit <- list(object = fitted_out)
  class(fit) <- "SL.fixed_HAL"
  out <- list(pred = pred, fit = fit)
  return(out)
}

#' Generator of SL wrappers
#'
#' outputs a SL wrapper, that no longer depend on the hal9001 object.
#' the output arguments conform with `SL` library convention
#'
#' @keywords internal
generate_SL.fixed_HAL <- function(hal9001_object = NULL, inflate_lambda = 1) {
  function(...) basic_fixed_HAL(
      ...,
      hal9001_object = hal9001_object, inflate_lambda = inflate_lambda
    )
}

#' SuperLearner prediction function for the SL wrapper
#'
#' @keywords internal
predict.SL.fixed_HAL <- function(object, newX, ...) {
  # generate predictions and return
  pred <- predict.fixed_HAL(object$object, new_data = newX, ...)
  return(pred)
}
