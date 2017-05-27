a <-c(1,2,3,4,5,6,7,8,9)
A <- matrix(a, nrow=3, ncol=3)
system.time(sum(A))

system.time(for(i in 1:10000) s <- sum(A))
system.time(for(i in 1:10000) s <- sum(apply(A,1,sum)))
system.time(for(i in 1:10000) s <- sum(apply(A,2,sum)))

funk <- function(A) {
  total <- 0
  for(j in 1:ncol(A))
    for(i in 1:nrow(A))
      total <- total + A[i, j]
    print(total)
}

system.time(for(i in 1:10000) s <- funk(A))

g <- function(f) {
  return(f(16))
}
print(g(sqrt))

g <- function(f) {
  return(f(16))
}
print(g(sqrt))
  
