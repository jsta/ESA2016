library(ggplot2)

dt <- read.csv("/home/jose/Documents/Science/JournalSubmissions/DataflowChl/tables/grabs_cor.csv", stringsAsFactors = FALSE)
row.names(dt) <- c("pp", names(dt)[-length(names(dt))])

dt <- cbind(data.frame(value = unlist(dt), expand.grid(row.names(dt),names(dt))))
dt <- dt[rev(1:nrow(dt)),]

p.values <- read.csv("/home/jose/Documents/Science/JournalSubmissions/DataflowChl/tables/grabs_pvalues.csv", stringsAsFactors = FALSE)

gg <- ggplot(data = dt, aes(Var2, Var1, fill = value)) + geom_raster() + viridis::scale_fill_viridis() + geom_text(aes(fill = dt$value, label = dt$value), size = 10) + coord_flip() + theme_minimal() + theme(axis.title.x = element_blank(), axis.title.y = element_blank(), legend.position = "none", axis.text = element_text(size = 16)) + ggtitle(expression(paste("Correlation Matrix (",rho, ")")))

ggsave("figures/chlcor_heatmap.png")	
	