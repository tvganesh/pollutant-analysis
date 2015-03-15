###############################################################
#
# plot2.R -  Computes and plots the total PM2.5 emission per year
#
################################################################
library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the PM2.5 emissions for Baltimore city fips = 24510
a <- NEI$fips == "24510"
baltimore <- NEI[a,]

emissionsB <- baltimore %>% group_by(year)  %>% summarise(m = sum(Emissions))
png("plot2.png")
plot(emissionsB$year,emissionsB$m, xlab="Year",xlim=c(1998,2009),
     ylab='Total Emissions in Baltimore',main="Total PM2.5 emissions in Baltimore vs year")
lines(emissionsB$year,emissionsB$m,col="blue",lwd=3.0)
dev.off()