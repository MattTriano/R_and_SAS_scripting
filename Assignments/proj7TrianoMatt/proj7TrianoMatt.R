

Die <- function( ) {
  this <- list(history=integer(0));
  class(this) <- "Die"
  return(this)
}

print.Die <- function(theObject) {
  cat("History: ", theObject$history, "\n")
}

ChlorReads <- function(self.id, self.name, self.gender, self.ldl, self.hdl, self.trigl) {
  this <- list(id=self.id, name=self.name, gender=self.gender, ldl=self.ldl, hdl=self.hdl, trigl=self.trigl)
  class(this) <- "ChlorReads"
  return(this)
}

get.ldl <- function(self) {
  ldl <- self$ldl
  if (ldl >= 240) {
    ldl_symb <- paste0(ldl, "*")
  } else if (ldl >= 200) {
    ldl_symb <- paste0(ldl, "+")
  } else if (ldl >= 0) {
    ldl_symb <- paste0(ldl, "")
  } else {
    ldl_symb <- "ILLEGAL LDL VALUE!"
  }
  return(ldl_symb)
}

get.hdl <- function(self) {
  hdl <- self$hdl
  if (hdl >= 60) {
    hdl_symb <- paste0(hdl, " ")
  } else if (hdl >= 40) {
    hdl_symb <- paste0(hdl, "+")
  } else if (hdl >= 0) {
    hdl_symb <- paste0(hdl, "*")
  } else {
    hdl_symb <- "ILLEGAL HDL VALUE!"
  }
  return(hdl_symb)
}

get.trigl <- function(self) {
  trig <- self$trigl
  if (trig >= 200) {
    trig_symb <- paste0(trig, "*")
  } else if (trig >= 150) {
    trig_symb <- paste0(trig, "+")
  } else if (trig >= 0) {
    trig_symb <- paste0(trig, "")
  } else {
    trig_symb <- "ILLEGAL TRIGLYCERIDE VALUE!"
  }
  return(trig_symb)
}

plot.ChlorReads <- function(self) {
  counts <- c(self$ldl, self$hdl, self$trigl)
  barplot(height=counts, ylim=c(0, max(counts)), names=c("LDL","HDL","Triglycerides"))
}

print.ChlorReads <- function(self) {
  cat("ID:", self$id, " Name:", self$name, " Gender:", self$gender, "\nLDL:",
      get.ldl(self), " HDL:", get.hdl(self), " Triglycerides:", get.trigl(self), "\n")
}

p1 <- ChlorReads(9876, "Virgil", "M", 248, 45, 148)
print.ChlorReads(p1)
print(p1)
plot(p1)



#stopped the 2nd to last lectura aropund 1:30:00