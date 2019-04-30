# Melisande Madsen
# Final Project
# Computational Biology
# Submitted 30 April 2019
#
#
# -- Required packages for this analysis

library(Hmisc) # for making a correlation matrix
library(corrplot) # for visualization of correlation matrix
library(tidyverse) # for formatting data
library(ggplot2)# for making plots
library(dplyr) # for formatting data
library(ggpubr) # for plot display

# -- Setting working directory for image saving purposes
setwd("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/FinalProject/Assignment_9")

# --- PT 1.1: Making a plot of mean biomass per year for the years 1989-2016

# importing biomass data

  init_data <- read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/FinalProject/Assignment_9/pone_data_s1.csv")
# removing rows with NA values  
  naRow <- which(is.na(init_data$biomass))
  init_data <- init_data[-naRow, ]
  
# using tidyverse, sorting biomass and taking the mean for each year
  avg_year_Biomass <- init_data %>%
    group_by( year, biomass ) %>%
    summarise( meanBiomass = mean(biomass))
  
  avg_year_Biomass_grouped <- avg_year_Biomass %>%
    group_by( year ) %>%
    summarise( byYear_meanBiomass = mean(meanBiomass))
# fixing capitalization of names
  names(avg_year_Biomass_grouped) <- c("Year", "byYear_meanBiomass")

# making a plot of biomass per year with a trendline  
  avg_biomass_grouped_plot  <- ggplot(avg_year_Biomass_grouped, aes(x = Year, y=byYear_meanBiomass, color = Year)) + 
    geom_point() 
# trendline
  avg_biomass_grouped_plot <- avg_biomass_grouped_plot + geom_smooth(method = "lm", color = "darkred")
# title and axis labels
  avg_biomass_grouped_plot <- avg_biomass_grouped_plot + labs(y = "Mean Dry Biomass (grams)", x="Year",
       title = "Biomass Trends from 1989-2016")
  
# axis limits and tick mark modification
  avg_biomass_grouped_plot <-  avg_biomass_grouped_plot + scale_x_continuous(breaks = round(seq(min(avg_year_Biomass_grouped$Year), max(avg_year_Biomass_grouped$Year), by = 1),1)) 

  avg_biomass_grouped_plot <-  avg_biomass_grouped_plot + scale_y_continuous(breaks = round(seq(min(avg_year_Biomass_grouped$byYear_meanBiomass), max(avg_year_Biomass_grouped$byYear_meanBiomass), by = 10),1)) 
  
#x axis font and angle modification  
  avg_biomass_grouped_plot <- avg_biomass_grouped_plot + theme(axis.text.x = element_text(color="#000000", size=9, angle=90))
  avg_biomass_grouped_plot
  
# saving image  
  png(filename="biomass_mean_perYear.png")
  avg_biomass_grouped_plot
  dev.off()
  
# ------ Note for data in part 1: Insect biomass data was not recorded in the years 2002, 1998, or 1996. Therefore, associated agricultural data must be adjusted to delete these values. 
  missing <- c(1996,1998,2002) # missing years
# -- Pt 1.2: Making a plot of cereal yield per hectare
#
# loading in cereal per hectare data
 cereal_per_hectare <-  read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/FinalProject/Assignment_9/cereal_yield_per_hectare.csv")
# removing data from missing years
  missing_cereal_yr <- which(cereal_per_hectare$Year == missing[1] | cereal_per_hectare$Year == missing[2] | cereal_per_hectare$Year == missing[3])
  cereal_per_hectare <- cereal_per_hectare[-missing_cereal_yr, ]

# plot of cereal production (kg per hectare) for 1989-2016 (excl. 2002 and 1996)
  cereal_hectare_plot <- ggplot(cereal_per_hectare, aes(x = Year, y = Crop.production..kg.hectare., color = Year)) + 
                                  geom_point()
# trendline
  cereal_hectare_plot <- cereal_hectare_plot + geom_smooth(method = "lm", color = "darkred")
# x and y axis labels and title   
  cereal_hectare_plot <- cereal_hectare_plot + labs(y = "Cereal Grain Yield avg. (kg/hectare)", x="Year",                                                            title = "Cereal Yields from 1989-2016")
  
# axis limits and tick mark modification
  cereal_hectare_plot <-  cereal_hectare_plot + scale_x_continuous(breaks = round(seq(min(cereal_per_hectare$Year), max(cereal_per_hectare$Year), by = 1),1)) 
  cereal_hectare_plot <-  cereal_hectare_plot + scale_y_continuous(breaks = round(seq(min(cereal_per_hectare$Crop.production..kg.hectare.), max(cereal_per_hectare$Crop.production..kg.hectare.), by = 500),1)) 
  
