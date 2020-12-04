
#' @title Linear Regression
#'
#' @description Delivers inference on the parameter vector beta.
#' @param response A \code{vector} response variable y of your data set of interest.
#' @param covariates A \code{matrix} containing the explanatory variable x of your data set of interest.
#' @param alpha A \code{numeric} set to determine an estimate of confidence intervals. The most common confidence interval is 95\%, with a level of significance, alpha = 0.05. Generally, alpha is between 0.01 and 0.1.
#' @param method A \code{character} used to determine the fit; \code{method = "asymptotic"} or \code{method = "bootstrap"}.
#' @return A \code{list} containing the following attributes:
#' \describe{
#'      \item{y.avg}{The mean of all y-values in the data set}
#'      \item{beta}{The estimated value of beta-hat}
#'      \item{sigma2}{Estimate of the residual variance}
#'      \item{variance_beta}{Estimate of the variance of the estimated beta}
#'      \item{y.hat}{The predicted y-value}
#'      \item{ci}{The confidence interval based on the alpha set in the function parameters}
#'      \item{mspe}{Estimate of how well the model predicts the response variable}
#'      \item{ssm}{Model sum of squares}
#'      \item{sse}{The error sum of squares, which quantifies how much the residual data points vary around the estimated regression line points, y-hat}
#'      \item{f.stat}{The f statistic for use in f test and model fitting}
#'      \item{p.value}{The probability of the observed data, or data more extreme, given the null hypothesis is true}
#'      \item{residual}{The difference between the observed y-value and the predicted y-value, or y-hat}
#' }
#' @author Akeem Ajede and Cary Burdick and Kaelyn Fogelman and Maria Tereza
#' @importFrom stats runif
#' @export
#' @examples
#' 
#' data(iris)
#' 
#' simple regression 
#' my_lm(iris$Sepal.Length, iris$Sepal.Width, alpha = 0.05, method = "bootstrap")
#' 
#' multiple regression 
#' my_lm(iris$Sepal.Length + iris$Sepal.Width, iris$Petal.Length, alpha = 0.05, method = "asymptotic")
my_lm = function(response, covariates, alpha=0.05, method="asymptotic", intercept=1) {

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
  if(method != "asymptotic" & method != "a" & method != "bootstrap" & method != "b")
    stop('Unrecognized confidence interval method. Try "asymptotic" or "bootstrap".')

  # Check to make sure either 1 or -1 specified for intercept
  if(intercept != 1 & intercept != -1)
    stop('Enter a value of 1 if the model should estimate the intercept or -1 otherwise')

  # Check if response variable has more than one column
  if(dim(response)[2] > 1)
    stop('Only one response variable may be used.')

  # Define parameters and calculate statistics with and without intercept
  if(intercept==1){
    # Parameters with intercept
    k <- 0
    n <- length(response)
    int <- rep(1, n)
    covariates <- as.matrix(cbind(int, covariates))
    p <- dim(covariates)[2] # Column of the parameters/predictors
    dfm <- p - 1
    dfe <- n - p
    j <- matrix(1, nrow=n, ncol=n)
    one <- rep(1, n)

    # Statistics with intercept
    beta.hat <- solve(t(covariates)%*%covariates)%*%t(covariates)%*%response
    resid <- response - covariates%*%as.matrix(beta.hat)
    sigma2.hat <- (1/dfe)*t(resid)%*%resid
    var.beta <- t(sigma2.hat%*%diag(solve(t(covariates)%*%covariates)))
    y.hat <- covariates%*%beta.hat
    mspe <- (t(response-y.hat)%*%(response-y.hat))/n
    y.avg <- (t(response)%*%one)/n
    ssm <- t(y.hat-y.avg[1])%*%(y.hat-y.avg[1])
    sse <- t(response-y.hat)%*%(response-y.hat)
    msm <- ssm/dfm
    mse <- sse/dfe
    f.stat <- msm/mse
    p.value <- pf(f.stat, dfm, dfe, lower.tail=FALSE)

    # Setting up the y table
    y.table <- cbind(response, y.hat, resid)
    colnames(y.table) <- c('actual.y.values','predicted.y.values','residuals')

    # Setting up names of rows for beta table
    row_names <- NULL
    for(i in 0:(length(beta.hat)-1)) {
      iter_rows <- paste("b", i, sep = "")
      row_names <- append(row_names, iter_rows)
    }
  }
  else {
    # Parameters without intercept
    k <- 1
    n <- length(response)
    covariates <- covariates
    p <- dim(covariates)[2] # Column of the parameters/predictors
    dfm <- p
    dfe <- n - p
    j <- matrix(1, nrow=n, ncol=n)
    one <- rep(1, n)

    # Statistics without intercept
    beta.hat <- solve(t(covariates)%*%covariates)%*%t(covariates)%*%response
    resid <- response - covariates%*%as.matrix(beta.hat)
    sigma2.hat <- (1/dfe)*t(resid)%*%resid
    var.beta <- t(sigma2.hat%*%diag(solve(t(covariates)%*%covariates)))
    y.hat <- covariates%*%beta.hat
    mspe <- (t(response-y.hat)%*%(response-y.hat))/n
    y.avg <- (t(response)%*%one)/n
    ssm <- t(y.hat)%*%(y.hat)
    sse <- t(response-y.hat)%*%(response-y.hat)
    msm <- ssm/dfm
    mse <- sse/dfe
    f.stat <- msm/mse
    p.value <- pf(f.stat, dfm, dfe, lower.tail=FALSE)

    # Setting up names of rows for beta table
    row_names <- NULL
    for(i in 1:length(beta.hat)) {
      iter_rows <- paste("b", i, sep = "")
      row_names <- append(row_names, iter_rows)
    }
  }

  # More beta table preparation
  rownames(beta.hat) <- row_names
  rownames(var.beta) <- row_names

  # Setting up the y table
  y.table <- cbind(response, y.hat, resid)
  colnames(y.table) <- c('actual.y.values','y.hat','residual')

  # Defining parameter for confidence interval based on specified alpha
  quant <- 1 - alpha/2

  # Change CI calculation based on specified method
  if(tolower(method) == "asymptotic" | tolower(method) == "a"){
    iter = length(beta.hat)
    ci.beta <- NULL
    for(i in 1:length(beta.hat)){
      ci.list <- c(beta.hat[i] - qnorm(p = quant)*sqrt(var.beta[i]), beta.hat[i] +
                     qnorm(p = quant)*sqrt(var.beta[i]))
      ci.beta <- rbind(ci.beta, ci.list)
    }
    rownames(ci.beta) <- row_names
  } else{
    data <- cbind(response, covariates)
    i = 1
    beta.hats <- NULL
    while(i<=1000){
      boot.data <- data[sample(nrow(data),size=n,replace=TRUE),]
      beta.hat.boot <- solve(t(boot.data[,2:dim(boot.data)[2]])%*%boot.data[,2:dim(boot.data)[2]])%*%t(boot.data[,2:dim(boot.data)[2]])%*%boot.data[,1]
      beta.hats <- rbind(beta.hats, t(beta.hat.boot))
      i <- i+1
    }
    ci.beta <- NULL
    for(i in 1:dim(beta.hats)[2]){
      ci.list <- ci.list <- quantile(beta.hats[,i], c(alpha/2, 1-(alpha/2)))
      ci.beta <- rbind(ci.beta, ci.list)
    }
  }

  # Setting up the beta table
  rownames(ci.beta) <- row_names
  beta.table <- cbind(beta.hat, var.beta, ci.beta)
  colnames(beta.table) <- c('beta','variance.beta','CI.lower.bound','CI.upper.bound')

  #invisible(y.hat=y.hat)

  return(list(y.avg = y.avg, sigma2 = sigma2.hat,
              mspe = mspe, ssm = ssm, sse = sse, f.stat = f.stat,
              p.value = p.value, y.table = y.table, beta.table = beta.table))
}


