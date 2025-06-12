
library(tidyverse)
library(UpSetR)
library(tidyverse)
library(readr)
library(stringr)
library(rehh)
library(hdi)
library(tidyverse)
library(qqman)
library(ggplot2)
library(dplyr)

# Get the type of analysis from command line arguments
args <- commandArgs(trailingOnly = TRUE)
analysis_type <- args[1]

# Check if the analysis_type is provided
if (is.na(analysis_type)) {
  stop("Please provide an analysis type as the first argument (e.g., 'alps', 'SC', 'spain', 'scad').")
}

#change up the location of the path directory accordingly and we can make teh upset plot for each, the only thing to change will be the belore working directory

setwd(paste0("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/", analysis_type, "/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/association_files_results_gemma/snp_to_gene/bedtools_intersect"))


#setwd("C:\\Users\\sayeraselvan\\Desktop\\FDR corrected\\FDR_1\\bedtools_intersect")

# I have to remove the rows that do not have 0s or 1s
library(readxl)

common_genes_df <- read.csv("../complete_gene_list.csv")
#common_genes_df <- read.csv("../complete_gene_list_with_imp_variables.csv")
#common_genes_df <- read.csv("../prec.csv")
#common_genes_df <- read.csv("../temp.csv")
#test_upset <- common_genes_df[c(1:nrow(common_genes_df) - 1), c(2:length(common_genes_df))]

pdf("../UpSet_plot1.pdf", width = 12, height = 6)

upset(test_upset, nsets = 200, line.size = 1, nintersects = NA,
      point.size = 1.5, text.scale = 1, mb.ratio = c(0.45, 0.55),
      sets.bar.color = "dodgerblue3", set_size.show = T, order.by = "freq")
dev.off()

# specific set
my_set <- test_upset %>%
  select(c("bio_1_Annual_Mean_Temperature",
           "bio_2_Mean_Diurnal_Range",
           "bio_3_Isothermality",
           "bio_4_Temperature_Seasonality",
           "bio_7_Temperature_Annual_Range",
           "bio_8_Mean_Temperature_of_Wettest_Quarter",
           "bio_9_Mean_Temperature_of_Driest_Quarter",
           "bio_12_Annual_Precipitation",
           "bio_14_Precipitation_of_Driest_Month",
           "bio_15_Precipitation_Seasonality",
           "bio_18_Precipitation_of_Warmest_Quarter", "prec_May", "prec_Jun", "prec_Jul", "prec_Sep", "ai_Jan", "ai_Feb", "ai_Mar",    ai_Apr    ai_Nov    ai_Dec    srad_Jan    vapr_Jul    wind_Jan    wind_Sep
  ))
pdf("../UpSet_morethan100genes.pdf", width = 18, height = 6)
upset(my_set, nsets = length(my_set), line.size = 1, point.size = 3, sets.bar.color = "dodgerblue3", set_size.show = T,
      text.scale = 2.8, order.by = "freq", nintersects = 34, mb.ratio = c(0.4,0.6))
dev.off()
