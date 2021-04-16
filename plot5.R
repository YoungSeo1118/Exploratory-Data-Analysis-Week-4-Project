#Download data
setwd("/Users/macintosh/Downloads/exdata_data_NEI_data")
emissions_data <- readRDS("summarySCC_PM25.rds")
code_data <- readRDS("Source_Classification_Code.rds")
library(ggplot2)
library(dplyr)

#Filter vehicle emissions data set from Baltimore City
vehicle_code<-code_data[grep("[Vv]eh",code_data$Short.Name),]

vehicle_data<- emissions_data %>% 
  filter(fips=="24510" & emissions_data$SCC %in% vehicle_code$SCC) %>%
  merge(y=vehicle_code,by.x="SCC",by.y="SCC")%>%
  group_by(year) %>% summarize(vehDataTotal=sum(Emissions,na.rm=T))

#Plot
dev.copy(png,'plot5.png')
veh_plot<-ggplot(data=vehicle_data,aes(year,vehDataTotal))
veh_plot<-veh_plot+geom_line(color="black",alpha=1/2)+
  xlab("Year")+ylab("Total Emissions")+ggtitle("Total Annual Vehicle Emissions")
dev.off()
