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

mycbind1 <- function(A, B) {
  C <- matrix(data=NA, nrow=nrow(A), ncol=(ncol(A) + ncol(B)))
  for (r in 1:nrow(C)) {
    for (c in 1:ncol(C)) {
      if (c <= ncol(A)) {
        C[r,c] <- A[r,c]
      } else {
        C[r,c] <- B[r,c-ncol(A)]
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
  } else if (f == 'mycbind1') {
    f_runtime <- system.time(mycbind1(A,B))
  } else {
    f_runtime <- system.time(reg_cbind(A,B))
  }
  f_runtime1 <- system.time(mycbind1(A,B))
  print(cat('mycbind :', f_runtime, '\n'))
  print(cat('mycbind1:', f_runtime1,'\n'))
  return(f_runtime)
}

func_timer(700)


n <- 20
A <- matrix(runif(n * n), n, n)
B <- matrix(runif(n * n), n, n)

C <- mycbind(A,B)

# this checks that data is being put in the right place indexed location
C_A <- C[1:nrow(A), 1:ncol(A)]
C_A - A
C_B <- C[1:nrow(B), (ncol(A)+1):ncol(C)]
C_B - B

