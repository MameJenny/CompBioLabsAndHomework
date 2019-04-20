# ------- WIP Final project
# ---------- DO NOT SUBMIT ----------
#
#
#
# -- Required packages for this analysis
install.packages("ggplot2") # for making plots
install.packages("tidyverse") # for formatting data
install.packages("dplyr") # for formatting data
install.packages("ggpubr") # for plot display
install.packages("Hmisc") # for making a correlation matrix
install.packages("corrplot") # for visualization of correlation matrix
library(Hmisc)
library(corrplot)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(ggpubr)

# -- Setting working directory for image saving purposes
setwd("C:/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work")



# -- PT 1.1: Making a plot of mean biomass per year for the years 1989-2016

# import biomass data

  init_data <- read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/pone_data_s1.csv")
  
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
  
#axis limits and tick mark modification
  avg_biomass_grouped_plot <-  avg_biomass_grouped_plot + scale_x_continuous(breaks = round(seq(min(avg_year_Biomass_grouped$Year), max(avg_year_Biomass_grouped$Year), by = 1),1)) 
#x axis font and angle modification  
  avg_biomass_grouped_plot <- avg_biomass_grouped_plot + theme(axis.text.x = element_text(color="#000000", size=9, angle=40))
  avg_biomass_grouped_plot
  
  
  png(filename="Figure1_biomass_mean_perYear.png")
  avg_biomass_grouped_plot
  dev.off()
  
# ------ Note for data in part 1: Insect biomass data was not recorded in the years 2002, 1998, or 1996. Therefore, associated agricultural data must be adjusted to delete these values. 
  missing <- c(1996,1998,2002) # missing years
# -- Pt 1.2: Making a plot of cereal yield per hectare
#
# loading in cereal per hectare data
 cereal_per_hectare <-  read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/cereal_yield_per_hectare.csv")
# removing data from missing years
  missing_cereal_yr <- which(cereal_per_hectare$Year == missing[1] | cereal_per_hectare$Year == missing[2] | cereal_per_hectare$Year == missing[3])
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
# removing missing year data
  missing_area_yr <- which(percent_agricultural_area$Year == missing[1] | percent_agricultural_area$Year == missing[2] | percent_agricultural_area$Year == missing[3])
  percent_agricultural_area <- percent_agricultural_area[-missing_area_yr, ]
#plotting agricultural area trends
  agricultural_area_plot <- ggplot(percent_agricultural_area, aes(x = Year, y = X..Land.usage, color = Year)) + 
    geom_point()
  agricultural_area_plot <- agricultural_area_plot + geom_smooth(method = "lm", color = "darkred")
  #x and y axis labels and title   
  agricultural_area_plot <- agricultural_area_plot + labs(y = "Percent of Total Land Area Used for Agriculture", x="Year",
                                                    title = "Area used for agriculture from 1989-2016")
  
  #axis limits and tick mark modification
  agricultural_area_plot <-  agricultural_area_plot + scale_x_continuous(breaks = round(seq(min(cereal_per_hectare$Year), max(cereal_per_hectare$Year), by = 1),1)) 
  #x axis font and angle modification  
  agricultural_area_plot <- agricultural_area_plot + theme(axis.text.x = element_text(color="#000000", size=9, angle=40))
  
  
  
  
  
#saving image of agricultural percent use trend plot
  png(filename="Figure3_agricultural_percent_use.png")
  agricultural_area_plot
  dev.off()
  
# -- Pt 1.4: comparison of plots
  cereal_production_vs_biomass <- cor.test(cereal_per_hectare$Crop.production..kg.hectare., avg_year_Biomass_grouped$byYear_meanBiomass, method = c("pearson"))
    # NOTE: This test shows a p-value of 0.03209, 95% confidence interval of (-0.70505480 -0.04152613), cor of -0.4296079
  ag_area_vs_biomass <- cor.test(percent_agricultural_area$X..Land.usage, avg_year_Biomass_grouped$byYear_meanBiomass, method = c("pearson"))
    # NOTE: Likely no correlation; high p-value of 0.2198
  ag_area_vs_cereal_production <- cor.test(percent_agricultural_area$X..Land.usage, cereal_per_hectare$Crop.production..kg.hectare., method = c("pearson"))
    # NOTE: Very high correlation; p value 8.1e^-5. Shows relationship between increasing cereal production and decreasing agricultural area. 

