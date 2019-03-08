# Discrete Time Logistic Growth Model Function for R
This function can be accessed using the [following R script](MADSEN_Lab08.R): 
>discreteTime <- function(r,K,t,n) {
for(i in 2:t) {  
  n[c(i)] <- (n[i-1] + (r * n[i-1] * ((K - n[i-1]) / K)))  
}  
  Abundance <- n  
  Generations <- c(1:t)  
  discreteMatrix <- cbind(Generations,Abundance)  
  plot( 1:t, n,  
        main="Population Growth According to Discrete Time Equation",  
        ylab = "Population size",   
        xlab= "Number of generations",   
        cex = 1.0,   
        pch = 19,   
        col = "red"    
  )  
  return(discreteMatrix) # returns population data, and a plot of population size as a function of number of generations  
}  

### How discreteTime works:  
This function applies the [discrete time logistic growth equation](https://vlab.amrita.edu/?sub=3&brch=65&sim=1110&cnt=1) to a given starting population:
>n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )

#### Definitions: 

 - n is initial population abundance (population size). 
 - t is number of generations, or "time steps."
 - K is the [biological carrying capacity](https://en.wikipedia.org/wiki/Carrying_capacity). 
 - r is the growth rate per generation. 
### Using the function
To apply the function to given population data, the following numerical values must be provided, in order: r, K, t, and n. The function can be called using the following general setup: 
> discreteTime(r, K, t, n) 

This will produce a plot as shown: 
![Sample plot](https://i.imgur.com/Im5iuBi.png)

### Modifying your discreteTime data
#### 1. Producing a CSV file
If you need to save your population growth data as a data matrix of abundance per generation, first set your working directory with `setwd()`, then add the following code after the function: 
> myAbundance <- discreteTime(r, K, t, n)   
> write.csv(myAbundance, file = "DiscreteData_Lab08.csv", row.names = FALSE)  

####  2. Modifying your plot
The function contains a plot with a pre-set design, which will print to the R console. The following values can be altered to produce a custom graph: 
>  plot( 1:t, n,  
        main="Population Growth According to Discrete Time Equation", # title  
        ylab = "Population size",  # y axis label  
        xlab= "Number of generations",  # x axis label  
        cex = 1.0, # size of data points  
        pch = 19, # type of data point  
        col = "red"  # data point color  
  )  
 #### 3. Saving your plot to disk 
 If you wish to save your plot from the R console to the disk, the following code can be used: 
 > myAbundance <- discreteTime(r, K, t, n)  
 > png(filename="discretePlot.png")  
plot ( myAbundance  
)  
dev.off()  

The plot saved using this method can also be modified as shown in part 2.  



