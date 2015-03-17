library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the PM2.5 emissions for Baltimore city fips = 24510
a <- NEI$fips == "24510"
baltimore <- NEI[a,]


# Get all motor vehicles - based on category "on road"
a <- SCC$Data.Category == "Onroad"
scc <- SCC[a,1]

#Initialize to NULL
bvehicles <- NULL

# Filter all rows in Baltimore dataframe for on road emissions
for(i in 1:length(scc)) {
  a<- filter(baltimore,SCC==scc[i])
  bvehicles <- rbind(bvehicles,a)
}

# Compute the Emissions  using the dplyr summarise
emissions <- bvehicles %>% group_by(year)  %>% summarise(m = sum(Emissions))

# Save plot
png("plot5.png")
plot(emissions$year,emissions$m, xlab="Year",xlim=c(1998,2009),
     ylab='Total Emissions',main="Total Baltimore motor vehicle emissions vs year")
lines(emissions$year,emissions$m,col="blue",lwd=3.0)
dev.off()
