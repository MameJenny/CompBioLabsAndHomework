# lab step #3: creating a variable for initial bags of chips
Init_BagsChips <- 5
# lab step #3: creating a variable for initial guests anticipated
GuestList <- 8
# lab step #5: creating a variable for average bag of chip consumption per guest
AverageConsumption <- 0.4
# lab step #6: calculating remaining chips after 8 guests eat 0.4 bag each
Remn_Chips <- Init_BagsChips - (GuestList * AverageConsumption)
# lab step #7: factoring in that host will eat 0.4 bag of remaining chips
Fnl_Chips <- Remn_Chips - 0.4 
#
# --- Lab Part II
#
# lab step #8: creating vectors for Star Wars movie rankings for self and guests
Self <- c(7, 6, 5, 1, 2, 3, 4)
Penny <- c(5, 7, 6, 3, 1, 2, 4)
Jenny <- c(4, 3, 2, 7, 6, 5, 1)
Lenny <- c(1, 7, 3, 4, 6, 5, 2)
Stewie <- c(6, 7, 5, 4, 3, 1, 2)
# lab step #9: retrieving Penny and Lenny's ranking of episode 5 using indexing
PennyIV <- Penny[4]
LennyIV <- Lenny[4]
# lab step #10: combining all elements from guest ranking into one object with cbind
CombinedRanking <- cbind(Self, Penny, Jenny, Lenny, Stewie)
# lab step #11: inspecting structure of combined rankings
str(CombinedRanking)
# lab step #11: inspecting structure of Penny's total rankings and movie IV rankings
str(Penny)
str(PennyIV)
# -- Differences between these data objects: CombinedRanking is a table of data with unnamed, numeric rows and named columns ("Self," "Penny," etc). Vector Penny is a numeric index of Penny's rankings for all movies. Vector PennyIV is a numeric value representing Penny's ranking of movie IV.
#
# lab step #12: converting the ranking data into a data frame
RankingDataFrame <- as.data.frame(CombinedRanking)
RankingDataFrame_2 <- data.frame(CombinedRanking)
# lab step #13: inspecting differences between cbind created table and new ranking data frame 
dim(CombinedRanking) # shows 7 rows, 5 columns
dim(RankingDataFrame) # shows 7 rows, 5 columns

str(CombinedRanking) # shows that rows are unnamed, columns have names of guests
str(RankingDataFrame) # shows numerical rankings in a data table, with variables named after guests

CombinedRanking == RankingDataFrame # shows that data points are equal for each cell, when the data frame and cbind table are compared

typeof(CombinedRanking) # shows that the cbind table has a data structure of "double"
typeof(RankingDataFrame) # shows that the data frame has a data structure of "list"

# lab step #14: making a vector of all episode numbers in Roman numerals
EpisodesNumerals <- c('I', 'II', 'III', 'IV', 'V', 'VI', 'VII')

# lab step #15: giving the cbind table row names
row.names(CombinedRanking) <- c(EpisodesNumerals)
# lab step #15: giving the data frame row names 
row.names(RankingDataFrame) <- c(EpisodesNumerals)
#
# --- Lab Part III
#
# lab step #16: accessing cbind table's third row
CombinedRanking[3,]
# lab step #17: accessing cbind table's fourth column
CombinedRanking[,4]
# lab step #18: accessing cbind table's Self ranking for movie V
CombinedRanking[5,1]
# lab step #19: accessing Penny's ranking for movie II
CombinedRanking[2,2]
# lab step #20: accessing all rankings for movies IV-VI
CombinedRanking[4:7,]
# lab step #21: accessing all rankings for movies II, V, VI
CombinedRanking[2,]
CombinedRanking[5,]
CombinedRanking[6,]
# lab step #22: accessing ranking data for Penny, Lenny, and Stewie for episode IV and VI
CombinedRanking[c(4,6), c(2,3,5)]
# lab step #23: swiitching Lenny's rankings for episodes II and V
SwapValue <- RankingDataFrame
SwapValue[4,2] <- 4
SwapValue[4,4] <- 7
# lab step #24: using an alternate method of retrieving Penny's ranking for movie III
SwapValue["III","Penny"]
# lab step #25: undoing step #23's change using alternate method
SwapValue["IV", "Lenny"] <- 4 
SwapValue["II","Lenny"] <- 7
