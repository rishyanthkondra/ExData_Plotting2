library(dplyr)
NEI <- readRDS("Data/summarySCC_PM25.rds")
#SCC <- readRDS("Data/Source_Classification_Code.rds")
#not required 
req <-  NEI %>%
  filter(fips == "24510") %>%
  select(Emissions,year) %>% 
  group_by(year) %>% 
  summarise(tot_em=sum(Emissions))
png("plot2.png")
par(bg ="black",fg ="white")
with(req,
     {plot(year,tot_em,pch = 21,col = "white",bg = "orange",cex =2,
           xlab = "Year",ylab = expression("Total PM"[2.5]*" emissions(in tons)"),
           ylim = c(0,4000),xlim=c(1998,2009),
           col.lab="white",col.axis="red",
           main = expression("Total PM"[2.5]*" emissions by year in Maryland , Baltimore"),
           col.main = "white");
       segments(year,tot_em,year,rep(0,4),lty=2,col="white");
       lines(year,tot_em,col="blue",lty =2,lwd=2);
       text(x = year,y = round(tot_em,0)+1,
            label = round(tot_em,1),col = "white",pos="3",cex=1);
     })
dev.off()