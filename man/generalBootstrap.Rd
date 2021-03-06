% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generalBootstrap.R
\name{generalBootstrap}
\alias{generalBootstrap}
\title{Abstract class of bootstrap}
\description{
Abstract class of bootstrap

Abstract class of bootstrap
}
\details{
Output both the point estimate and the bootstrap confidence interval
}
\section{Methods}{
\subsection{Public methods}{
\itemize{
\item \href{#method-new}{\code{generalBootstrap$new()}}
\item \href{#method-bootstrap}{\code{generalBootstrap$bootstrap()}}
\item \href{#method-exact_bootstrap}{\code{generalBootstrap$exact_bootstrap()}}
\item \href{#method-exact_bootstrap_paper}{\code{generalBootstrap$exact_bootstrap_paper()}}
\item \href{#method-center_CI}{\code{generalBootstrap$center_CI()}}
\item \href{#method-scale_adjust_CI}{\code{generalBootstrap$scale_adjust_CI()}}
\item \href{#method-penalized_CI}{\code{generalBootstrap$penalized_CI()}}
\item \href{#method-penalized_CI_half}{\code{generalBootstrap$penalized_CI_half()}}
\item \href{#method-shift2}{\code{generalBootstrap$shift2()}}
\item \href{#method-sigma_mse}{\code{generalBootstrap$sigma_mse()}}
\item \href{#method-spread}{\code{generalBootstrap$spread()}}
\item \href{#method-all_boot_CI}{\code{generalBootstrap$all_boot_CI()}}
\item \href{#method-clone}{\code{generalBootstrap$clone()}}
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-new"></a>}}
\if{latex}{\out{\hypertarget{method-new}{}}}
\subsection{Method \code{new()}}{
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$new()}\if{html}{\out{</div>}}
}

}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-bootstrap"></a>}}
\if{latex}{\out{\hypertarget{method-bootstrap}{}}}
\subsection{Method \code{bootstrap()}}{
regular bootstrap
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$bootstrap(n_bootstrap, alpha = 0.05, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{n_bootstrap}}{number of bootstrap samples}

\item{\code{alpha}}{significance level for CI}

\item{\code{...}}{other passed to "run_bootstrap"}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-exact_bootstrap"></a>}}
\if{latex}{\out{\hypertarget{method-exact_bootstrap}{}}}
\subsection{Method \code{exact_bootstrap()}}{
exact bootstrap
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$exact_bootstrap(n_bootstrap, alpha = 0.05, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{n_bootstrap}}{number of bootstrap samples}

\item{\code{alpha}}{significance level for CI}

\item{\code{...}}{other passed to "run_bootstrap"}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-exact_bootstrap_paper"></a>}}
\if{latex}{\out{\hypertarget{method-exact_bootstrap_paper}{}}}
\subsection{Method \code{exact_bootstrap_paper()}}{
exact bootstrap on vdl paper
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$exact_bootstrap_paper(n_bootstrap, alpha = 0.05, ...)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{n_bootstrap}}{number of bootstrap samples}

\item{\code{alpha}}{significance level for CI}

\item{\code{...}}{other passed to "run_bootstrap"}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-center_CI"></a>}}
\if{latex}{\out{\hypertarget{method-center_CI}{}}}
\subsection{Method \code{center_CI()}}{
center the bootstrap CI on the point estimate
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$center_CI(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-scale_adjust_CI"></a>}}
\if{latex}{\out{\hypertarget{method-scale_adjust_CI}{}}}
\subsection{Method \code{scale_adjust_CI()}}{
scale the bootstrap CI to be wider than Wald CI
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$scale_adjust_CI(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-penalized_CI"></a>}}
\if{latex}{\out{\hypertarget{method-penalized_CI}{}}}
\subsection{Method \code{penalized_CI()}}{
bias penalized bootstrap

add abs(bias) to both sides of the bootstrap CI (wider)
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$penalized_CI(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-penalized_CI_half"></a>}}
\if{latex}{\out{\hypertarget{method-penalized_CI_half}{}}}
\subsection{Method \code{penalized_CI_half()}}{
bias penalized bootstrap (half)

add 0.5*abs(bias) to both sides of the bootstrap CI (wider)
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$penalized_CI_half(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-shift2"></a>}}
\if{latex}{\out{\hypertarget{method-shift2}{}}}
\subsection{Method \code{shift2()}}{
two bias shifted bootstrap

shift the center of CI by two times the bias
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$shift2(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
NULL
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-sigma_mse"></a>}}
\if{latex}{\out{\hypertarget{method-sigma_mse}{}}}
\subsection{Method \code{sigma_mse()}}{
use the stddev of bootstrap samples, to put a Normal CI around point estimate
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$sigma_mse(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
CI
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-spread"></a>}}
\if{latex}{\out{\hypertarget{method-spread}{}}}
\subsection{Method \code{spread()}}{
use the z-quantiles of bootstrap samples, to put a Normal CI around point estimate
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$spread(bootCI = NULL)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{bootCI}}{the vector of CI}
}
\if{html}{\out{</div>}}
}
\subsection{Returns}{
CI
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-all_boot_CI"></a>}}
\if{latex}{\out{\hypertarget{method-all_boot_CI}{}}}
\subsection{Method \code{all_boot_CI()}}{
return all CI
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$all_boot_CI()}\if{html}{\out{</div>}}
}

\subsection{Returns}{
list of CI
}
}
\if{html}{\out{<hr>}}
\if{html}{\out{<a id="method-clone"></a>}}
\if{latex}{\out{\hypertarget{method-clone}{}}}
\subsection{Method \code{clone()}}{
The objects of this class are cloneable with this method.
\subsection{Usage}{
\if{html}{\out{<div class="r">}}\preformatted{generalBootstrap$clone(deep = FALSE)}\if{html}{\out{</div>}}
}

\subsection{Arguments}{
\if{html}{\out{<div class="arguments">}}
\describe{
\item{\code{deep}}{Whether to make a deep clone.}
}
\if{html}{\out{</div>}}
}
}
}
