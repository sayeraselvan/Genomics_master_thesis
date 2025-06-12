# Load required libraries
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

# Define directories based on the analysis type
input_dir <- paste0("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/", analysis_type, "/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/association_files_results_gemma")
output_dir <- paste0("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/", analysis_type, "/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/association_files_results_gemma_FDR_corrected/")
manhattan_plot_dir <- paste0("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/", analysis_type, "/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/manhattan_plots/")
significant_snp_dir <- paste0("/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/", analysis_type, "/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/significant_snps_fdr_threshold/")

# Create necessary directories
dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(manhattan_plot_dir, showWarnings = FALSE, recursive = TRUE)
dir.create(significant_snp_dir, showWarnings = FALSE, recursive = TRUE)

# List of association files
f_short <- list.files(path = input_dir, full.names = FALSE, pattern = "assoc")

# Options
options(scipen = 100, digits = 4)

# Process each file
for (i in 1:length(f_short)) {

  gwscanfile <- file.path(input_dir, f_short[i])
  print(gwscanfile)

  # Import GEMMA results
  gwscan1 <- read.table(gwscanfile, as.is = "rs", header = TRUE)

  # Exclude rows with NaN
  gwscan <- gwscan1[complete.cases(gwscan1), ]

  # Threshold function
  FDR <- function(pvals, FDR){
    pvalss <- sort(pvals, decreasing = FALSE)
    m <- length(pvalss)
    cutoffs <- ((1:m)/m) * FDR
    logicvec <- pvalss <= cutoffs
    postrue <- which(logicvec)
    k <- max(c(postrue, 0))
    cutoff <- (((0:m)/m) * FDR)[k + 1]
    return(cutoff)
  }

  # Compute FDR threshold
  fdrlog10 <- -log10(FDR(gwscan$p_lrt, 0.005))
  fdr_threshold <- 10^(-fdrlog10)
  BC <- -log10(0.05/nrow(gwscan))

  # Adjust p-values
  gwscan$fdr_corrected <- p.adjust(gwscan$p_lrt, method = "BH")
  gwscan$fdr_corrected_wald <- p.adjust(gwscan$p_wald, method = "BH")

  # Prepare output
  gwscan_output <- cbind.data.frame(gwscan$chr, gwscan$rs, gwscan$ps, gwscan$p_lrt, gwscan$p_wald, gwscan$fdr_corrected, gwscan$fdr_corrected_wald)
  colnames(gwscan_output) <- c("CHR", "RS", "POSITION", "p_lrt", "p_wald", "fdr_corrected", "fdr_corrected_wald")

  # Identify significant SNPs
  significant_snps <- gwscan[gwscan$fdr_corrected_wald < fdr_threshold, ]
  significant_snp_file <- file.path(significant_snp_dir, sub(".assoc\\.txt$", "_significant_snps.txt", basename(f_short[i])))

  # Save significant SNPs to a file
  write.table(significant_snps, significant_snp_file, row.names = FALSE, quote = FALSE, sep = "\t")

  print(paste("Significant SNPs saved to:", significant_snp_file))

  # Write output
  output_file <- file.path(output_dir, f_short[i])
  write.table(gwscan_output, output_file, row.names = FALSE, quote = FALSE, sep = "\t")

  # Generate Manhattan plot
  png(filename = file.path(manhattan_plot_dir, sub(".assoc\\.txt$", "_manhattan_plot.png", basename(f_short[i]))),
      width = 1600, height = 1000)

  par(cex.lab = 1, cex.axis = 1, cex.main = 1, cex.sub = 1, cex = 1.9)
  chr = "CHR"
  bp = "POSITION"
  snp = "RS"
  manhattan_plot <- manhattan(gwscan_output, chr = chr, bp = bp, snp = snp, p = "fdr_corrected_wald",
                              genomewideline = FALSE, suggestiveline = FALSE,
                              highlight = NULL, col = c("blue", "orange"))

  # Add significance lines
  abline(h = BC, col = "black")
  abline(h = fdrlog10, col = "black", lty = 2)

  print(manhattan_plot)

  dev.off()

  print(paste("Manhattan plot created for:", f_short[i]))
}
