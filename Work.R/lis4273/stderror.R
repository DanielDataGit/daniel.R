#These questions are formed based on the textbook. All the answers should be inferred from the assigned text book reading.
#Using a sample data points provided below, construct a sampling distribution. Calculate the standard error and use this to calculate the 2.5% and 97.5% distribution cut points. The data points are provided below. 
getwd()
#1. create a vector using the provided data points: (800.64, 217.53, 74.58, 498.6, 723.11, 69.43, 40.15, 58.61, 364.63, 44.31, 216.41, 157.92, 1044.4, 82.3, 90.21, 59.09, 361.38, 37.32, 311.34, 90.84, 580.64, 274.31, 215.06, 202.99)
data <- c(800.64, 217.53, 74.58, 498.6, 723.11, 69.43, 40.15, 58.61, 364.63, 44.31, 216.41, 157.92, 1044.4, 82.3, 90.21, 59.09, 361.38, 37.32, 311.34, 90.84, 580.64, 274.31, 215.06, 202.99)
#2. calculate the standard error of the mean
length(data)
std <- sd(data)/sqrt(24)
#3. use the standard error to calculate the 2.5% and 97.5% distribution cut points.
dm <- mean(data)
cut975 <- dm + (2*std)
cut025 <- dm - (2*std)

