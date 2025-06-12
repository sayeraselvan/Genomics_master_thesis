#!/bin/bash

# this script is for the individual analysis of the snp and looking at if they are merging in any  genes or not
# Check if all required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <chromosome> <snp_position> <range>"
  exit 1
fi

# Assign command-line arguments to variables
CHR="$1"
SNP_POSITION="$2"
#RANGE="$3"

# Extract the gene name(s) and note(s) where the SNP position is within the gene
awk -v chr="$CHR" -v snp="$SNP_POSITION" \
  '$1 == chr && $3 == "gene" && snp >= $4 && snp <= $5 { print $9 }'  /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff | awk -F";" '{print $0, $6}' | awk -F"=" '{print $2, $3}'

