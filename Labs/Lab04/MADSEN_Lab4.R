#----Lab 04
#
# step 1: creating a for loop for "hi" repeated 10 times
for( i in 1:10) {
  print("hi")
}

# step 2: creating a for loop for Tim's money every week
StartingMoney <- 10 # his starting money
WeeklyAllowance <- 5 # his weekly allowance
PackGumCost <- 1.34 # weekly pack of gum cost
WeekChange <- (StartingMoney + WeeklyAllowance) - PackGumCost # week 1 money change
WeeklyChange <- WeeklyAllowance - PackGumCost # change in money every week after week 1
for(i in 1:8 ) {
  WeekChange <- WeekChange + WeeklyChange # adding weekly money change to previous week's money
  print(WeekChange)
}

# step 3: creating a for loop for 5% population shrinkage every year
CurrentPop <- 2000 # current population size (individuals)
ShrinkageRate <- 0.05 # 5% yearly shrinkage, in decimals

for(i in 1:7) {
   CurrentPop <- CurrentPop - (ShrinkageRate*CurrentPop) # looping to print new population minus yearly shrinkage
  print(CurrentPop)
}

# step 4: using for loop for analyzing t=12 values for equation n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K ) given t=1 values
n <- rep(0,12) # vector of zeros for population abundance data storage
n[c(1,1)] <- 2500 # assigning a value of 2500 to n = 1 (initial population abundance)
t <- c(1:12) # time
K <- 10000 # environmental carrying capacity
r <- 0.8 # intrinsic growth rate of population
#-- equation of interest: n[12] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )
for(i in 2:12) {
  n[c(i)] <- (n[i-1] + (r * n[i-1] * ((K - n[i-1]) / K))) # to population value at time step=i (min 2), assigning the value obtained via discrete-time logistic growth expression
  print(n)
}
#
#---Part II
#
# step 5.a: creating a vector of 18 zeros
Empty18 <- rep(0, 18)
# step 5.b: creating a for loop that stores 3 times the ith value of the iterator variable
for ( i in 1:18 ) { 
  Empty18[c(i)] <- 3 * i
  print(Empty18)
}
# step 5.c: creating another vector of 18 zeros, and making the first value =1 
AnotherEmpty18 <- rep(0,18)

AnotherEmpty18[c(1,1)] <- 1 # assigning first number as 1
# step 5.d: creating a for loop that adds one plus twice the value of the previous entry to each entry of AnotherEmpty18, beginning at the second value
for ( i in 2:18 ) {
  AnotherEmpty18[c(i)] <- (1 + 2*AnotherEmpty18[(i-1)]) # to the position i in AnotherEmpty18, assigning the number obtained through 1+2*(previous value)
  print(AnotherEmpty18)
}
# step 6: creating a for loop that creates a vector of the first 20 Fibonacci Sequence numbers
Fibonacci <- rep(0,20) # creating an empty vector with 20 values for storing data
Fibonacci[c(1,1)] <- 1 # assigning first two Fibonacci numbers
Fibonacci[c(2,2)] <- 1

for ( i in 3:20 ) {
  Fibonacci[c(i)] <- (Fibonacci[(i-2)] + Fibonacci[(i-1)]) # to the position i in Fibonacci vector, assign the sum of number in i-1 plus number in i-2
  print(Fibonacci)
}
# step 7: creating a plot for data compiled in step 4
# --note about this step: the calculated numbers from step 4 were already saved into the vectors n (population abundance) and t (time step). Therefore, it is not needed to repeat the step here

plot(t, n)