?lm

# Example dataset from textbook, but we can change this
data(hubble)

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
  
  # Calculate statistics
  beta.hat <- solve(t(covariates)%*%covariates)%*%t(covariates)%*%response
  resid <- response - covariates%*%as.matrix(beta.hat) 
  sigma2.hat <- (1/df)*t(resid)%*%resid
  var.beta <- sigma2.hat*solve(t(covariates)%*%covariates)
  
  
 
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
      size <- sample(2:nrow(data), 1)
      boot.data <- data[sample(nrow(data),size=size,replace=TRUE),]
      beta.hat.boot <- solve(t(boot.data[,2])%*%boot.data[,2])%*%t(boot.data[,2])%*%boot.data[,1]
      beta.hats <- append(beta.hats, beta.hat.boot)
      i <- i+1
    }
    ci.beta <- quantile(beta.hats, c(alpha/2, 1-(alpha/2))) 
  }
  

  return(list(beta = beta.hat, sigma2 = sigma2.hat, 
              variance_beta = var.beta, ci = ci.beta))
}

# Bootstrap CI method
fit_my_lm = my_lm(hubble$y, hubble$x, 0.05, "bootstrap")
fit_my_lm

# Asymptotic CI method
fit_my_lm2 = my_lm(hubble$y, hubble$x, 0.05, "asymptotic")
fit_my_lm2

# Showing off an error message


# Using standard lm package
fit_lm <- lm(hubble$y ~ hubble$x - 1) # -1 eliminates the intercept


















