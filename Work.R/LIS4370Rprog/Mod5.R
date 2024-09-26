#install.packages("matlib")
library(matlib)
#install.packages("MASS")
library(MASS)

A <- matrix(1:100, nrow=10)
B <- matrix(1:1000, nrow=10)

#check determinants
det(A)

#det(B) returns error since it is not a square matrix

#psuedo inverse given singularity
invA <- ginv(A)

#pseudo inverse given rectangular shape
invB <- ginv(B)

