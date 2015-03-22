###########################################################################
#
# plot1.R -  Computes and plots the total PM2.5 emission per year
# This plot computes the total PM2.5 emissions in US from US 1999 to 2008
#
###########################################################################
library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Compute the total (sum) measures using the dplyr summarise after grouping
# by year
emissions <- NEI %>% group_by(year)  %>% summarise(m = sum(Emissions))

# Save plot in plot1.png
png("plot1.png")
plot(emissions$year,emissions$m, xlab="Year",xlim=c(1998,2009),
                ylab='Total Emissions',main="Total PM2.5 emissions vs year")
lines(emissions$year,emissions$m,col="blue",lwd=3.0)
dev.off()


