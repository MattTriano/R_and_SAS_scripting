a = list(1,2,3)
?matrix
mdat <- matrix(c(1,2,3, 11,12,13), nrow = 2, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2"),
                               c("C.1", "C.2", "C.3")))
is.atomic(mdat)
vec <- c(1,2,3)
is.atomic(vec)
is.atomic(a)

# quiz question 1) List is nonatomic

?data.frame
?read.csv
?read.table

#2) read.data.frame doesn't return a df

?stdout
?sink
#3) sink sends R output to file
u <- c(1,2,3)
v <- c(2,4,6)
 
plot(mdat, main="Sample Plot", pch("*"), col="blue", cex(2))
plot(u, v, main="Sample Plot", char("*"), col="blue", cex=2)
plot(u, v, title="Sample Plot", char="*", color="blue", cex=2)
#4) plot(u, v, title="Sample Plot", char="*", color="blue", cex=2) produces a scatterplot


celToFahr <- function cel {
  return(9.0 * cel / 5.0 + 32.0)
}

celToFahr <- function(cel)
  return(9.0 * cel / 5.0 + 32.0)
#5) correct fctn entry
celToFahr(0)

plot(u, v, title="Sample Plot", char="*", color="blue", cex=2)
plot(mdat, main="Sample Plot", pch="*", col="blue", cex=2)

celToFahr <- def cel {
  return 9.0 * cel / 5.0 + 32.0
}
