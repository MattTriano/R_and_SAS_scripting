# Die Example
# Create S3 object that simulates rolling
# a single die until a 1 is obtained.

# Constructor
Die <- function( ) {
  this <- list(history=integer(0));
  class(this) <- "Die"
  return(this)
}

# Generic reset method
reset <- function(theObject) {
  UseMethod("reset", theObject)
}

# Default reset method
reset.default <- function(theObject) {
  warning("Default reset method called unrecognized object")
  return(theObject)
}

# Die reset method
reset.Die <- function(theObject) {
  theObject$history <- integer(0)
  return(theObject)
}

# Generic simulation method
simulation <- function(theObject) {
  UseMethod("simulation", theObject)
}

# Default simulation method
simulation.default <- function(theObject) {
  warning("Default simulation method called unrecognized object")
  return(theObject)
}

# Die simulation method
simulation.Die <- function(theObject) {
  theObject <- reset(theObject)
  repeat {
    roll <- as.integer(runif(1, 1, 6.999999999))
    theObject$history <- c(theObject$history, roll)
    if (roll == 1) {
      break
    }
  }
  return(theObject)
}

# Die print method
print.Die <- function(theObject) {
  cat("History: ", theObject$history, "\n")
}

# Die plot method
plot.Die <- function(theObject) {
  this <- theObject
  n <- length(this$history)
  plot(1:n, this$history, main="Roll History",
       xlab="Roll Number", ylab="Roll", ylim=c(1,6),
       type="l")
}

# Create Die object
d <- Die( )

# Repeat these three statements to obtain simulations.
d <- simulation(d)
print(d)
plot(d)
