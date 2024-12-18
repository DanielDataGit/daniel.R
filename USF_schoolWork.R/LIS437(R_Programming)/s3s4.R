# 1)
# Create an S3 object and assign the class to it
student_s3 <- list(name = "Daniel", age = 20, gpa = 4.0)
class(student_s3) <- "student"

# Define a print method for the 'person' class
print.person <- function(x) {
  cat("Name:", x$name, "\nAge:", x$age, "\nGPA:", x$gpa)
}

# print it
print(student_s3)

################################################################################
# 2)
# Define an S4 class with elements name, age, gpa
setClass("Student",
         slots = list(
           name = "character",
           age = "numeric",
           gpa = "numeric"
         ))

# Create an instance of the S4 class 'Person'
student_s4 <- new("Student", name = "Daniel", age = 20, gpa = 4.0)

# Define a method for printing objects of class 'Person'
setMethod("show", "Student", function(object) {
  cat("Name:", object@name, "\nAge:", object@age, "\nGPA:", object@gpa)
})

# Use the generic 'show' function (automatically called when printing)
student_s4