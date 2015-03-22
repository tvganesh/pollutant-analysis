###############################################################
#
# plot3.R -  Computes and plots the total PM2.5 emission per year
# Compute how the different types of emissions point,non-point,road,non-road
# changed in Baltimore city between 1999 - 2008
#
################################################################
library(ggplot2)
library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the PM2.5 emissions for Baltimore city fips = 24510
a <- NEI$fips == "24510"
baltimore <- NEI[a,]

# Group the emissions in Baltmore city by year and compute the total emissions
emissionsB <- baltimore %>% group_by(year,type)  %>% summarise(m = sum(Emissions))

# Plot the PM2.5 vs. year for different types of sources
# Fit a smooth curve
# Create subplots based on different type point,non-point,road,non-road
# Save the ggplot
g <- qplot(year,m,data=emissionsB,facets=.~type,geom=c("point","smooth"))
ggsave(file="plot3.png")
