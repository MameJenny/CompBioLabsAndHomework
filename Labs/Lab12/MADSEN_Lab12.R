#---- Lab 12
#
#
# -- Problem 1
#
# reading csv of Cusack et al. data
Cusack_data <- read.csv("C://Users/Mame/Desktop/CompBio/CompBioLabsAndHomework/Labs/Lab12/Cusack_et_al.csv", stringsAsFactors = F)

# -- Part 1
# making a ggplot barplot of count for each species in Cusack et al. data
Cusack_plot_pt1  <- ggplot(Cusack_data, aes(x = Species, color = Species)) + 
  geom_bar() 
# -- Part 2
# removing unsightly legend, flipping axis labels, and changing size of text
Cusack_plot_pt1 <- Cusack_plot_pt1 + theme(legend.position = "none", axis.text.x = element_text(color="#000000", size=8, angle=90), axis.text.y = element_text(color="#000000", size=8))
Cusack_plot_pt1 <- Cusack_plot_pt1 + theme(axis.text.x = element_text(face="bold", color="#000000", size=8, angle=50), axis.text.y = element_text( color="#000000", size=8, angle=40))
Cusack_plot_pt1

# -- Part 3
# making a log transformation plot of the original ggplot barplot
Cusack_plot_pt2 <- Cusack_plot_pt1 + scale_y_continuous(trans='log2')
# flipping coordinates so that bars go from left to right
Cusack_plot_pt2 <- Cusack_plot_pt2 + coord_flip()
# flipping axis text
Cusack_Plot_pt2 <- Cusack_plot_pt2 + theme(axis.text.x = element_text(color="#000000", size=10, angle=180))
Cusack_plot_pt2
