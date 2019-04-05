#---- Lab 11 -----
#
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
# taking mean for each species

# trying to use aggregate() and mean 
by_groups <- aggregate(densityData[, 2:4], list(densityData$Family), mean)
head(by_groups)

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

most_dense_rows <- (density_low_to_high$Family %in% most_dense_families)
cat(paste("\ Densest species = ", sum(most_dense_rows), "\n"))
most_dense_families <- density_low_to_high[most_dense_rows, ]

top_density_plot_data <- as.data.frame(most_dense_families)

top_plot <- ggplot(top_density_plot_data, aes(x = Family, y = Wood_Density) 
                + geom_boxplot() 
                + facet_wrap(facets = ~Family, scale="free"))


        