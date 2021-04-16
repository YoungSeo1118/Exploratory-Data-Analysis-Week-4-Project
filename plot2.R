#Download data
setwd("/Users/macintosh/Downloads/exdata_data_NEI_data")
emissions_data <- readRDS("summarySCC_PM25.rds")
code_data <- readRDS("Source_Classification_Code.rds")
library(dplyr)

#Add the total emissions in Baltimore City
emissions_baltimore_annual<- emissions_data %>% filter(fips=="24510") %>% group_by(year) %>% 
  summarize(totalBaltimoreEmissions=sum(Emissions,na.rm=T))

#Plot
dev.copy(png,'plot2.png')
with(emissions_baltimore_annual,plot(x=year,y=totalBaltimoreEmissions,
                           xlab="Year",
                           ylab="Total Annual Emissions in Baltimore",
                           main="Total Annual Emissions in Baltimore [1999-2008]",
                           type="l",
                           cex=2))
dev.off()