#' @title Linear Regression Plot
#'
#' @description Descriptive plots on to deliver inference on the parameter vector beta, using calculated statistics from \code{my_lm}.
#' @param lm An \code{object}, generated using \code{\link{my_lm}} whose class will determine the behavior of the plots returned.
#' @return A series of 3 plots containing the following attributes:
#' \describe{
#'      \item{Plot}{A plot of the estimated residual values versus the estimated fitted values.}
#'      \item{QQ-Plot}{A qq-plot plotting estimated residual values, with a fitted line}
#'      \item{Histogram}{A histogram of the estimated residual values}
#' }
#' @author Akeem Ajede and Cary Burdick and Kaelyn Fogelman and Maria Tereza
#' @importFrom stats runif
#' @export
#' @examples 
#' 
#' data(iris)
#' 
#' fit_my_lm <- my_lm(iris$Sepal.Length, iris$Sepal.Width, alpha = 0.05, method = "bootstrap")
#' plot_func(fit_my_lm)

plot_func <- function(lm){
  plot(lm$y.table[,2], lm$y.table[,3], main="Residuals vs. Fitted Values (y.hat)",
       xlab="Fitted Values (y.hat)", ylab="Residuals")

  qqnorm(lm$y.table[,3], main="Normal Q-Q Plot of Residuals")
  qqline(lm$y.table[,3], col = "red", lwd = 2)

  hist(lm$y.table[,3], main="Histogram of Residuals", xlab="Residual Values", freq=FALSE)

}


