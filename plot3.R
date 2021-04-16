
#Download data
setwd("/Users/macintosh/Downloads/exdata_data_NEI_data")
emissions_data <- readRDS("summarySCC_PM25.rds")
code_data <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
library(dplyr)

#Add emissions in Baltimore City by type
emissions_type<- emissions_data %>% filter(fips=="24510") %>% 
  group_by(year,type) %>% 
  summarize(totalEmissionsType=sum(Emissions,na.rm=T))

#Plot
dev.copy(png,'plot3.png')
emissions_type<-ggplot(data = emissions_type,aes(year,totalEmissionsType))
emissions_type <- emissions_type + geom_line(color="black",alpha=1/2)+
  facet_grid(. ~ type)+ xlab("Year") + ylab("Total Emissions") +
  ggtitle("Total Annual Emissions in Baltimore by Year")
dev.off()
