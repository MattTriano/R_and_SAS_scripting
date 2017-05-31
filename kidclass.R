# KidClass Example 

# Create kid class
setClass("kid", representation(name="character", gender="character",
                               age="numeric"))

# Create constructor for kid class.
kid <- function(thename, thegender, theage) {
  new("kid", name=thename, gender=thegender, age=theage)
}

# Create getter for age.
# First a generic age method must be created if none exists.
# A generic age method cannot be deleted after it is created.
setGeneric("age", function(x) { standardGeneric("age") })

# After generic age method is created, create an age getter 
# for kid class for kid.  Use the @ operator to access the age 
# slot of the object x.
setMethod("age", "kid", function(x) { x@age })

# Create setter for age.
# First a generic age method must be created if none exists.
setGeneric("age<-",  function(x, value) { standardGeneric("age<-") })

# After generic age<- method is created, create an age setter.
setReplaceMethod("age", "kid", 
                 function(x, value) { x@age <- value; x })

# Create getters for name and gender.  If no setters are
# supplied, those fields are read only.
setGeneric("name", function(x) { standardGeneric("name") })
setMethod("name", "kid", function(x) { x@name })
setGeneric("gender", function(x) { standardGeneric("gender") })
setMethod("gender", "kid", function(x) { x@gender })

# Create generic haveBirthday method.
setGeneric("haveBirthday", 
           function(x) { standardGeneric("haveBirthday") })

setMethod("haveBirthday", "kid", 
          function(x) { x@age <- x@age + 1; x })

# Create show method for kid.
# A generic show method already exists, 
# so don't need to create one.
setMethod("show", "kid", function(object) { 
  cat(object@name, object@gender, object@age, "\n") 
})

# Instantiate kid object k and test its methods.
k <- kid("Alice", "F", 11)
show(k)
print(name(k))
print(gender(k))
print(age(k))
k <- haveBirthday(k)
show(k)