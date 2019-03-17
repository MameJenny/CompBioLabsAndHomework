#---Lab 07
#
# Problem 1: creating a function to calculate the area of a triangle
#
# area of a triangle: 0.5 * base * height

# creating a function to use this equation given height and base data
triangleArea <- function(r,t)  { # calculate the area of a triangle by multiplying 0.5 * base * height; base and height numerical values must be given
  area <- (( r * t ) * 0.5) # multiply (base times height) times 0.5
  return ( area ) # returns area of the triangle
}


triangleArea(10,9) # testing the above function using sample height/base numbers



# Problem 2: creating a function to return the absolute value of a given number 
myAbs <- function(o) { # myAbs displays the positive, absolute value of a given number
    if ( o > 0) { # if given sum is greater than 0,
    return( o  ) # return the sum, already greater than 0 
  } else { # or else, if the sum is less than 0, 
    return ( o * -1) # return the absolute value of the negative number
  }
}

 myAbs(-5) # shows absolute value of 5 is 5
 myAbs(-2.3) # shows absolute value of -2.3 is 2.3
 
 testVector <- c(1.1, 2, 0, -4.3, 9, -12) # vector of sample numbers to obtain the absolute values
 
 myAbsVector <- function(testVector, threshold = 0 ) { # myAbsvector displays the positive, absolute value of a given number if the numbers are in a numeric vector
   for (i in 1:length(testVector)) { # for a vector of 1 to length of the test vector
    if ( testVector[i] > 0) { # if given sum is greater than 0,
     testVector[i] <- ( testVector[i] ) # return the number in position i, already greater than 0 
   }  else { # or else, if the sum is less than 0, 
     testVector[i] <- ( testVector[i] * -1) # return the number in position i multiplied by -1
   }
  }
   return (testVector) # return the vector of absolute values
 } 
 
 myAbsVector(testVector) # prints positive absolute values of testVector
 
 
 # Problem 3

 fibo <- function(a, b) {
   Fibonacci <- c(0,length(b)) # creating an empty vector with 20 values for storing data
     Fibonacci[c(1,1)] <- a # assigning first number to be a, chosen by user
     Fibonacci[c(2,2)] <- 1 # assigning second Fibonacci number
     error_msg <- print("Error: Number of requested values cannot be less than 2!")
   for ( i in 3:length(Fibonacci) ) { # creates a vector of the fibonacci sequence 
     Fibonacci[c(i)] <- (Fibonacci[(i - 2)] + Fibonacci[(i - 1)]) # to the position i in Fibonacci vector, assign the sum of number in i-1 plus number in i-2
   } 
   if (b < 2 ) {
     print(error_msg) # this if statement returns an error message if the number chosen for "b" is less than 2
  # returns a vector of numbers >= b
   return(Fibonacci)
 }
 fibo(1, 3)
 
 myFibo <- function(init, length_int) {
   fibo_data <- rep(0, length_int) # creates an empty vector of requested length
   error_msg <- c("Error: Number of requested values cannot be fractional or less than 3!")
   if(length_int > 2 && length_int == round(length_int)) { # if requested number is greater than 2 and an integer, return fibonacci sequence
   fibo_data[c(1,1)] <- init # starting number chosen by user
   fibo_data[c(2,2)] <- 1 # second number of Fibonacci sequence (must be 1)
   for ( i in 3:length_int ) { # creates a vector of the fibonacci sequence 
     fibo_data[c(i)] <- (fibo_data[(i - 2)] + fibo_data[(i - 1)]) # to the position i in Fibonacci vector, assign the sum of number in i-1 plus number in i-2
    } 
   return(fibo_data)
   } else { # if requested number of values is a fraction or less than 3, return an error message
      print(error_msg)
  }
 }
 
 myFibo(0,25)
 
# ---Problem 4
# 4.a
 difference_sq <- function(x, y) { # takes the difference of values a and b and squares them
   quantitySquared <- ((x - y)^2)
   return(quantitySquared) # returns result of above calculation
 }
 
 difference_sq(3,5) # testing with numbers 3 and 5
 difference_sq(c(2, 4, 6), 4) # testing with a vector and the number 4

 # - 4.b
 #
 averageArithmetic <- function(m) { # takes the sum of the values in a vector and divides the sum by the count (length of vector)
   avg <- (sum(m)/length(m))
   return(avg) # returns arithmetic average
 }
 
 test_avg_vector <- c(5,15,10) # creating a vector to test above function
 averageArithmetic(test_avg_vector) # testing with above vector
 
 # importing lab 07 data to test above function
 DataLab07 <- read.csv("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab07/DataForLab07.csv")

  DataLab07_vector <- as.vector(DataLab07$x) # saving above data as a vector instead of a data frame
 averageArithmetic(DataLab07_vector) # average value of 108.9457
 
 # - 4.c
 #
 sumSquare <- function(z) { # for a given vector, takes the sum of the squared deviations from the mean
   sum_sq <- sum((z - averageArithmetic(z))^2)
   return(sum_sq) # returns result of above calculation
 }
 
sumSquare(DataLab07_vector) # testing sumSquare on the above lab data vector
