#' Simulate data
#'
#' This function simulatess example data.
#' @param coef Vector of OLS coefficients
#' @param N Number of observations in simulated data
#' @return
#' Returns a list:
#' \item{original_data}{Data before DP noise added}
#' \item{data_errror}{Data after DP noise added }
#' @export
genData <- function(N)
  {
  Y_err <- 2
  corr <- 1

  # Draw the true X's
  Z1_mean <- 7
  Z2_mean <- 9
  Z3_mean <- 3
  Z1 <- rpois(N, Z1_mean)
  Z2 <- Z1*corr + rpois(N, Z2_mean)
  Z3 <- rpois(N, Z3_mean)

  b0 <- 10
  b1 <- 12
  b2 <- -3
  b3 <- 9

  Y_res <- rnorm(N, mean = 0, sd = Y_err)
  Y <- b0 + b1*Z1 + b2*Z2 + b3*Z3 + Y_res

  original_data <- data.frame(Y = Y, Z1 = Z1, Z2 = Z2, Z3 = Z3)

  s1 <- 0.7
  s2 <- 1.2
  s3 <- 1
  X1 <- Z1 + rnorm(N, 0, s1)
  X2 <- Z2 + rnorm(N, 0, s2)
  X3 <- Z3 + rnorm(N, 0, s3)

  data_error <- data.frame(Y = Y, X1 = X1, X2 = X2, X3 = X3)
  err_vec <- data.frame(Y = 0, X1 = s1, X2 = s2, X3 = s3)
  data_error <- as.data.frame(rbind(err_vec, data_error))

  return(list(private_data = original_data, dp_data = data_error))

  }

