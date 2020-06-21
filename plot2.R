library(dplyr)
NEI <- readRDS("Data/summarySCC_PM25.rds")
#SCC <- readRDS("Data/Source_Classification_Code.rds")
#not required 
req <-  NEI %>%
  filter(fips == "24510") %>%
  select(Emissions,year) %>% 
  group_by(year) %>% 
  summarise(tot_em=sum(Emissions))
png("plot2.png",bg = "grey")
par(bg ="black",fg ="white")
graph <- with(req,
              barplot(tot_em,names.arg = year,
                      xlab = "Year",ylab = expression("Total PM"[2.5]*" emissions in tons"),
                      ylim = c(0,4000),
                      col = "orange",col.lab="white",col.axis="red",border = "red",
                      main = expression("Total PM"[2.5]*" emissions by year in Baltimore City, Maryland"),
                      col.main = "white")
)
text(x = graph,y = round(req$tot_em,2),
     label = round(req$tot_em,2),col = "white",pos="3",cex=0.8)
dev.off()