#Download data
setwd("/Users/macintosh/Downloads/exdata_data_NEI_data")
emissions_data <- readRDS("summarySCC_PM25.rds")
code_data <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
library(dplyr)

#Filter vehicle emission data set from the Baltimore City and Los Angeles data
vehicle_code<-code_data[grep("[Vv]eh",code_data$Short.Name),]

vehicle_data_Baltimore<- emissions_data %>% 
  filter(fips=="24510" & emissions_data$SCC %in% vehicle_code$SCC) %>%
  merge(y=vehicle_code,by.x="SCC",by.y="SCC")%>%
  group_by(year) %>% summarize(vehDataTotal=sum(Emissions,na.rm=T))

vehicle_data_LA<- emissions_data %>% 
  filter(fips=="06037" & emissions_data$SCC %in% vehicle_code$SCC) %>%
  merge(y=vehicle_code,by.x="SCC",by.y="SCC")%>%
  group_by(year) %>% summarize(vehDataTotal=sum(Emissions,na.rm=T))

emissions_baltimore<-cbind(vehicle_data_Baltimore,"City"=rep("Baltimore City",4))
emissions_LA<-cbind(vehicle_data_LA,"City"=rep("Los Angeles",4))

combined_data<-rbind(emissions_baltimore,emissions_LA)

#Plot
dev.copy(png,'plot6.png')
comp_plot<-ggplot(data=combined_data,aes(year,vehDataTotal,col=City))
comp_plot<-comp_plot+geom_line(alpha=1/2)+
  xlab("Year")+ylab("Total Emissions")+ggtitle("Total Annual Vehicle Emissions in LA and Baltimore City")
dev.off()
