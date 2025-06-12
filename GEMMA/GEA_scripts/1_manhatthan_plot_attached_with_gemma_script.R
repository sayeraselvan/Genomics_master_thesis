library(qqman)
library(ggplot2)
library(dplyr)

output_gemma <- commandArgs(trailingOnly = TRUE)[1]
threshold_pvalue <- as.numeric(commandArgs(trailingOnly = TRUE)[2])

results <- read.table(paste0("output/", output_gemma), header=T)

head(results)
print(threshold_pvalue)

chr <- "chr"
bp <- "ps"
snp <- "rs"
p <- "p_wald"
plot_height <- 1000 
plot_width <- 1600   

png("manhattan_plot.png", width = plot_width, height = plot_height)

par(cex.lab = 1, cex.axis = 1, cex.main = 1, cex.sub = 1, cex = 1.9)
snp_size <- 1.5

manhattan_plot <- manhattan(results, chr = chr, bp = bp, snp = snp, p = p,
			    genomewideline=F, suggestiveline=F, highlight = snpsOfInterest, highlightCol="red",annotatePval = threshold_pvalue, col = c("blue", "orange"), )
abline(h = -log10(0.05/nrow(results)), col="black")
abline(h = -log10(threshold_pvalue), col ="red")

print(manhattan_plot)

dev.off()

