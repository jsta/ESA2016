library(ggplot2)
library(reshape2)

dt <- read.csv("/home/jose/Documents/Science/JournalSubmissions/DataflowChl/tables/modelfits.csv", stringsAsFactors = FALSE)[,c("cdom", "chlaiv", "phycoe", "c6chl", "c6cdom", "phycoc")]

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
barplot(table(dt$variable), las = 2, main = "Variable Selection")
dev.off()
