library(ggplot2)
library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Get all motor vehicles - based on category "on road"

a <- SCC$Data.Category == "Onroad"
scc <- SCC[a,1]

# Filter all rows with the given SCC values
vehicles <- filter(NEI,SCC==scc)

# Compute the mean measures using the dplyr summarise_each
emissions <- vehicles %>% group_by(year)  %>% summarise(m = sum(Emissions))

# Save plot
png("plot5.png")
plot(emissions$year,emissions$m, xlab="Year",xlim=c(1998,2009),
     ylab='Total Emissions',main="Total PM2.5 emissions vs year")
lines(emissions$year,emissions$m,col="blue",lwd=3.0)
dev.off()
