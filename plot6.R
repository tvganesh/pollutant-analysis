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

#Subset the PM2.5 emissions for Baltimore city fips = 24510
a <- vehicles$fips == "24510"
baltimore <- vehicles[a,]

#Subset the PM2.5 emissions for Los Angeles County fips = 06037
a <- vehicles$fips == "06037"
losangeles <- vehicles[a,]

# Compute the mean measures for Baltimore using the dplyr summarise
b_emissions <- baltimore %>% group_by(year)  %>% summarise(m = sum(baltimore))

# Compute the mean measures for LosAngeles using the dplyr summarise
l_emissions <- losangeles %>% group_by(year)  %>% summarise(m = sum(losangeles))


plot(b_emissions$year,b_emissions$m, xlab="Year",xlim=c(1998,2009),
     ylab='Total Emissions',main="Total PM2.5 motor vehicle  emissions vs year")
lines(b_emissions$year,b_emissions$m,col="blue",lwd=3.0)
lines(l_emissions$year,l_emissions$m,col="red",lwd=3.0)

#Subset the PM2.5 emissions for Baltimore city fips = 24510
a <- NEI$fips == "24510"
baltimore <- NEI[a,]

a <- SCC$Data.Category == "Onroad"
scc <- SCC[a,1]

# Filter all rows with the given SCC values
b_emissions <- filter(baltimore,SCC==scc)

#Subset the PM2.5 emissions for Los Angeles city fips = 06037
a <- NEI$fips == "06037"
losangeles <- NEI[a,]

a <- SCC$Data.Category == "Onroad"
scc <- SCC[a,1]

# Filter all rows with the given SCC values
l_emissions <- filter(losangeles,SCC==scc)
