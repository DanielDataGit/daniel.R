# 1)

A = matrix(c(2,0,1,3), ncol = 2 ) 

B = matrix(c(5,2,4,-1), ncol = 2 ) 
         
A + B

A - B

# 2)

diag(c(4,1,2,3))

# 3)

x = diag(3,5)

x[1, 2:5] = 1

x[2:5, 1] = 2

x


