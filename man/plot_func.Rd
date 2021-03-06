% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/my_lm_script.R
\name{plot_func}
\alias{plot_func}
\title{Linear Regression Plot}
\usage{
plot_func(lm)
}
\arguments{
\item{lm}{An \code{object}, generated using \code{\link{my_lm}} whose class will determine the behavior of the plots returned.}
}
\value{
A series of 3 plots containing the following attributes:
\describe{
     \item{Plot}{A plot of the estimated residual values versus the estimated fitted values.}
     \item{QQ-Plot}{A qq-plot plotting estimated residual values, with a fitted line}
     \item{Histogram}{A histogram of the estimated residual values}
}
}
\description{
Descriptive plots on to deliver inference on the parameter vector beta, using calculated statistics from \code{my_lm}.
}
\examples{

data(iris)

fit_my_lm <- my_lm(iris$Sepal.Length, iris$Sepal.Width, alpha = 0.05, method = "bootstrap")
plot_func(fit_my_lm)
}
\author{
Akeem Ajede and Cary Burdick and Kaelyn Fogelman and Maria Tereza
}
