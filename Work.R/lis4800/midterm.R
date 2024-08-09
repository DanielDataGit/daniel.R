Pets <- c(1,1,1,0,0)
Order <- c(3,1,2,3,3)
# create a numeric vector 'Siblings'
Siblings <- c(0,3,5,0,0)
# create a numeric vector 'IDs'
IDs <- c(1,2,3,4,5)
# comebine those four numeric vectors together into a dataframe called 'myFriends'
myFriends <- data.frame(IDs,Pets,Order,Siblings)
names <-c("jeff", "jen", "joe", "sunny", "jane")
jeff <-34
 pat <-35
ages <-c(jeff, pat)
 ages

jeff <-jeff - 5
jeff

 ages[1]
 
printVecInfo(printVecInf) 
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
split_math <- strsplit(pioneers, split = ":")
str(split_math)
myFriends[2,4]

myFamilyName <- c("John","Cate","Troy","Sonia")
myFamilyAge <- c(23,12,45,43)
myFamily <- data.frame(myFamilyName, myFamilyAge)

testFrame <- read.csv("C:\\Users\\dtafm\\Downloads\\testFrame.csv", stringsAsFactors = FALSE)
View(testFrame)
cnames <- colnames(testFrame)
cnames
cnames[1]<- ""
cnames[2]<- "Census"
cnames[3]<- "Base"
cnames[4]<- "Census2010"
cnames[5]<- "Census2011"
colnames(testFrame)<-cnames
head(testFrame)

num <- c("4000", "2000")
as.numeric(num)
