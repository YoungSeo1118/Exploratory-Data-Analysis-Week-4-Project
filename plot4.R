#Download data
setwd("/Users/macintosh/Downloads/exdata_data_NEI_data")
emissions_data <- readRDS("summarySCC_PM25.rds")
code_data <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
library(dplyr)

#Get all records involving coal
code_coal<-code_data[grep("[Cc]oal",code_data$EI.Sector),]
emissions_coal<-subset(emissions_data,emissions_data$SCC %in% code_coal$SCC)
coaldata<-merge(emissions_coal,code_coal,by.x="SCC",by.y="SCC")

#Add emissions by year
coaldata_total<-coaldata %>% group_by(year) %>%
  summarize(coaldataTotal=sum(Emissions,na.rm=T))

#Plot
dev.copy(png,'plot4.png')
coal_plot<-ggplot(data=coaldata_total,aes(year,coaldataTotal))
coal_plot<-coal_plot+geom_line(color="black",alpha=1/2)+
  xlab("Year")+ylab("Total Emissions")+ggtitle("Total Annual Coal Combustion Emissions")
dev.off()
