etwd('C:/datasets')

mycbind <- function(A, B) {
  size_A <- dim(A)
#  print(cat('size_A is ', size_A[1], ' by ', size_A[2], '\n'))
  size_B <- dim(B)
#  print(cat('size_B is ', size_B[1], ' by ', size_B[2], '\n'))
  C <- matrix(data=NA, nrow=size_A[1], ncol=(size_A[2] + size_B[2]))
  size_C <- dim(C)
#  print(cat('size_C is ', size_C[1], ' by ', size_C[2], '\n'))
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

func_timer(2000)


n <- 20
A <- matrix(runif(n * n), n, n)
B <- matrix(runif(n * n), n, n)

C <- mycbind(A,B)

# this checks that data is being put in the right place indexed location
C_A <- C[1:nrow(A), 1:ncol(A)]
C_A - A
C_B <- C[1:nrow(B), (ncol(A)+1):ncol(C)]
C_B - B

