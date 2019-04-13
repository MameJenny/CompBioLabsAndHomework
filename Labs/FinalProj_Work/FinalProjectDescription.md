# Computational Biology project: pt. 1
 By Melisande Madsen
## Introduction
Around the world, flying insect populations have declined significantly in the past several decades. This decline has potentially far-reaching effects on ecosystems, since flying insects are the foundation of most terrestrial food webs and pollinators of many agricultural species. Increased agriculture and the issues that come with it, such as habitat destruction and loss of plant diversity, are a potential cause of this decline. 

My driving question for this project is as follows: are agriculture-related activities responsible for insect population loss? 

## Summary of Data to be Analyzed

#### Original study methodology 
From 1989 to 2016, German ecologists conducted a study to measure change in insect biomass across multiple field locations in protected park areas of Germany. Their goal was to observe insect population trends within the park. 

Insect biomass was measured using specialized "malaise" traps; the collected flying insects were regularly collected, weighed, and recorded. Since changes in climate and weather conditions were suspected to correlate with population decline, several weather-related factors at the field locations were compared to the trends in insect biomass. After 27 years of data collection, the researchers involved with the study determined a 76% decline in flying insect biomass in the studied areas (Hallman et al., 2016). 

The data is split into two sets. The first set, S1, consists of measurements of insect biomass catch during a given period. The second set, S2, is records of weather data for locations across the study periods. For the purposes of this analysis, S1 will be used. 

### About the data
#### 1. Format
The data is split into two sets. The first set, S1, consists of measurements of insect biomass catch during a given period. The second set, S2, is records of weather data for locations across the study periods. For the purposes of this analysis, S1 will be used. 

S1 is available as a CSV file directly from the original article's publication in PLOS ONE. 

Agricultural land area usage data is available for 1989-2016 from the World Bank website; this data will be compiled into a CSV file. 

#### 2. Size 
S1 is a standard data frame, with 12 columns and 1512 rows, excluding the header. 

#### 3. Potential issues
For this analysis, two columns will be of interest: "year" and "biomass." A notable potential issue is the fact that the years are out of order; this is due to the fact that the study was not conducted in all locations simultaneously, and some sites do not have data for all years.

Another potential issue is the presence of NA values for several entries. If biomass values are averaged for this study, these will need to be removed from the data entirely. 

In addition, data was not collected during two years of the 27-year span. This will need to be reflected in the agricultural data that is used. 

## Proposed Analysis
While the authors of the aforementioned study determined that climate change was not the sole factor responsible for population decline, they did not conclusively name another factor. 

However, the researchers did reference a related study conducted in the UK, where insect-eating bird population decline was compared to increased agricultural land usage. In this study, a catch method similar to those used in the German study was implemented. In addition, publicly available measures of agricultural land use were compared to population trends. Based on the trends observed in the UK study, "When farming was more intense, there tended to be fewer arthropods" (Benton et al., 2002). 

For this assignment, I intend to run an analysis on the data from Hallmann et al.'s study similar to that used in the UK study. I will separate the biomass data per year from the rest of the data set and construct a new data file of average biomass per year for each location. For comparison to agricultural data, I will compile land usage data and cereal production for the 1989-2016 time period, available from the World Bank. In the next step, I will construct graphs for each of these data sets and compare general trends. Finally, I will determine if there is a strong correlation between increased agricultural production and insect biomass decrease. 

### References 

Benton, Tim G., David M. Bryant, Lorna Cole, Humphrey Q. P. Crick (2002). Linking agricultural practice to insect and bird populations: a historical study over three decades. *Journal of Applied Ecology* 39(4). 

Hallman, Caspar A., Martin Sorg, Eelke Jongejans, Henk Siepel, Nick Hofland, Heinz Schwan, Werner Stenmans, Andreas Muller, Hubert Sumser, Thomas Horren, Dave Goulson, Hans de Kroon (2016). More than 75 percent decline over 27 years in total flying insect biomass in protected areas. *PLOS ONE* 12(10). 

