# 1.
#Your data.frame is
assignment_data <- data.frame( Country = c("France","Spain","Germany","Spain","Germany", "France","Spain","France","Germany","France"), age = c(44,27,30,38,40,35,52,48,45,37), salary = c(6000,5000,7000,4000,8000), Purchased=c("No","Yes","No","No","Yes", "Yes","No","Yes","No","Yes"))

#Generate simple table in R that consists of four rows: Country, age, salary and purchased.

install.packages("data.table")       
library(data.table)

table <- setDT(assignment_data) #turns data frame into table
table

Country   age salary Purchased
    <char> <num>  <num>    <char>
1:  France    44   6000        No
2:   Spain    27   5000       Yes
3: Germany    30   7000        No
4:   Spain    38   4000        No
5: Germany    40   8000       Yes
6:  France    35   6000       Yes
7:   Spain    52   5000        No
8:  France    48   7000       Yes
9: Germany    45   4000        No
10:  France    37   8000      Yes

#2. Generate contingency table also know as rx C table using mtcars dataset.


assignment9 <- table(mtcars$gear, mtcars$cyl, dnn=c("gears"))
                                                     
# 2.1 Add the addmargins() function to report on the sum totals of the rows and columns of assignment9 table >
 
addmargins(assignment9) # table aligns cars with gears 3,4,or 5 and cyl 4,6, or 8.

gears  4  6  8 Sum
3      1  2 12  15
4      8  4  0  12
5      2  1  2   5
Sum   11  7 14  32
                                                     
2.2 Add prop.tables() function, and report on the proportional weight of each value in a assignment9 table

prop.table(assignment9) # calculates proportion of each cell by sum of all cells. Allows us to see what most car cyl and gear amounts are.
# Most common combination is 8 cyl with 3 gears, followed by 4 cyl 4 gears
# Least common combination is 8 cyl with 4 gears, followed by 4 cyl 3 gears and 6 cyl 5 gears(thats what I drive :)

gears       4       6       8
3       0.03125 0.06250 0.37500
4       0.25000 0.12500 0.00000
5       0.06250 0.03125 0.06250
                                                     
2.3 Add margin = 1 to the argument under prop.table() function, and report on the row proportions found in assignment9 table.

prop.table(assignment9, margin = 1)   #calculates porportion of each cell by sum of its row.
# This allows us to easily see which cylinder amount is most common with each gear amount.

# Cars with three gears use 8 cyl, 6 cyl, 4 cyl in descending order
# Cars with four gears use 4 cyl, 6 cyl in descending order
# Cars with 5 gears use 8 or 4 cyl, 6 cyl in descending order

gears          4          6          8
3        0.06666667 0.13333333 0.80000000
4        0.66666667 0.33333333 0.00000000
5        0.40000000 0.20000000 0.40000000
                                                  