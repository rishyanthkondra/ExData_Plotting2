library(dplyr)
NEI <- readRDS("Data/summarySCC_PM25.rds")
#SCC <- readRDS("Data/Source_Classification_Code.rds")
#not required 
req <-  NEI %>% 
  select(Emissions,year) %>% 
  group_by(year) %>% 
  summarise(tot_em=sum(Emissions))
png("plot1.png",bg = "grey")
par(bg ="black",fg ="white")
graph <- with(req,
     barplot(tot_em/1000,names.arg = year,
             xlab = "Year",ylab = expression("Total PM"[2.5]*" emissions in kilotons"),
             ylim = c(0,8000),
             col = "orange",col.lab="white",col.axis="red",border = "red",
             main = expression("Total PM"[2.5]*" emissions by year in US"),
             col.main = "white")
    )
text(x = graph,y = round(req$tot_em/1000,0),
     label = round(req$tot_em/1000,1),col = "white",pos="3",cex=0.8)
dev.off()