##################################################################################
#
# plot6.R -  Computes  how motor emissions changed in Baltimore city and LA county
# between 1999 - 2008
#
################################################################
library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subset the PM2.5 emissions for Baltimore city fips = 24510
a <- NEI$fips == "24510"
baltimore <- NEI[a,]

#Subset the PM2.5 emissions for LA county  fips = 06037
a <- NEI$fips == "06037"
la <- NEI[a,]


# Get all motor vehicles - based on category "on road"
a <- SCC$Data.Category == "Onroad"
scc <- SCC[a,1]


#Initialize to Baltimore set to NULL
bvehicles <- NULL
# Filter all rows in Baltimore dataframe for on road emissions
for(i in 1:length(scc)) {
  a<- filter(baltimore,SCC==scc[i])
  # Append the rows for each vector
  bvehicles <- rbind(bvehicles,a)
}

# Filter all rows in Los Angeles county dataframe for on road emissions
lavehicles <- NULL
for(i in 1:length(scc)) {
  a<- filter(la,SCC==scc[i])
  #Append the rows for la data set
  lavehicles <- rbind(lavehicles,a)
}


# Compute the Emissions for Baltimore using the dplyr summarise grouping by year
b_emissions <- bvehicles %>% group_by(year)  %>% summarise(m = sum(Emissions))

# Compute the Emissions for LosAngeles using the dplyr summarise grouping by year
l_emissions <- lavehicles %>% group_by(year)  %>% summarise(m = sum(Emissions))

# Save the plot in plot6.png. Annotate with color and legend
png("plot6.png")
plot(b_emissions$year,b_emissions$m, xlab="Year",xlim=c(1998,2009),ylim=c(0,7000),
     ylab='Total Emissions',main="Total PM2.5 motor vehicle  emissions vs year")
lines(b_emissions$year,b_emissions$m,col="blue",lwd=3.0)
lines(l_emissions$year,l_emissions$m,col="red",lwd=3.0)
legend("topleft",c("Baltimore","Los Angeles County"),col=c("blue","red"),
       lty=c(1,1),lwd=c(2.5,2.5))

dev.off()
