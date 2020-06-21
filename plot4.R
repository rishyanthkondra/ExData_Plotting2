library(dplyr)
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")
scc_req <- SCC$SCC[grep("Fuel Comb - .*Coal",SCC$EI.Sector)]
req <- NEI %>%
  filter(SCC %in% scc_req) %>%
  select(Emissions,year) %>% 
  group_by(year) %>% 
  summarise(tot_em=sum(Emissions))
png("plot4.png")
par(bg ="black",fg ="white")
with(req,
     {plot(year,tot_em/1000,pch = 21,col = "white",bg = "orange",cex =2,
           xlab = "Year",ylab = expression("Total PM"[2.5]*" emissions(in kilotons)"),
           ylim = c(0,800),xlim=c(1998,2009),
           col.lab="white",col.axis="red",
           main = expression("Total PM"[2.5]*" emissions by year in US(coal combustion-related)"),
           col.main = "white");
       segments(year,tot_em/1000,year,rep(0,4),lty=2,col="white");
       lines(year,tot_em/1000,col="blue",lty =2,lwd=2);
       text(x = year,y = round(tot_em/1000,0)+1,
            label = round(tot_em/1000,1),col = "white",pos="3",cex=1);
     })
dev.off()