#!/bin/bash

# Define the output merged VCF file name
MERGED_VCF="signor_final_184samples_gatk_all_chr_genotyped.vcf.gz"

# Initialize log file
LOG_FILE="merge_vcf.log"
echo "Starting VCF merge at $(date)" > "$LOG_FILE"

# Define the list of VCF files to merge
vcf_files=(
    "X_genotyped.vcf.gz"
    "2L_genotyped.vcf.gz"
    "2R_genotyped.vcf.gz"
    "3L_genotyped.vcf.gz"
    "3R_genotyped.vcf.gz"
    "4_genotyped.vcf.gz"
)

# Create a temporary file listing all VCF files
VCF_LIST="vcf_files_to_merge.list"
for vcf in "${vcf_files[@]}"; do
    echo "$vcf" >> "$VCF_LIST"
done

# Run Picard MergeVcfs command
picard MergeVcfs \
    INPUT="$VCF_LIST" \
    OUTPUT="$MERGED_VCF" \
    >> "$LOG_FILE" 2>&1

# Check if the merge was successful
if [[ $? -eq 0 ]]; then
    echo "VCF merge completed successfully at $(date)" >> "$LOG_FILE"
else
    echo "VCF merge failed at $(date)" >> "$LOG_FILE"
fi