# x axis font and angle modification  
  cereal_hectare_plot <- cereal_hectare_plot + theme(axis.text.x = element_text(color="#000000", size=9, angle=90))
  cereal_hectare_plot                                                                                                                                                                 
# saving image of plot for use in markdown document                                                                                                                                                                    
  png(filename="cereal_production_kgPerhectare.png")
  cereal_hectare_plot
  dev.off()
                                                                                                                                                                       
# -- Pt 1.3: making a plot of agricultural area percentage 

  percent_agricultural_area <-  read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/FinalProject/Assignment_9/land_use_percentages.csv")
# removing missing year data
  missing_area_yr <- which(percent_agricultural_area$Year == missing[1] | percent_agricultural_area$Year == missing[2] | percent_agricultural_area$Year == missing[3])
  percent_agricultural_area <- percent_agricultural_area[-missing_area_yr, ]
# plotting agricultural area trends
  agricultural_area_plot <- ggplot(percent_agricultural_area, aes(x = Year, y = X..Land.usage, color = Year)) + 
    geom_point()
  agricultural_area_plot <- agricultural_area_plot + geom_smooth(method = "lm", color = "darkred")
# x and y axis labels and title   
  agricultural_area_plot <- agricultural_area_plot + labs(y = "Percent of Total Land Area Used for Agriculture", x="Year",
                                                    title = "Area used for agriculture from 1989-2016")
# axis limits and tick mark modification
  agricultural_area_plot <-  agricultural_area_plot + scale_x_continuous(breaks = round(seq(min(percent_agricultural_area$Year), max(percent_agricultural_area$Year), by = 1),1)) 
  agricultural_area_plot <-  agricultural_area_plot + scale_y_continuous(breaks = round(seq(min(percent_agricultural_area$X..Land.usage), max(percent_agricultural_area$X..Land.usage), by = 1),1)) 
  
# x axis font and angle modification  
  agricultural_area_plot <- agricultural_area_plot + theme(axis.text.x = element_text(color="#000000", size=9, angle=90))
  agricultural_area_plot
# saving image of agricultural percent use trend plot
  png(filename="agricultural_percent_use.png")
  agricultural_area_plot
  dev.off()
  
# -- Pt 1.4: comparison of trends with correlation testing
  cereal_production_vs_biomass <- cor.test(cereal_per_hectare$Crop.production..kg.hectare., avg_year_Biomass_grouped$byYear_meanBiomass, method = c("pearson"))
    # NOTE: This test shows a p-value of 0.03209, 95% confidence interval of (-0.70505480 -0.04152613), cor of -0.4296079
  ag_area_vs_biomass <- cor.test(percent_agricultural_area$X..Land.usage, avg_year_Biomass_grouped$byYear_meanBiomass, method = c("pearson"))
    # NOTE: Likely no correlation; high p-value of 0.2198
  ag_area_vs_cereal_production <- cor.test(percent_agricultural_area$X..Land.usage, cereal_per_hectare$Crop.production..kg.hectare., method = c("pearson"))
    # NOTE: Very high correlation; p value 8.1e^-5. Shows relationship between increasing cereal production and decreasing agricultural area. 
  
# -- Pt 1.5: making plots of temperature data for given timeframe (used to compare to all other plots)
  
  init_weather_data <- read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/FinalProject/Assignment_9/pone_data_s2.csv")
# NOTE: No NA values appear to exist in this data set; it is not needed to remove them. 
  
#sorting by year and temperature and taking mean temperature per year  
  avg_year_Temperature <- init_weather_data %>%
    group_by( year, temperature) %>%
    summarise( meanTemperature = mean(temperature))
  
# sorting by year in sequential order
  avg_year_Temperature_grouped <- avg_year_Temperature %>%
    group_by( year ) %>%
    summarise( byYear_meanTemperature = mean(meanTemperature))
  
# plot of average temperature (degrees Celsius) for 1989-2016 (excl. 2002 and 1996)
  #basic plot: graph type, aesthetic, colors
  mean_temperature_plot <- ggplot(avg_year_Temperature_grouped, aes(x = year, y = byYear_meanTemperature, color = year)) + 
    geom_point()
# trendline
  mean_temperature_plot <- mean_temperature_plot + geom_smooth(method = "lm", color = "darkred")
# x and y axis labels and title   
  mean_temperature_plot <- mean_temperature_plot + labs(y = "Mean Temperature (degrees Celsius)", x="Year",
                                                    title = "Mean Temperature for Years 1989-2016")
  
