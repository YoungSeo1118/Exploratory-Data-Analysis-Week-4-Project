#Download data
setwd("/Users/macintosh/Downloads/exdata_data_NEI_data")
emissions_data <- readRDS("summarySCC_PM25.rds")
code_data <- readRDS("Source_Classification_Code.rds")
library(dplyr)

#Add the annual total emission
emissions_annual<- emissions_data %>% group_by(year) %>% 
  summarize(totalEmissions=sum(Emissions,na.rm=T))

#Plot
dev.copy(png,'plot1.png')
with(emissions_annual,plot(x=year,y=totalEmissions,
                           xlab="Year",
                           ylab="Total Annual Emissions",
                           main="Total Annual Emissions in the US [1999-2008]",
                           type="l",
                           cex=2))
dev.off()
