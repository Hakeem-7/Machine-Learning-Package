
## Packages
<div class="alert alert-warning">
  <strong>This will be used to install any packages needed for code. Currently, the only package needed is for accessing a sample dataset. To remove all dependencies on outside packages, we may want to create our own dataset.
</div>

# Installing any necessary packages
if (!require("gamair")) {
  install.packages("gamair")
  library(ggplot2)
}

## Linear Regression

# Example dataset from textbook, but we can change this
data(hubble)


#' @title Linear Regression 
#'
#' @description Compute an approximation of the integral of the function f(x)
#' with respect to dx in the range [a, b] by Monte-Carlo integration using
#' uniform sampling.
#' @param response A \code{vector} of dimension 2 used to denote the integration
#' region of interest, i.e. [a, b].
#' @param covariates A \code{string} containing the function to be integrated. It
#' is assumed that \code{x} is used as the variable of interest.
#' @param alpha A \code{numeric} (integer) used to denote the number of simulations.
#' @param method A \code{numeric} used to control the seed of the random number
#' generator used by this function.
#' @return A \code{list} containing the following attributes:
#' \describe{
#'      \item{I}{Estimated value of the integral}
#'      \item{var}{Estimated variance of the estimator}
#' }
#' @author Stephane Guerrier
#' @importFrom stats runif
#' @export 
#' @examples
#' mc_int(x_range = c(0,1), fun = "x^2", B = 10^5)
#' mc_int(x_range = c(0,1), fun = "x^2*sin(x^2/pi)", B = 10^5)
my_lm = function(response, covariates, alpha, method) {
  
  # Putting the data in a matrix format
  response <- as.matrix(response)
  covariates <- as.matrix(covariates)
  
  # Check to see if they are of the same row length
  if(nrow(response) != nrow(covariates)) 
    stop('The number of rows of the response and predictor variables must be equal.')
  
  # Check to see if alpha is between 0 and 1
  if(alpha >= 1 | alpha <= 0) 
    stop('True value of alpha must lie between 0 and 1')
  
  # Produce a warning if alpha is greater than 0.1 (i.e is lower than 90% confidence interval)
  if(alpha > 0.1) 
    warning('Alpha is typically between 0.01 and 0.1. Consider using a different alpha value')
  
  # Check to see if appropriate method has been listed
  if(method != "asymptotic" & method != "bootstrap") 
    stop('Unrecognized confidence interval method. Try "asymptotic" or "bootstrap".')
  
  # Define parameters
  n <- length(response)
  p <- dim(covariates)[2] # Column of the parameters/predictors
  df <- n - p # degree of freedom
  dfm <- p
  dfe <- n - p
  j <- matrix(1, nrow=n, ncol=n) #nxn matrix of ones for calculating ssm
  int <- rep(1, length(response)) #vector of length n for intercept
  
  # Calculate statistics
  beta.hat <- solve(t(covariates)%*%covariates)%*%t(covariates)%*%response
  resid <- response - covariates%*%as.matrix(beta.hat) 
  sigma2.hat <- (1/df)*t(resid)%*%resid
  var.beta <- sigma2.hat*solve(t(covariates)%*%covariates)
  y.hat <- covariates%*%beta.hat
  mspe <- (sum((response - y.hat)^2))/n
  ssm <- (t(beta.hat)%*%t(covariates)%*%response)-(t(response)%*%j%*%response)/n
  sse <- (t(response)%*%response)-(t(beta.hat)%*%t(covariates)%*%response)
  msm <- ssm/dfm
  mse <- sse/dfe
  f.stat <- msm/mse
  
  # Defining parameter for confidence interval based on specified alpha
  quant <- 1 - alpha/2
  
  # Change CI calculation based on specified method
  if(method == "asymptotic"){
    ci.beta <- c(beta.hat - qnorm(p = quant)*sqrt(var.beta), beta.hat + 
                   qnorm(p = quant)*sqrt(var.beta))
  } else{
    data <- cbind(response, covariates)
    i = 1
    beta.hats <- NULL
    while(i<=1000){
      boot.data <- data[sample(nrow(data),size=n,replace=TRUE),]
      beta.hat.boot <- solve(t(boot.data[,2])%*%boot.data[,2])%*%t(boot.data[,2])%*%boot.data[,1]
      beta.hats <- append(beta.hats, beta.hat.boot)
      i <- i+1
    }
    ci.beta <- quantile(beta.hats, c(alpha/2, 1-(alpha/2))) 
  }
  return(list(beta = beta.hat, sigma2 = sigma2.hat, 
              variance_beta = var.beta, ci = ci.beta,
              mspe = mspe, ssm = ssm, sse = sse, f.stat = f.stat, residual = resid,
              y.hat = y.hat))
  
}

# Bootstrap CI method
fit_my_lm = my_lm(hubble$y, hubble$x, 0.05, "bootstrap")
fit_my_lm

# Asymptotic CI method
fit_my_lm2 = my_lm(hubble$y, hubble$x, 0.05, "asymptotic")
fit_my_lm2

# Showing off an error message
fit_my_lm3 = my_lm(hubble$y, hubble$x, 02, "asymptotic")
fit_my_lm3

# Using standard lm package
fit_lm <- lm(hubble$y ~ hubble$x - 1) # -1 eliminates the intercept


# Performance Comparison 

# Comparing the output of our lm function with the base package

base_result = c(fit_lm$coefficients, 
                (1/fit_lm$df.residual)*t(fit_lm$residuals)%*%fit_lm$residuals)

manual_result_bootstrap = c(fit_my_lm$beta, fit_my_lm$sigma2)

manual_result_asymptotic = c(fit_my_lm2$beta, fit_my_lm2$sigma2)

result = cbind(base_result, manual_result_asymptotic, manual_result_bootstrap)
row.names(result) = c("Beta", "Sigma")
result


# Creation of Plots 

plot(fit_my_lm2$y.hat, fit_my_lm2$residual)

qqnorm(fit_my_lm2$residual)
qqline(fit_my_lm2$residual, col = "red", lwd = 2)

hist(fit_my_lm2$residual)