# axis limits and tick mark modification
  mean_temperature_plot <-  mean_temperature_plot + scale_x_continuous(breaks = round(seq(min(avg_year_Temperature_grouped$year), max(avg_year_Temperature_grouped$year), by = 1),1)) 
  mean_temperature_plot <-  mean_temperature_plot + scale_y_continuous(breaks = round(seq(min(avg_year_Temperature_grouped$byYear_meanTemperature), max(avg_year_Temperature_grouped$byYear_meanTemperature), by = 1),1)) 
# x axis font and angle modification  
  mean_temperature_plot <- mean_temperature_plot+ theme(axis.text.x = element_text(color="#000000", size=9, angle=90))
  mean_temperature_plot
  
  png(filename="mean_temperature_byYear.png")
  mean_temperature_plot
  dev.off()
# comparing temperature trends to biomass trends
  temp_mean_vs_biomass <- cor.test(avg_year_Temperature_grouped$byYear_meanTemperature, avg_year_Biomass_grouped$byYear_meanBiomass, method = c("pearson"))
  # -- NOTE: High p-value of 0.6206; if other variables have higher correlation, they should be below this value (and <0.05)

# combining all plots for viewability   
  all_plots_combined <- ggarrange(agricultural_area_plot, avg_biomass_grouped_plot, cereal_hectare_plot, mean_temperature_plot, 
                                  labels = c("A", "B", "C", "D"),
                                  ncol = 2, nrow = 2)
# saving image
  png(filename="Figure1_all_trend_plots.png")
  all_plots_combined
  dev.off()

# --- part 1.7: correlation plot production

  names_corr_data <- c("Biomass", "Temperature", "Cereal Production", "Ag. Area")
  all_corr_data <- cbind(avg_year_Biomass_grouped$byYear_meanBiomass, avg_year_Temperature_grouped$byYear_meanTemperature, cereal_per_hectare$Crop.production..kg.hectare., percent_agricultural_area$X..Land.usage)
# changing column names
  colnames(all_corr_data) <- names_corr_data
# saving data as matrix
  all_corr_data <- as.matrix(all_corr_data)
# converting all data values to correlation matrix values of 2 to -2 for correlogram construction
  corr_data_for_correlogram <- cor(all_corr_data)
# making correlogram
  correlogram <- corrplot(corr_data_for_correlogram, type = "upper",  
                          tl.col = "black", tl.srt = 45)
  correlogram
# saving correlogram image
  png(filename="Figure2_correlogram.png")
  correlogram
  dev.off()
  
# -- PART 3.1: Comparing outliers (highest and lowest years of each variable) to biomass
#
# sorting vectors for highest/lowest biomass vs. cereal production & agricultural area trends
  
  cereal_by_production_quantity <- arrange(cereal_per_hectare, Crop.production..kg.hectare.) 
  insectBiomass_by_mass <- arrange(avg_year_Biomass_grouped, byYear_meanBiomass) 
  agArea_by_percent <- arrange(percent_agricultural_area, X..Land.usage) 
  
# making vectors for top 5/bottom cereal production years, and highest/lowest 5 agricultural years, highest/lowest biomass years
  correlation_outliers <- 5 # arbitrary numerical limit to find correlation between highest/lowest data points
  top_cereal_years <- tail(cereal_by_production_quantity, correlation_outliers)
  bottom_cereal_years <- head(cereal_by_production_quantity, correlation_outliers)
  lowest_area_years <- head(agArea_by_percent, correlation_outliers)
  highest_area_years <- tail(agArea_by_percent, correlation_outliers)
  
# making variables for lowest biomass years and highest biomass years - used across all graphs
  lowest_biomass_years <- head(insectBiomass_by_mass, correlation_outliers)
  highest_biomass_years <- tail(insectBiomass_by_mass, correlation_outliers)
  
# repeating above process for highest/lowest temperature years
  temp_by_avg <- arrange(avg_year_Temperature_grouped, byYear_meanTemperature) 
  top_temperature_years <- tail(temp_by_avg, correlation_outliers)
  bottom_temperature_years <- head(temp_by_avg, correlation_outliers)

# -- PART 3.2: visualization of top/bottom years for each variable
# y axis for following plot, showing rankings of data points from highest to lowest 
  ex_y <- 1:correlation_outliers 
# names for following plot
  Data_Series = c("Lowest Biomass", "Lowest Ag. Area ", "Highest Biomass", "Highest Ag. Area", "Lowest Cereal Production", "Highest Cereal Production", "Highest Temp.", "Lowest Temp.")
