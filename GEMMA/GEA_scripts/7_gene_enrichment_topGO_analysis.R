library("ggplot2")
library("topGO")

gene2GO_new<- readMappings(file = "/netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/eggnog_geneID2GO.txt", sep = "\t",IDsep = " ")
for (i in seq_along(gene2GO_new)) {
  gene2GO_new[[i]] <- gsub(",", "", gene2GO_new[[i]])
}

geneNames <- names(gene2GO_new)
temperature_genes <- read.table("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/gene_list_per_variable/spl_gene_names_SC_pbmmaf_bio_8_Mean_temperature_of_Wettest_Quarter.assoc.txt_bedtools_intersect_FDR_wb_out.txt")
precipitation_genes <- read.table("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/gene_list_per_variable/spl_gene_names_SC_bmmaf_933_bio_12_Annual_Precipitation.assoc.txt_bedtools_intersect_FDR_wb_out.txt")
ai_Apr_genes <- read.table("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/gene_list_per_variable/spl_gene_names_SC_bmmaf_933_ai_Apr.assoc.txt_bedtools_intersect_FDR_wb_out.txt")

geneNames_temp <- names(gene2GO_new)
temperature_genes<-temperature_genes[order(temperature_genes$V1, decreasing = F),]
which(temperature_genes%in%geneNames_temp)
geneList_temp <- factor(as.integer(geneNames_temp%in%temperature_genes))
geneNames_temp <- names(gene2GO_new)
names(geneList_temp) <- geneNames_temp
typeof(geneList_temp)

geneNames_prec <- names(gene2GO_new)
precipitation_genes<-precipitation_genes[order(precipitation_genes$V1, decreasing = F),]
which(precipitation_genes%in%geneNames_prec)
geneList_prec <- factor(as.integer(geneNames_prec%in%precipitation_genes))
geneNames_prec <- names(gene2GO_new)
names(geneList_prec) <- geneNames_prec
typeof(geneNames_prec)

geneNames_ai_Apr <- names(gene2GO_new)
ai_Apr_genes<-ai_Apr_genes[order(ai_Apr_genes$V1, decreasing = F),]
which(ai_Apr_genes%in%geneNames_prec)
geneList_ai_Apr <- factor(as.integer(geneNames_ai_Apr%in%ai_Apr_genes))
geneNames_ai_Apr <- names(gene2GO_new)
names(geneList_ai_Apr) <- geneNames_ai_Apr
typeof(geneNames_ai_Apr)

gene2GO_data <- gene2GO_new
# # Create a logical vector indicating whether each gene is in the precipitation gene set
# geneList_precipitation <- factor(as.integer(gene2GO_data$GeneID %in% precipitation_genes))
# names(geneList_precipitation) <- gene2GO_data$GeneID

# Create a topGOdata object for precipitation genes
GOdata_precipitation <- new("topGOdata", ontology = "BP", allGenes = geneList_prec, annot = annFUN.gene2GO, gene2GO = gene2GO_data)
GOdata_temperature <- new("topGOdata", ontology = "BP", allGenes = geneList_temp, annot = annFUN.gene2GO, gene2GO = gene2GO_data)
GOdata_ai_Apr <- new("topGOdata", ontology = "BP", allGenes = geneList_ai_Apr , annot = annFUN.gene2GO, gene2GO = gene2GO_data)

resultFisher <- runTest(GOdata_precipitation, algorithm = "classic", statistic = "fisher")
resultFisher
resultKS <- runTest(GOdata_precipitation, algorithm = "classic", statistic = "ks")
resultKS
resultKS.elim <- runTest(GOdata_precipitation, algorithm = "elim", statistic = "ks")
resultKS.elim
allRes_precipitation <- GenTable(GOdata_precipitation, classicFisher = resultFisher,
                       classicKS = resultKS, elimKS = resultKS.elim,
                       orderBy = "elimKS", ranksOf = "classicFisher", topNodes = 30)

resultFisher <- runTest(GOdata_temperature, algorithm = "classic", statistic = "fisher")
resultFisher
resultKS <- runTest(GOdata_temperature, algorithm = "classic", statistic = "ks")
resultKS
resultKS.elim <- runTest(GOdata_temperature, algorithm = "elim", statistic = "ks")
resultKS.elim
allRes_temperature <- GenTable(GOdata_temperature, classicFisher = resultFisher,
                       classicKS = resultKS, elimKS = resultKS.elim,
                       orderBy = "elimKS", ranksOf = "classicFisher", topNodes = 30)

resultFisher <- runTest(GOdata_ai_Apr, algorithm = "classic", statistic = "fisher")
resultFisher
resultKS <- runTest(GOdata_ai_Apr, algorithm = "classic", statistic = "ks")
resultKS
resultKS.elim <- runTest(GOdata_ai_Apr, algorithm = "elim", statistic = "ks")
resultKS.elim
allRes_ai_Apr <- GenTable(GOdata_ai_Apr, classicFisher = resultFisher,
                       classicKS = resultKS, elimKS = resultKS.elim,
                       orderBy = "elimKS", ranksOf = "classicFisher", topNodes = 30)

allRes_precipitation$Condition <- rep("Precipitation", length(allRes_precipitation$GO.ID))
allRes_temperature$Condition <- rep("Temperature", length(allRes_temperature$GO.ID))
allRes_ai_Apr$Condition <- rep("Aridity", length(allRes_aiApr$GO.ID))
#allRes_PC2$Condition <- rep("PC2", length(allRes_PC2$GO.ID))
#allRes_PC3$Condition <- rep("PC3", length(allRes_PC3$GO.ID))
#allRes_PC4$Condition <- rep("PC4", length(allRes_PC4$GO.ID))

