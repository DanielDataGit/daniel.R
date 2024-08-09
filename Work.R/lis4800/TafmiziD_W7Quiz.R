# Question 1

MyVectorInfo <-function(vector)
{
min <- min(vector)
max <- max(vector)
mean <-mean(vector)
return(c(min, max, mean))
 }

myVector <- c(6,2,4)

MyVectorInfo(myVector)

# Question 5

y <- 3.4321
new_round <-function(p, digits =1)
  {
  round(p, digits)
  }

c(new_round(y))
  
new_round(y, digits= 3)
 
# Question 6
throw_die <- function() {
  number <-sample(1:6, size = 1)
  number
}
throw_die()

# Question 7

worstWithindex <- function(col.index){
  index <- which.min(mtcars[,col.index])
  rnames <- row.names(mtcars)
  car <- rnames[index]
  return(car)
}

worstWithindex(1)


tinyData <-c(1,2,1,2,3,3,3,4,5,4,5)



MyVectorInfo <-function(myVector, ...)
  
{
  
  min <-which.min(myVector)
  
  max <-which.max(myVector)
  
  mean <-mean(myVector)
  
  return(c(min,max,mean))
  
}

MyVectorInfo(tinyData)
MyVectorInfo <- function(vector)
{
  cat("mean:", mean(vector), "\n")
  cat("median:", median(vector), "\n")
  cat("min:", min(vector), " max", max(vector), "\n")
}
MyVectorInfo(tinyData)