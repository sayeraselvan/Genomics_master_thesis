#!/bin/bash

# Define input VCF file and output folder
VCF_FILE="signor_final_184samples_gatk_all_chr_genotyped.vcf.gz"
OUTPUT_FOLDER="analysis_filtered_signor_final_184samples_gatk_all_chr_genotyped"
OUTPUT_PREFIX="${OUTPUT_FOLDER}/vcf_analysis"

# Create the output folder if it doesn't exist
mkdir -p $OUTPUT_FOLDER

# Create a log file inside the output folder
LOG_FILE="${OUTPUT_FOLDER}/analysis_summary.log"
echo "VCF Analysis Started at $(date)" > "$LOG_FILE"

# Define commands to run in parallel
commands=(
  "vcftools --gzvcf $VCF_FILE --het --out ${OUTPUT_PREFIX}_het"
  "vcftools --gzvcf $VCF_FILE --hardy --out ${OUTPUT_PREFIX}_hardy"
  "vcftools --gzvcf $VCF_FILE --TajimaD 1000 --out ${OUTPUT_PREFIX}_tajimaD"
  "vcftools --gzvcf $VCF_FILE --indv-freq-burden --out ${OUTPUT_PREFIX}_ifreqburden"
  "vcftools --gzvcf $VCF_FILE --relatedness --out ${OUTPUT_PREFIX}_relatedness"
  "vcftools --gzvcf $VCF_FILE --relatedness2 --out ${OUTPUT_PREFIX}_relatedness2"
  "vcftools --gzvcf $VCF_FILE --site-quality --out ${OUTPUT_PREFIX}_site_quality"
  "vcftools --gzvcf $VCF_FILE --missing-indv --out ${OUTPUT_PREFIX}_missing_indv"
  "vcftools --gzvcf $VCF_FILE --missing-site --out ${OUTPUT_PREFIX}_missing_site"
  "vcftools --gzvcf $VCF_FILE --SNPdensity 10000 --out ${OUTPUT_PREFIX}_snp_density"
  "vcftools --gzvcf $VCF_FILE --kept-sites --out ${OUTPUT_PREFIX}_kept_sites"
  "vcftools --gzvcf $VCF_FILE --removed-sites --out ${OUTPUT_PREFIX}_removed_sites"
  "vcftools --gzvcf $VCF_FILE --singletons --out ${OUTPUT_PREFIX}_singletons"
  "vcftools --gzvcf $VCF_FILE --hist-indel-len --out ${OUTPUT_PREFIX}_indel_hist"
  "vcftools --gzvcf $VCF_FILE --extract-FORMAT-info GT --out ${OUTPUT_PREFIX}_GT_INFO"
  "vcftools --gzvcf $VCF_FILE --get-INFO NS --get-INFO DB --out ${OUTPUT_PREFIX}_INFO"
)

# Export variables for parallel execution
export VCF_FILE OUTPUT_FOLDER OUTPUT_PREFIX

# Run commands in parallel, limit to 4 jobs at a time
# Adjust `-j 10` to a higher or lower number based on available CPU cores
parallel -j 10 ::: "${commands[@]}"

# Completion message
echo "VCF Analysis Completed at $(date)" | tee -a "$LOG_FILE"

