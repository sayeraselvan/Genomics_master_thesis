#!/bin/bash

# Define the sample map file to be created
sample_map_file="cohort.sample_map"

# Clear the existing sample map file or create a new one
> "$sample_map_file"

# Loop through each .g.vcf.gz file in all_gvcfs to populate the sample map
for gvcf_file in *.g.vcf.gz; do
    # Extract sample name from the file name (assuming sample name is the directory name)
    sample_name=$(basename "$gvcf_file" .g.vcf.gz)
    echo -e "${sample_name}\t${gvcf_file}" >> "$sample_map_file"
done

echo "Sample map file '$sample_map_file' created successfully."

