

Die <- function( ) {
  this <- list(history=integer(0));
  class(this) <- "Die"
  return(this)
}

print.Die <- function(theObject) {
  cat("History: ", theObject$history, "\n")
}

ChlorReads <- function(self.id, self.name, self.gender, self.ldl, self.hdl, self.trigl) {
  this <- list(id=self.id, name=self.name, gender=self.gender, ldl=self.ldl, hdl=self.ldl, trigl=self.trigl)
  class(this) <- "ChlorReads"
  return(this)
}

print.ChlorReads <- function(self) {
  cat("ID:", self$id, ", Name:", self$name, ", Gender:", self$gender, "\nLDL:",
      self$ldl, ", HDL:", self$hdl, ", Triglycerides:", self$trigl, "\n")
}

p1 <- ChlorReads(9876, "Virgil", "M", 248, 45, 148)
print.ChlorReads(p1)
print(p1)

#stopped the 2nd to last lectura aropund 1:30:00