# ------- WIP Final project
# ---------- DO NOT SUBMIT ----------
#
#
#
# -- Required packages for this analysis
library("ggplot2")
library("tidyverse")
install.packages("dplyr")

# -- Setting working directory for image saving purposes
setwd("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work")


# -- PT 1.1: Making a plot of mean biomass per year for the years 1989-2016

# import biomass data

  init_data <- read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/pone_data_s1.csv")
  head(init_data)
# naming columns for better readability
  names(init_data) <- c("A_", "Year", "C_", "D_", "E_", "F_", "Biomass", "H_", "I_", "J_", "K_", "L_")
# removing rows with NA values  
  naRow <- which(is.na(init_data$Biomass))
  init_data <- init_data[-naRow, ]
  
  
# using ggplot, sorting biomass and taking the mean for each year
  avg_year_Biomass <- init_data %>%
    group_by( Year, Biomass ) %>%
    summarise( meanBiomass = mean(Biomass))
  
  avg_year_Biomass_grouped <- avg_year_Biomass %>%
    group_by( Year ) %>%
    summarise( byYear_meanBiomass = mean(meanBiomass))

# making a plot of biomass per year with a trendline  
  avg_biomass_grouped_plot  <- ggplot(avg_year_Biomass_grouped, aes(x = Year, y=byYear_meanBiomass, color = Year)) + 
    geom_point() 
  avg_biomass_grouped_plot <- avg_biomass_grouped_plot + geom_smooth(method = "lm", color = "darkred")

  avg_biomass_grouped_plot <- avg_biomass_grouped_plot + labs(y = "Mean Dry Biomass (grams)", x="Year",
       title = "Biomass Trends from 1989-2016")
  
  png(filename="Figure1_biomass_mean_perYear.png")
  avg_biomass_grouped_plot
  dev.off()
  
# ------ Note for data in part 1: Insect biomass data was not recorded in the years 2002 or 1996. Therefore, associated agricultural data must be adjusted to delete these values. 
  missing <- c(1996,2002) # missing years
# -- Pt 1.2: Making a plot of cereal yield per hectare
#
# loading in cereal per hectare data
 cereal_per_hectare <-  read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/cereal_yield_per_hectare.csv")
# removing data from missing years
  missing_cereal_yr <- which(cereal_per_hectare$Year == missing[1] | cereal_per_hectare$Year == missing[2])
  cereal_per_hectare <- cereal_per_hectare[-missing_cereal_yr, ]

# plot of cereal production (kg per hectare) for 1989-2016 (excl. 2002 and 1996)
#basic plot: graph type, aesthetic, colors
  cereal_hectare_plot <- ggplot(cereal_per_hectare, aes(x = Year, y = Crop.production..kg.hectare., color = Year)) + 
                                  geom_point()
#trendline
  cereal_hectare_plot <- cereal_hectare_plot + geom_smooth(method = "lm", color = "darkred")
#x and y axis labels and title   
  cereal_hectare_plot <- cereal_hectare_plot + labs(y = "Cereal Grain Yield avg. (kg/hectare)", x="Year",
                                                              title = "Cereal Yields from 1989-2016")
  
#axis limits and tick mark modification
  cereal_hectare_plot <-  cereal_hectare_plot + scale_x_continuous(breaks = round(seq(min(cereal_per_hectare$Year), max(cereal_per_hectare$Year), by = 1),1)) 
#x axis font and angle modification  
  cereal_hectare_plot <- cereal_hectare_plot + theme(axis.text.x = element_text(color="#000000", size=9, angle=40))
  
                                                                                                                                                                       
# saving image of plot for use in markdown document                                                                                                                                                                    
  png(filename="Figure2_cereal_production_kgPerhectare.png")
  cereal_hectare_plot
  dev.off()
                                                                                                                                                                       
  
# -- Pt 1.3: making a plot of agricultural area percentage 

  percent_agricultural_area <-  read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/land_use_percentages.csv")

  missing_area_yr <- which(percent_agricultural_area$Year == missing[1] | percent_agricultural_area$Year == missing[2])
  percent_agricultural_area <- percent_agricultural_area[-missing_area_yr, ]
  
  agricultural_area_plot <- ggplot(percent_agricultural_area, aes(x = Year, y = X..Land.usage, color = Year)) + 
    geom_point()
  agricultural_area_plot <- agricultural_area_plot + geom_smooth(method = "lm", color = "darkred")
  
  png(filename="Figure3_agricultural_percent_use.png")
  agricultural_area_plot
  dev.off()
  
# -- Pt 1.4: comparison of plots
  
# -- Pt 1.5: statistical analysis of plots

# -- Pt 1.6: Statistical anomalies (high biomass years) vs. cereal production trends
  
# -- Pt 2.1: making plots of temperature data for given timeframe

# -- Pt 2.2: comparing temperature trends to biomass trends
  
  init_weather_data <- read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/pone_data_s2.csv")
  head(init_weather_data)  
  
  naRow_weather <- which(is.na(init_weather_data$temperature))
  init_weather_data <- init_weather_data[-naRow_weather, ]
  
  avg_year_Temperature <- init_weather_data %>%
    group_by( year, temperature) %>%
    summarise( meanTemperature = mean(temperature))
  
  avg_year_Temperature_grouped <- avg_year_Temperature %>%
    group_by( year ) %>%
    summarise( byYear_meanTemperature = mean(meanTemperature))
  
  # plot of average temperature (degrees Celsius) for 1989-2016 (excl. 2002 and 1996)
  #basic plot: graph type, aesthetic, colors
  mean_temperature_plot <- ggplot(avg_year_Temperature_grouped, aes(x = year, y = byYear_meanTemperature, color = year)) + 
    geom_point()
  #trendline
  mean_temperature_plot <- mean_temperature_plot + geom_smooth(method = "lm", color = "darkred")
  #x and y axis labels and title   
  mean_temperature_plot <- mean_temperature_plot + labs(y = "Mean Temperature (degrees Celsius)", x="Year",
                                                    title = "Mean Temperature for Years 1989-2016")
  
  #axis limits and tick mark modification
  mean_temperature_plot <-  mean_temperature_plot + scale_x_continuous(breaks = round(seq(min(avg_year_Temperature_grouped$year), max(avg_year_Temperature_grouped$year), by = 1),1)) 
  #x axis font and angle modification  
  mean_temperature_plot <- mean_temperature_plot+ theme(axis.text.x = element_text(color="#000000", size=9, angle=40))
  