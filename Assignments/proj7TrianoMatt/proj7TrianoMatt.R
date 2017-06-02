# Not sure if it was intentional, but "Chloresterol" is actually spelled Cholesterol
setwd('C:/datasets')

ChlorReads <- function(self.id, self.name, self.gender, self.ldl, self.hdl, self.trigl) {
  this <- list(id=self.id, name=self.name, gender=self.gender, ldl=self.ldl, hdl=self.hdl, trigl=self.trigl)
  class(this) <- "ChlorReads"
  return(this)
}

# This class function appends the correct symbol to the LDL value
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

# This class function appends the correct symbol to the HDL value
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

# This class function appends the correct symbol to the Triglyceride value
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

# This class function produces a barplot of the Chlor data. I couldn't figure out how
#  to force the legend to print without the grey symbol to the left of the text.
#  Perhaps there is some overlay function or parameter I overlooked.
plot.ChlorReads <- function(self) {
  counts <- c(self$ldl, self$hdl, self$trigl)
  if (max(counts) >= 300) {
    max_y <- max(counts)
  } else {
    max_y <- 300
  }
  barplot(height=counts, ylim=c(0, max_y), names=c("LDL","HDL","Triglycerides"),
          main="Cholesterol Readings", xpd=F, yaxp=c(0,max_y,6),
          legend.text=paste0("ID: ", self$id, " Name: ", self$name, " Gender: ", self$gender),
          beside=T, args.legend=list(x="topleft", bty='n', pch=NULL, pt.bg='white'))
}

# This class function prints the Chlor data formatted as in the assignment and with 
#  the symbols for the ldl, hdl, and triglyceride values
print.ChlorReads <- function(self) {
  cat("ID:", self$id, " Name:", self$name, " Gender:", self$gender, "\nLDL:",
      get.ldl(self), " HDL:", get.hdl(self), " Triglycerides:", get.trigl(self), "\n")
}

# generic 
getPatientInfo <- function(self) {
  UseMethod("getPatientInfo", self)
}

# This class accessor function returns the Chlor data as desired in the assignment
getPatientInfo.ChlorReads <- function(self) {
  data <- sprintf("%-06s %-07s %-02s", self$id, self$name, self$gender)
  cat("ID     Name    Gender\n", data, sep="")
}

# generic
getChloresterol <- function(self) {
  UseMethod("getChloresterol", self)
}

# This class accessor function returns the Chlor data as desired in the assignment 
getChloresterol.ChlorReads <- function(self) {
  data <- sprintf("%04i%02i  %-04i", self$ldl, self$hdl, self$trigl)
  cat("LDL HDL Trigl\n",data, sep="")
}

# This takes the filename for a text file containing Chlor data and 
# returns a list of ChlorReads objects corresponding to that data
read_chlor_file <- function(data_filename) {
  df <- read.table(data_filename, header=T)
  lst <- NULL
  for (i in 1:nrow(df)) {
    lst[[i]] <- ChlorReads(df[i,]$id, as.character(df[i, ]$name),
                as.character(df[i, ]$gender), df[i, ]$ldl, df[i, ]$hdl, df[i, ]$trigl)
  }
  return(lst)
}

# This takes a list of ChlorReads objects and prints the Chlor data
print_chlor_data <- function(data_lst) {
  for (item in data_lst) {
    print(item)
    plot(item)
  }
}

# This takes a list of ChlorReads objects and the filename for the output PDF
# and saves plots for all of those ChlorReads objects to that output PDF
plot_to_pdf <- function(data_lst, pdf_filename) {
  my_pdf <- pdf(file=pdf_filename)
  for (item in data_lst) {
    plot(item)
  }
  dev.off()
}

# The following 6 lines provide a simple test of these functions with sample data
p1 <- ChlorReads(9876, "Virgil", "M", 248, 45, 148)
print.ChlorReads(p1)
print(p1)
plot(p1)
getPatientInfo(p1)
getChloresterol(p1)

# These lines handle the bulk of section 5 of the assignment
data_lst <- read_chlor_file('chlor-reads.txt')
print_chlor_data(data_lst)
plot_to_pdf(data_lst, 'TrianoMatt_Assn7_Output_PDF.pdf')








