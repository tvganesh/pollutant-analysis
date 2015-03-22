#
# plot4.R -  Computes and plots the total PM2.5 coal emission per year
# Compute how the coal emissions have changed in US 
# between 1999 - 2008
#
################################################################
library(ggplot2)
library(dplyr)
## Read the PM25 and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

df <- tbl_df(SCC)

# Get all rows in SCC which have the string 'coal' in the SCC.Level.Three
a <-grepl(".*coal.*",SCC$SCC.Level.Three,ignore.case=TRUE,fixed=FALSE,perl=TRUE)


# Filter all rows with the given SCC values containing coal
scc <- SCC[a,1]

coalemissions <- NULL
# Loop through the SCC vector and accumalate all the different coal emissions
for(i in 1:length(scc)) {
    a<- filter(NEI,SCC==scc[i])
    # Append the new rows for each scc value
    coalemissions <- rbind(coalemissions,a)
}

#Compute   coal based emissions  after grouping by year
emissions <- coalemissions %>% group_by(year)  %>% summarise(m = sum(Emissions))

# Save plot
png("plot4.png")
plot(emissions$year,emissions$m, xlab="Year",xlim=c(1998,2009),
     ylab='Total Emissions',main="Total PM2.5 coal based emissions vs year")
lines(emissions$year,emissions$m,col="blue",lwd=3.0)
dev.off()
