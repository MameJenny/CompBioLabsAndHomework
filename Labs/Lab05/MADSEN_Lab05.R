#----Lab 05----
#
#--Part 1--
#
# step 1: creating a variable with a numeric value 
x <- 4

if ( x >= 5 ) { 
  print("Value is equal to or larger than 5") # if value of x >= 5, print message to console
} else {
  print ("Value is smaller than 5") # or else, if value of x < 5, print message to console
}

# step 2.a: importing data set and creating a for loop to replace negative values with NA

Step2Data <- read.csv("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab05/Vector1.csv")
NewVector <- Step2Data

 for(i in 1:length(NewVector$x)) { 
  if( NewVector$x[i] < 0 ) { # if value is less than 0, replace with NA
    NewVector$x[i] <- NA
  }
}

# step 2.b: replacing previously created NA values with NaN using vectorized code

is.na(NewVector) # checks for NA values (true/false)

NewVector[is.na(NewVector)] <- NaN # convers NA to NaN in NewVector


# step 2.c: using a which statement and indexing, replacing previously created NaN values with 0

is.nan.data.frame <- function(x)
  do.call(cbind, lapply(x, is.nan)) # making is.nan work correctly on a data frame

NewVector$x[which(is.nan(NewVector$x))] <- 0 # converting NaN to 0
print(NewVector)

# SMF: to use the which statement, you could do:
# SMF: NewVector$x[which(is.nan(NewVector$x))] <- 0

# step 2.d: seeing how many values fall between 50 and 100

NumbersFifty100 <- which(NewVector < 100 & NewVector > 50 ) # shows values between 50 and 100
Count <- length(NumbersFifty100)  # number of values in NumbersFifty100
UpperLimit <- 100 # upper limit for this test
LowerLimit <- 50 # lower limit for this test

FiftyToOneHundred <- NewVector$x[NewVector$x < UpperLimit & NewVector$x > LowerLimit] # creates a vector of all values between 50 and 100

write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred.csv") # creating a csv with above data

# step 3.a: importing CO2 data and finding first year in which CO2 emissions > 0 
Step3Data <- read.csv("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab05/CO2_data_cut_paste.csv")

FirstGasNonZero <- which(Step3Data$Gas > 0) # this indicates that the first value with a gas emission > 0 was in position 135
print(FirstGasNonZero)
FirstRowValue <- FirstGasNonZero[1] # the first row number in which gas is > 0, as seen in previous step

FirstGasNonZero <- Step3Data$Year[FirstRowValue] 
print(FirstGasNonZero) # shows that the first year was 1885

#step 3.b: finding the years in which total emissions were between 200 and 300 million metric tons

YearsBetween200_300 <- which(Step3Data$Total > 200 & Step3Data$Total < 300) # indicates that 9 years, between position 129 and 137, were between 200 and 300 tons
print(YearsBetween200_300)

YearRowValues <- YearsBetween200_300 # the row values in which above condition is met

YearsBetween200_300 <- Step3Data$Year[YearRowValues]
print(YearsBetween200_300) # shows that emissions were between 200 and 300 million metric tons between 1879 and 1887

#---Part II
#
# step 1: creating needed vectors
totalGenerations <- 1000 # number of generations
initPrey <- 100 	# initial prey abundance at time t = 1
initPred <- 10		# initial predator abundance at time t = 1
a <- 0.01 		# attack rate
r <- 0.2 		# growth rate of prey
m <- 0.05 		# mortality rate of predators
k <- 0.1 		# conversion constant of prey into predators
t <- seq(1:totalGenerations) # time, assuming 1 generation = 1 time step
n <- rep(initPrey, totalGenerations) # vector to store results of n over time
p <- rep(initPred, totalGenerations) # empty vector to store results of p over time

for(i in 2:totalGenerations) {
  n[i] <- (n[i-1] + (r * n[i-1]) - ((a * n[i-1]) * p[i-1]))  # applies equation to n
  p[i] <- (p[i-1] + ( k * a * n[i-1] * p[i-1] ) - ( m * p[i-1] )) # applies equation to p
  if (n[i] < 0) {
    n[i] <- 0  
  } 
  if (p[i] < 0 ) { # these if statements remove values less than 0 and replace them with 0 
    p[i] <- 0 
  }
}


# creating a plot of predator/prey abundance over time
plot( t, n,  
     main="Predator/Prey Abundance Over Time", # title
     ylab = "Predator/prey abundance", # y axis label
     xlab= "Number of generations", # x axis label
     ylim = c(1,1000), # y axis numeric limit
     xlim = c(1,1000), # x axis numeric limit
     cex = 0.5, # size of data points
     col = "red"  # data point color
     )
# adding lines for predator abundance
lines(t, p,
      lwd = 3.0,
      ) 
# adding a legend to the graph
legend( "topright", legend=c("Prey abundance", "Predator abundance"), # names
        lty = 1.0, # line type
        lwd = 2.0, # line width
        col = c("red", "black") # colors in legend
        ) 

# creating a matrix of results from equation
myResults <- cbind(t, n, p) # creating a matrix with 3 columns using above predator/prey data
colnames(myResults) <- c("TimeStep","PreyAbundance","PredatorAbundance")  # changing matrix column names

setwd("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab07")
write.csv(myResults, file = "myResults.csv", row.names = FALSE)

