library(ggplot2)
library(reshape2)

dt <- read.csv("/home/jose/Documents/Science/JournalSubmissions/DataflowChl/tables/modelfits.csv", stringsAsFactors = FALSE)[,c("cdom", "chlaiv", "phycoe", "c6chl", "c6cdom", "phycoc")]
rownum <- dt
rownum[] <- row(dt)

tdt <- data.frame(t(dt))
names(tdt) <- 1:ncol(tdt)
tdt[!is.na(tdt)] <- 1
tdt[is.na(tdt)] <- 0
tdt["cdom",] <- tdt["cdom",] + tdt["c6cdom",]
tdt["chlaiv",] <- tdt["chlaiv",] + tdt["c6chl",]
tdt <- tdt[-which(row.names(tdt) == "c6cdom"),]
tdt <- tdt[-which(row.names(tdt) == "c6chl"),]
tdt_counts <- apply(tdt, 2, function(x) sum(x))

png("figures/modelparam_counts.png", res = 150)
hist(tdt_counts[tdt_counts != 0], xlab = "", main = "# of Model Parameters", breaks = c(0.5,1.5,2.5,3.5,4.5), col = "gray90")
dev.off()

#hc <- hclust(dist(tdt), "ave")

dt <- melt(dt)
dt$variable <- as.character(dt$variable)
dt <- dt[!is.na(dt$value),]
varkey <- read.table(text = 
"chlaiv,Chlorophyll
c6cdom,CDOM
c6chl,Chlorophyll
phycoc,Phycocyanin
phycoe,Phycoerytherin
cdom,CDOM", sep = ",", stringsAsFactors = FALSE)

dt$variable <- jsta::lookupkey(varkey, dt$variable)

png("figures/modelparam_hist.png", res = 150)
par(mar = c(7,2,2,1))
barplot(table(dt$variable), las = 2, main = "Variable Selection")
dev.off()
