etwd('C:/datasets')

# This is a homebrewed function that replicates the functionality of cbind()
# using nested for-loops.
mycbind <- function(A, B) {
  size_A <- dim(A)
  size_B <- dim(B)
  C <- matrix(data=NA, nrow=size_A[1], ncol=(size_A[2] + size_B[2]))
  size_C <- dim(C)
  for (r in 1:size_C[1]) {
    for (c in 1:size_C[2]) {
      if (c <= size_A[2]) {
        C[r,c] <- A[r,c]
      } else {
        C[r,c] <- B[r,c-size_A[2]]
      }
    }
  }
  return(C)
}

# This is a wrapper function that invokes cbind() on 2 matrices.
# If I were implementing this for more than just an assignment, I would
# include code to check user inputs and handle errors.
reg_cbind <- function(A, B) {
  return(cbind(A,B))
}

# This function creates matricies of size n by n and tracks the runtimes the
# mycbind and or reg_cbind functions with those matricies
func_timer <- function(n, f='both') {
  A <- matrix(runif(n * n), n, n)
  B <- matrix(runif(n * n), n, n)
  if (f == 'mycbind'){
    f_runtime <- system.time(mycbind(A,B))
  } else if (f == 'both') {
    f_runtime <- data.frame(system.time(mycbind(A,B))[3], system.time(reg_cbind(A,B))[3])
  } else {
    f_runtime <- system.time(reg_cbind(A,B))
  }
  return(f_runtime)
}

# This function takes a vector containing different input sizes, runs the indicates
# function(s) with matricies of those input sizes, stores the observed runtimes,
# and plots graphs of those runtimes
func_timer_grapher <- function(n_vec, f='both') {
  func_t <- sapply(n_vec, func_timer, f=f)
  max_mycbind <- max(unlist(func_t[1,1:ncol(func_t)]))
  max_reg_cbind <- max(unlist(func_t[2,1:ncol(func_t)]))
  if (max_mycbind > max_reg_cbind) {
    max_y <- max_mycbind
  } else {
    max_y <- max_reg_cbind
  }
  plot(x=n_vec, y=func_t[1,1:ncol(func_t)], type="l", main="Runtime of Function mycbind as a Function of Input Size",
      ylab="Runtime (in seconds)", xlab="Input Size (dimensionless)", ylim=c(0, max_y))
  invisible(readline(prompt="Press [enter] to display the next plot"))
  plot(x=n_vec, y=func_t[2,1:ncol(func_t)], type="l", main="Runtime of Function reg_cbind as a Function of Input Size",
       ylab="Runtime (in seconds)", xlab="Input Size (dimensionless)", ylim=c(0, max_y))
  invisible(readline(prompt="Press [enter] to display the next plot"))
  plot(x=n_vec, y=func_t[2,1:ncol(func_t)], type="l", main="Runtime of Function reg_cbind as a Function of Input Size (own scale)",
       ylab="Runtime (in seconds)", xlab="Input Size (dimensionless)")
  invisible(readline(prompt="Press [enter] to display the next plot"))
  plot(x=n_vec, y=func_t[1,1:ncol(func_t)], type="l", main="Runtime of Function mycbind and reg_cbind as a Function of Input Size",
       ylab="Runtime (in seconds)", xlab="Input Size (dimensionless)", ylim=c(0, max_y), col='red')
  lines(x=n_vec, y=func_t[2,1:ncol(func_t)], col='blue')
  legend(n_vec[1],.9*max_y,legend=c('mycbind', 'reg_cbind'), col=c('red','blue'), lty=1)
  return(func_t)
}


# These are vectors containing input sizes
n_vec <- c(200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000)
n_vec_test <- c(20, 40, 60, 80, 100, 120, 140, 160, 180, 200)
n_cbind <- c(20000, 40000, 60000, 80000, 100000, 120000, 140000, 160000, 180000, 200000)
func_t <- func_timer_grapher(n_vec)
func_c <- func_timer_grapher(n_cbind, f='reg_cbind')

## this test code creates small samples and checks that data is being put in the
## right place indexed location using the sample 
# n <- 20
# A <- matrix(runif(n * n), n, n)
# B <- matrix(runif(n * n), n, n)
# C <- mycbind(A,B)
# C <- reg_cbind(A, B)
 
# C_A <- C[1:nrow(A), 1:ncol(A)]
# C_A - A
# C_B <- C[1:nrow(B), (ncol(A)+1):ncol(C)]
# C_B - B