# -- Pt 1.5: statistical analysis of plots

# -- Pt 1.6: Statistical anomalies (high biomass years) vs. cereal production trends
  
  cereal_by_production_quantity <- arrange(cereal_per_hectare, Crop.production..kg.hectare.) 
  insectBiomass_by_mass <- arrange(avg_year_Biomass_grouped, byYear_meanBiomass) 
  agArea_by_percent <- arrange(percent_agricultural_area, X..Land.usage) 
  
#making variables for top 5 cereal production years and lowest 5 agricultural years
  correlation_outliers <- 5 # arbitrary numerical limit to find correlation between highest/lowest data points
  top_cereal_years <- tail(cereal_by_production_quantity, correlation_outliers)
  bottom_cereal_years <- head(cereal_by_production_quantity, correlation_outliers)
  lowest_area_years <- head(agArea_by_percent, correlation_outliers)
#making variables for lowest biomass years and highest biomass years
  lowest_biomass_years <- head(insectBiomass_by_mass, correlation_outliers)
  highest_biomass_years <- tail(insectBiomass_by_mass, correlation_outliers)

  
# -- Pt 2.1: making plots of temperature data for given timeframe
  
  init_weather_data <- read.csv("/Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/FinalProj_Work/pone_data_s2.csv")
  
  which(is.na(init_weather_data$temperature)) # NOTE: No NA values appear to exist in this data set; it is not needed to remove them. 
  
#sorting by year and temperature and taking mean temperature per year  
  avg_year_Temperature <- init_weather_data %>%
    group_by( year, temperature) %>%
    summarise( meanTemperature = mean(temperature))
  
#sorting by year in sequential order
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
  
  mean_temperature_plot
  # -- Pt 2.2: comparing temperature trends to biomass trends
  temp_mean_vs_biomass <- cor.test(avg_year_Temperature_grouped$byYear_meanTemperature, avg_year_Biomass_grouped$byYear_meanBiomass, method = c("pearson"))
  

#comparing years with highest temperature to biomass
  temp_by_avg <- arrange(avg_year_Temperature_grouped, byYear_meanTemperature) 
  top_temperature_years <- tail(temp_by_avg, correlation_outliers)
  
  top_temp_mean_vs_biomass <- cor.test(top_temperature_years$byYear_meanTemperature, highest_biomass_years$byYear_meanBiomass, method = c("pearson"))
   # --- NOTE: this shows that temperature increase has a correlation with insect biomass increase. Higher temperature years tended to have higher biomass. There is some overlap in these years: 2011 and 1989 are on both lists. 


  
  
  all_plots_combined <- ggarrange(agricultural_area_plot, avg_biomass_grouped_plot, cereal_hectare_plot + rremove("x.text"), 
            labels = c("A", "B", "C"),
            ncol = 2, nrow = 2)
  
  
  names_corr_data <- c("Mean Biomass", "Mean Temperature", "Cereal Production", "Agricultural Area")
  all_corr_data <- cbind(avg_year_Biomass_grouped$byYear_meanBiomass, avg_year_Temperature_grouped$byYear_meanTemperature, cereal_by_production_quantity$Crop.production..kg.hectare., percent_agricultural_area$X..Land.usage)
  colnames(all_corr_data) <- names_corr_data
  all_corr_data <- as.matrix(all_corr_data)
  all_corr_data_forPlot <- rcorr(all_corr_data, type = c("pearson"))

  flattenCorrMatrix <- function(cormat, pmat) {
    ut <- upper.tri(cormat)
    data.frame(
      row = rownames(cormat)[row(cormat)[ut]],
      column = rownames(cormat)[col(cormat)[ut]],
      cor  =(cormat)[ut],
      p = pmat[ut]
    )
  }
  
  corr_data_for_correlogram <- cor(all_corr_data)
  
  correlogram <- corrplot(corr_data_for_correlogram, type = "upper",  
                          tl.col = "black", tl.srt = 45)
  str(corr_data_for_correlogram)
  