# plot showing years in which top/bottom biomass and cereal production were recorded
  top_bottom_biomass_cereal_plot <- ggplot(lowest_biomass_years, aes()) +
    geom_point(data = lowest_biomass_years,aes(x = Year, y = ex_y, color = Data_Series[1]), size = 3, shape = 18)+
    geom_point(data = highest_biomass_years,aes(x = Year, y = ex_y, color = Data_Series[3]), size = 3, shape = 18)+
    geom_point(data = bottom_cereal_years,aes(x = Year, y = ex_y, color = Data_Series[5]), size = 4, shape = 3)+
    geom_point(data = top_cereal_years,aes(x = Year, y = ex_y, color = Data_Series[6]), size = 4, shape = 3)+
    scale_x_continuous(breaks = round(seq(min(avg_year_Biomass_grouped$Year), # adjusting y and x axis
                                          max(avg_year_Biomass_grouped$Year), 
                                          by = 1),1)) +
    theme(axis.title.y = element_blank(), # removing y axis labels
          axis.ticks.y = element_blank(), 
          axis.line.y = element_blank(), 
          axis.text.x = element_text(color="#000000", size=9, angle=90)) +
    labs( title = "Top and Bottom Cereal/Biomass Years")
          
# saving image    
  png(filename="biomass_and_cereal_outlier_years.png", width = 800, height = 698)
  top_bottom_biomass_cereal_plot
  dev.off()
# plot showing years in which top/bottom biomass and agricultural area were recorded
  top_bottom_biomass_area_plot <- ggplot(lowest_biomass_years,aes()) + 
    geom_point(data = lowest_biomass_years,aes(x = Year, y = ex_y, color = Data_Series[1]), size = 3, shape = 18 )+
    geom_point(data = highest_biomass_years,aes(x = Year, y = ex_y, color = Data_Series[3]), size = 3, shape = 18 )+
    geom_point(data = lowest_area_years,aes(x = Year, y = ex_y, color = Data_Series[2]), size = 4, shape = 4 )+
    geom_point(data = highest_area_years,aes(x = Year, y = ex_y, color = Data_Series[4]), size = 4, shape = 4 )+
    scale_x_continuous(breaks = round(seq(min(avg_year_Biomass_grouped$Year), # adjusting y and x axis
                                          max(avg_year_Biomass_grouped$Year), 
                                          by = 1),1)) +
    theme(axis.title.y = element_blank(), # removing y axis labels
          axis.ticks.y = element_blank(), 
          axis.line.y = element_blank(), 
          axis.text.x = element_text(color="#000000", size=9, angle=90)) +
    labs( title = "Top and Bottom Agricultural Area/Biomass Years")
 # saving image
  png(filename="biomass_and_area_outlier_years.png", width = 800, height = 698)
  top_bottom_biomass_area_plot
  dev.off()
# plot showing years in which top/bottom biomass and temperature were recorded 
  top_bottom_biomass_temp_plot <- ggplot(lowest_biomass_years,aes()) +
    geom_point(data = lowest_biomass_years,aes(x = Year, y = ex_y, color = Data_Series[1]), size = 3, shape = 18 )+
    geom_point(data = highest_biomass_years,aes(x = Year, y = ex_y, color = Data_Series[3]), size = 3, shape = 18 )+
    geom_point(data = top_temperature_years,aes(x = year, y = ex_y, color = Data_Series[7]), size = 4, shape = 4 )+
    geom_point(data = bottom_temperature_years,aes(x = year, y = ex_y, color = Data_Series[8]), size = 4, shape = 4)+
    scale_x_continuous(breaks = round(seq(min(avg_year_Biomass_grouped$Year), # adjusting y and x axis
                                          max(avg_year_Biomass_grouped$Year), 
                                          by = 1),1)) +
    theme(axis.title.y = element_blank(), # removing y axis labels
          axis.ticks.y = element_blank(), 
          axis.line.y = element_blank(), 
          axis.text.x = element_text(color="#000000", size=9, angle=90)) +
    labs( title = "Top and Bottom Temperature/Biomass Years")
 # saving image
  png(filename="Figure3_biomass_and_temp_outlier_years.png", width = 800, height = 698)
  top_bottom_biomass_area_plot
  dev.off()
# making a grouped plot of all above top/bottom variable plots
  all_outlier_plots_combined <- ggarrange(top_bottom_biomass_area_plot, top_bottom_biomass_cereal_plot, top_bottom_biomass_temp_plot)
  all_outlier_plots_combined
# saving image
  png(filename="Figure9_biomass_and_temp_outlier_years.png", width = 800, height = 698)
  all_outlier_plots_combined
  dev.off()
  
  