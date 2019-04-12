#---- Lab 11 -----
#
#
# -- Installing packages
library("ggplot2")
library("tidyverse")
install.packages("dplyr")
# -- part 1
# uploading csv
densityData <- read.csv("C://Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab11/GlobalWoodDensityDatabase.csv", stringsAsFactors = F)
# the NA is in row 12150
names(densityData) <- c("Number", "Family", "Binomial", "Wood_Density", "Region", "Reference")
naRow <- which(is.na(densityData$Wood_Density))

# -- part 2
#
# removing the NA
densityData <- densityData[-naRow, ]

# using summarise_at() and group_by() to make a new table with mean density for each species
tbl_by_groups <- densityData %>%
  group_by(Family, Binomial) %>%
  summarise_at(vars(-Region, -Reference, -Number), funs(mean(., na.rm=TRUE)))

# finding most and least dense families using group_by, summarise() and arrange()

most_dense_families <- densityData %>%
  group_by(Family) %>%
  summarise_at(vars(-Region, -Reference, -Number, -Binomial), funs(mean(., na.rm=TRUE)))

density_low_to_high <- arrange(most_dense_families, Wood_Density) 
least_dense <- head(density_low_to_high, 8) # The lowest density families
print(least_dense)
most_dense <- tail(density_low_to_high, 8) # The highest density families
print(most_dense)

# making a box plot of most dense species 


top_families_plot <- ggplot(most_dense, aes(x = Family, y = Wood_Density, color = Family)) + 
  geom_boxplot() 

# top families plot: adding x and y axis labels and title
top_families_plot <- top_families_plot + labs(y = "Density (g/cubic cm)", 
                      title = "Species with highest wood density" )
# top families plot: flipping axis labels
top_families_plot <- top_families_plot + theme(axis.text.x = element_text(face="bold", color="#000000", 
                                     size=8, angle=50),
          axis.text.y = element_text(face="bold", color="#000000", 
                                     size=8, angle=40))
#top families plot: changing y limits so that graph is easier to read
top_families_plot <- top_families_plot + scale_y_continuous(limits=c(0.75, 1.00) )
top_families_plot

# making a boxplot of most dense species
bottom_families_plot <- ggplot(least_dense, aes(x = Family, y = Wood_Density, color = Family)) + 
  geom_boxplot() 

# bottom families plot: adding x and y axis labels and title
bottom_families_plot <- bottom_families_plot + labs(y = "Density (g/cubic cm)", 
                                              title = "Species with lowest wood density" )
# bottom families plot: rotating x and y axis labels and changing text size
bottom_families_plot <- bottom_families_plot + theme(axis.text.x = element_text(face="bold", color="#000000", 
                                                     size=8, angle=50),
                          axis.text.y = element_text(face="bold", color="#000000", 
                                                     size=8, angle=40))
# changing y axis limits so that graph displays better
bottom_families_plot <- bottom_families_plot + scale_y_continuous(limits=c(0.195, 0.32))
bottom_families_plot
