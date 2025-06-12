#!/bin/bash

# Create a new folder for all the .g.vcf.gz files
#mkdir -p all_gvcfs

# Loop through each directory named Sz* and move the .g.vcf.gz files
for dir in Sz*; do
    if [[ -d "$dir" ]]; then
        gvcf_file="$dir/${dir}.g.vcf.gz.tbi"
	#gvcf_file="$dir/${dir}.g.vcf.gz"

        if [[ -f "$gvcf_file" ]]; then
            mv "$gvcf_file" all_gvcfs/
        else
            echo "Warning: GVCF file not found for sample $dir"
        fi
    fi
done

echo "All .g.vcf.gz files moved to 'all_gvcfs' directory."

