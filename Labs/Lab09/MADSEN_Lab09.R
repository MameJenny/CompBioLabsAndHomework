#---Lab 09 
#
# importing data
setwd("C:/Users/Mame/Desktop/CompBio/CompBio_on_git/Datasets/Cusack_et_al")
camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)

# first checking the data structure
head(camData)
tail(camData)
str(camData$DateTime)

# -- my initial intention is to separate the dates and the times to increase readability, and ensure that all dates/times are in the same format
# -- I want the dates to be in the format DD-MM-YYYY, and the times to be in the format HH:MM, using 24 hour time. I want them to be in seperate columns
#
# creating new data frame with split dates and times, using t and strsplit commands
splitTimes <- camData$DateTime
head(splitTimes)
splitTimes_intermediate <- t(as.data.frame(strsplit(splitTimes,' ')))
head(splitTimes_intermediate) # shows that the dates and times were successfully split
# -- I noticed that there were still unwanted row names from the original data, as well as unnamed columns
#
# removing row names and replacing column names
row.names(splitTimes_intermediate) <- NULL
colnames(splitTimes_intermediate) <- c("Date", "Time")
head(splitTimes_intermediate)
# -- now the dates need to be converted to my desired format
#
# 
splitTimes_intermediate <- strptime(splitTimes_intermediate[,1], format = "%d/%m/%Y")
splitTimes <- strptime(splitTimes_intermediate[,1], format = "%j)
head(splitTimes_intermediate)
strptime()

# the above method did not work: I am having issues with my computer crashing from running the above commands, which may be a hardware problem on my end. 
# Attempting to use the above commands with alternate syntax, like splitTimes_intermediate$Date, gave me errors including "Coercing LHS to a list"
# Alternate ideas: may attempt using strptimes from initial, non-split date and time data, but using conditionals. 
# Issue is known to be related to the fact that I have converted date and time to a vector. May need to convert format of data using code which I currently do not know. 
