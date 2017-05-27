etwd('C:/datasets')

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


func_timer <- function(n, f='mycbind') {
  A <- matrix(runif(n * n), n, n)
  B <- matrix(runif(n * n), n, n)
  if (f == 'mycbind'){
    f_runtime <- system.time(mycbind(A,B))
  } else {
    f_runtime <- system.time(reg_cbind(A,B))
  }
  return(f_runtime)
}


func_timer_grapher <- function(n_vec, f='mycbind') {
  func_time_vec <- sapply(n_vec, func_timer, f=f)
  func_df <- data.frame(x=n_vec, y=func_time_vec[3,1:length(n_vec)])
  title <- paste0("Runtime of Function ", f, " as a Function of Input Size")
  plot(func_df, type="l", main=title, ylab="Runtime (in seconds)", xlab="Input Size (dimensionless)")
  return(func_df)
}
n_vec <- c(20, 40, 60)
n_vec <- c(200, 400, 600)
n_vec <- c(200, 400, 600, 800, 1000, 1200, 1400, 1600, 1800, 2000)
n_vec <- c(20, 40, 60, 80, 100, 120, 140, 160, 180, 200)
funk <- func_timer_grapher(n_vec)



## this test code creates small samples and checks that data is being put in the
## right place indexed location using the sample 
# n <- 20
# A <- matrix(runif(n * n), n, n)
# B <- matrix(runif(n * n), n, n)
# C <- mycbind(A,B)

# C_A <- C[1:nrow(A), 1:ncol(A)]
# C_A - A
# C_B <- C[1:nrow(B), (ncol(A)+1):ncol(C)]
# C_B - B

