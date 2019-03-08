#---Lab 08
#
# step 3: turning the discrete time equation into a function
discreteTime <- function(r,K,t,n) {
for(i in 2:t) {
  n[c(i)] <- (n[i-1] + (r * n[i-1] * ((K - n[i-1]) / K))) # to population value at time step=i (min 2), assigning the value obtained via discrete-time logistic growth expression
}
  Abundance <- n # saving y axis for use in matrix
  Generations <- c(1:t) # saving x axis for use in matrix
  discreteMatrix <- cbind(Generations,Abundance) # creating matrix of above data, which will be returned to the user of the function
  plot( 1:t, n,  
        main="Population Growth According to Discrete Time Equation", # title
        ylab = "Population size", # y axis label
        xlab= "Number of generations", # x axis label
        cex = 1.0, # size of data points
        pch = 19, # type of data point
        col = "red"  # data point color
  )
  return(discreteMatrix) # returns population data, and a plot of population size as a function of number of generations
}

discreteTime(0.8,10000,30,50) # testing above function

myAbundance <- discreteTime(0.8,10000,20,50) # saving a vector to use for saved matrix

# setting working directory
setwd("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab08")

# saving the above matrix to the disk
write.csv(myAbundance, file = "DiscreteData_Lab08.csv", row.names = FALSE)


# saving the plot from the above function to the disk
png(filename="discretePlot_lab08.png")
plot ( myAbundance,
            main="Population Growth According to Discrete Time Equation", # title
            ylab = "Population size", # y axis label
            xlab= "Number of generations", # x axis label
            cex = 1.0, # size of data points
            pch = 19, # type of data point
            col = "red"  # data point color
)
dev.off()

