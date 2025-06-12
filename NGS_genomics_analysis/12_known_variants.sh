#!/bin/bash

# Define the reference file
ref="/home/Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz"

# Input VCF file
input_vcf="signor_final_184samples_gatk_all_chr_genotyped.vcf.gz"

# indexing 
gatk IndexFeatureFile -I "${input_vcf}"

# Select SNPs from the input VCF
gatk SelectVariants -R "${ref}" -V "${input_vcf}" --select-type SNP -O raw_snps.vcf.gz

# Apply variant filtration to the selected SNPs
gatk VariantFiltration \
  -R "${ref}" \
  -V raw_snps.vcf.gz \
  -O filtered_snps.vcf.gz \
  -filter-name "QD_filter" -filter "QD < 2.0" \
  -filter-name "FS_filter" -filter "FS > 60.0" \
  -filter-name "MQ_filter" -filter "MQ < 40.0" \
  -filter-name "SOR_filter" -filter "SOR > 4.0" \
  -filter-name "MQRankSum_filter" -filter "MQRankSum < -12.5" \
  -filter-name "ReadPosRankSum_filter" -filter "ReadPosRankSum < -8.0" \
  -genotype-filter-expression "DP < 10" \
  -genotype-filter-name "DP_filter" \
  -genotype-filter-expression "GQ < 10" \
  -genotype-filter-name "GQ_filter"

# Select only the filtered SNPs
gatk SelectVariants \
  --exclude-filtered \
  -V filtered_snps.vcf.gz \
  -O known_variants_gatk.vcf.gz

echo "Variant filtering and selection completed."

