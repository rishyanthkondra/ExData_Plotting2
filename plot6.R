library(dplyr)
NEI <- readRDS("Data/summarySCC_PM25.rds")
#SCC <- readRDS("Data/Source_Classification_Code.rds")
#not required
req_balt <- NEI %>%
  filter(type == "ON-ROAD",fips == "24510") %>%
  select(Emissions,year) %>% 
  group_by(year) %>% 
  summarise(tot_em=sum(Emissions))
req_cal <- NEI %>%
  filter(type == "ON-ROAD",fips == "06037") %>%
  select(Emissions,year) %>% 
  group_by(year) %>% 
  summarise(tot_em=sum(Emissions))
png("plot6.png")
par(bg ="black",fg ="white")
with(req_balt,
     {plot(year,tot_em,pch = 21,col = "white",bg = "orange",cex =2,
           xlab = "Year",ylab = expression("Total PM"[2.5]*" emissions(in tons) vehicle sources"),
           ylim = c(0,4800),xlim=c(1998,2009),
           col.lab="white",col.axis="red",
           main = expression("Total PM"[2.5]*" emissions by year in Baltimore and Los Angeles"),
           col.main = "white");
       segments(year,tot_em,year,rep(0,4),lty=2,col="white");
       lines(year,tot_em,col="blue",lty =2,lwd=2);
       text(x = year,y = round(tot_em,0)+1,
            label = round(tot_em,1),col = "white",pos="3",cex=1);
     })
with(req_cal,
     {points(year,tot_em,pch = 21,col = "white",bg = "orange");
       segments(req_balt$year,req_balt$tot_em,year,tot_em,lty=2,col="yellow");
       lines(year,tot_em,col="green",lty =2,lwd=2);
       text(x = year,y = round(tot_em,0)+1,
            label = round(tot_em,1),col = "white",pos="3",cex=1);
     })
legend("topright",col = c("blue","green"),legend = c("Baltimore","LA"),lty=2)
dev.off()