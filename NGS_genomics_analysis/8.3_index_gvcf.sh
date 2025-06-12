#!/bin/bash

# Directory containing the GVCF files
GVCF_DIR="/home/vetlinux05/Siva/raw_data/test/signor/cut/all_gvcfs"

# Function to create TBI index if it doesn't already exist
create_index() {
    local gvcf_file="$1"
    if [[ -f "${gvcf_file}.tbi" ]]; then
        echo "TBI index for ${gvcf_file} already exists. Skipping."
    else
        echo "Creating TBI index for ${gvcf_file}..."
        gatk IndexFeatureFile -I "$gvcf_file"

        # Check if indexing was successful
        if [[ $? -eq 0 ]]; then
            echo "TBI index created for ${gvcf_file}."
        else
            echo "Failed to create TBI index for ${gvcf_file}."
        fi
    fi
}

export -f create_index  # Export the function for parallel

# Run the indexing in parallel for all .g.vcf.gz files in the directory
find "$GVCF_DIR" -name "*.g.vcf.gz" | parallel -j 10 create_index {}

echo "Parallel indexing complete."