#write.csv(allRes_PC2, "C:/Users/sayeraselvan/Desktop/Master thesis report/imp/PC2.csv")
all_results_GO <- rbind(allRes_temperature, allRes_precipitation, allRes_ai_Apr)
order_levels <- c("Temperature", "Precipitation", "Aridity")

#all_results_GO <- rbind(allRes_temperature, allRes_precipitation, allRes_aiApr, allRes_PC2, allRes_PC3, allRes_PC4)
#order_levels <- c("Temperature", "Precipitation", "Aridity", "PC2", "PC3", "PC4")

all_results_GO
#make p-Values numeric
all_results_GO$classicKS <- as.numeric(all_results_GO$classicKS)
all_results_GO$elimKS <- as.numeric(all_results_GO$elimKS)
#order of x-axis
unique(all_results_GO$Condition)

all_results_GO
# Convert the Condition variable to a factor with the desired order
all_results_GO$Condition <- factor(all_results_GO$Condition, levels = order_levels)
all_results_GO$pValue <- -log10(as.numeric(all_results_GO$elimKS))
all_results_GO$gene_number <- all_results_GO$Annotated- all_results_GO$Expected
#Plot GO data

gp_per_region <- ggplot(data = all_results_GO, aes(x = Condition,   y = reorder(Term, pValue),
                                                   color = pValue, size = Annotated)) +
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_minimal() +
  ylab("") +
  xlab("") +
  ggtitle("GO enrichment across populations") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(color = "-log10(pValue)", size = "Gene number")
gp_per_region

gp_per_region1 <- ggplot(data = all_results_GO, aes(x = Condition, y = reorder(Term, pValue),
                                                    color = pValue, size = Annotated)) +
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_minimal() +
  ylab("") +
  xlab("") +
  ggtitle("GO Enrichment Across different climatic conditions") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),  # Make x-axis labels bold
        axis.text.y = element_text(face = "bold"),  # Make y-axis labels bold
        title = element_text(face = "bold", size = 16, hjust = 0.5),  # Make title bold and larger
        legend.text = element_text(face = "bold"),  # Make legend text bold
        legend.title = element_text(face = "bold"),  # Make legend title bold
        plot.title = element_text(face = "bold", size = 18, hjust = 0.5)) +  # Adjust plot title size and make it bold
  labs(color = "-log10(pValue)", size = "Gene Number")

print(gp_per_region1)

gp_per_region1 <- ggplot(data = all_results_GO, aes(x = Condition, y = reorder(Term, pValue),
                                                    color = pValue, size = Annotated)) +
  geom_point() +
  scale_color_gradient(low = "red", high = "blue") +
  theme_minimal() +
  ylab("") +
  xlab("") +
  ggtitle("GO Enrichment Across Different Climatic Conditions") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),  # Make x-axis labels bold
        axis.text.y = element_text(face = "bold"),  # Make y-axis labels bold
        title = element_text(face = "bold", size = 16, hjust = 0.5),  # Make title bold and larger
        legend.text = element_text(face = "bold"),  # Make legend text bold
        legend.title = element_text(face = "bold"),  # Make legend title bold
        plot.title = element_text(face = "bold", size = 18, hjust = 0.5),  # Adjust plot title size and make it bold
        axis.title.y = element_text(face = "bold")) +  # Make y-axis title bold
  labs(color = "-log10(pValue)", size = "Gene Number")

print(gp_per_region1)
all_results_GO

gp_per_region <- ggplot(data = all_results_GO, aes(x = Condition, y = reorder(Term, pValue),
                                                   color = pValue, size = Annotated)) +
  geom_point() +
  scale_color_gradient(low = "red", high = "blue", name = "-log10(pValue)") +
  scale_size_continuous(
    breaks = c(10, 25, 50, 100),
    labels = c("10", "25", "50", "100"),
    range = c(2, 5)
  ) +
  theme_minimal() +
  labs(title = "GO Enrichment Across Populations",
       x = "Condition",
       y = NULL,
       color = "-log10(pValue)",
       size = "Gene Number") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5)) +  theme(axis.text.x = element_text(angle = 45, hjust = 1, face = "bold"),  # Make x-axis labels bold
                                                         axis.text.y = element_text(face = "bold"),  # Make y-axis labels bold
                                                         title = element_text(face = "bold", size = 16, hjust = 0.5),  # Make title bold and larger
                                                         legend.text = element_text(face = "bold"),  # Make legend text bold
                                                         legend.title = element_text(face = "bold"),  # Make legend title bold
                                                         plot.title = element_text(face = "bold", size = 18, hjust = 0.5),  # Adjust plot title size and make it bold
                                                         axis.title.y = element_text(face = "bold")) +  # Make y-axis title bold
  labs(color = "-log10(pValue)", size = "Gene Number")

gp_per_region


#library(dplyr)

# Assuming your data frame is named all_results_GO
#all_results_GO <- all_results_GO %>%
#  filter(Term != "signal transduction")

# Now, all rows where Term is "signal transduction" are removed
#write.csv(all_results_GO, "C:/Users/sayeraselvan/Desktop/FDR_corrected_all_results_GO.csv")
#getwd()
