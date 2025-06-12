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
# Set working directory based on analysis type
setwd(paste0("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/", analysis_type, "/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/association_files_results_gemma_FDR_corrected/"))

# Get list of association files
f_short <- list.files(full.names = FALSE, pattern = "assoc")
options(scipen = 100, digits = 4)

# Process each file
for (i in 1:length(f_short)) {

  gwscanfile <- f_short[i]
  print(paste("Processing file:", gwscanfile))

  # Import GEMMA results
  gwscan1 <- read.table(gwscanfile, as.is = TRUE, header = TRUE)

  # Exclude rows with NaN
  gwscan <- gwscan1[complete.cases(gwscan1), ]
  BC <- -log10(0.05 / nrow(gwscan))
  # Convert table to rehh format
  gwscan <- transform(gwscan, fdr_corrected_wald = -log10(fdr_corrected_wald))
  gwscan_rehh <- cbind.data.frame(gwscan$CHR, gwscan$POSITION, gwscan$fdr_corrected_wald)

  colnames(gwscan_rehh) <- c("CHR", "POSITION", "LOGPVALUE")

  # Delineate candidate regions
  significant_regions_gwscan <- calc_candidate_regions(
    gwscan_rehh,
    threshold = BC,
    pval = TRUE,
    ignore_sign = FALSE,
    window_size = 5000,
    overlap = 2500,
    right = TRUE,
    min_n_mrk = 4,
    min_n_extr_mrk = 2,
    min_perc_extr_mrk = 0,
    join_neighbors = TRUE
  )

  # Create necessary directories
  output_dirs <- c("../snp_to_gene/", "../snp_to_gene/rehh_output", "../snp_to_gene/AA_chr", "../snp_to_gene/bedtools_intersect", "../snp_to_gene/gene_list_per_variable")
  lapply(output_dirs, dir.create, showWarnings = FALSE, recursive = TRUE)

  # Write the significant regions to a file
  write.table(significant_regions_gwscan, paste0("../snp_to_gene/rehh_output/", gwscanfile, ".FDR.sig.txt"), row.names = FALSE, quote = FALSE, sep = "\t")

  # Prepare bedtools file
  bedtools_file <- significant_regions_gwscan %>%
    select(chrom = CHR, start = START, end = END)
  bedtools_file$chrom <- sub("^", "chr", bedtools_file$chrom)

  # Write bedtools file
  write.table(bedtools_file, paste0("../snp_to_gene/AA_chr/", gwscanfile, ".FDR.sig.bed"), row.names = FALSE, col.names = TRUE, quote = FALSE, sep = "\t")

}

# Write the list of processed files
write.table(f_short, "../snp_to_gene/file_list.txt", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")

cat("Processing completed.\n")
