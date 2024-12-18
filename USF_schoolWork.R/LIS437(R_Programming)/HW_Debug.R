
tukey_multiple <- function(x) {
  
  outliers <- array(TRUE,dim=dim(x))
  
  for (j in 1:ncol(x))
  {
    outliers[j] <- all(outliers[,j])
  }
  
  outlier.vec <- vector(length=nrow(x))
  
  for (i in 1:nrow(x))
  { 
    outlier.vec[i] <- all(outliers[i,]) 
  } 
  
  return(outlier.vec) 

}

x <- matrix(1:9, ncol = 3)

tukey_multiple(x)
