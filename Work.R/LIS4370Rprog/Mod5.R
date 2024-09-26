#install.packages("matlib")
library(matlib)


A <- matrix(1:100, nrow=10)
B <- matrix(1:1000, nrow=10)

#check determinants
det(A)

#det(B) returns error since it is not a square matrix

#psuedo inverse given singularity
invA <- Ginv(A)

#pseudo inverse given rectangular shape
invB <- Ginv(B)

