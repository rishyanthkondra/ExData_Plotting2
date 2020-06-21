library(dplyr,ggplot2)
NEI <- readRDS("Data/summarySCC_PM25.rds")
#SCC <- readRDS("Data/Source_Classification_Code.rds")
#not required 
req <-  NEI %>%
  filter(fips == "24510") %>%
  select(Emissions,year,type) %>%
  group_by(year,type) %>% 
  summarise(tot_em=sum(Emissions))
png("plot3.png",width = 600,height = 480)
q <- ggplot(req,aes(x = year,y = tot_em,label = round(tot_em,0)))+
  geom_segment(aes(x = year,y = rep(0,16),xend = year,yend=tot_em,color = type,linetype = "b"))+
  geom_point(aes(color= type),size =1)+
  geom_line()+
  facet_grid(.~type)+
  theme(legend.position = "none")+
  xlab("Year")+ylab(expression("Total PM"[2.5]*" emissions (in tons) by year in Baltimore"))
print(q)
dev.off()