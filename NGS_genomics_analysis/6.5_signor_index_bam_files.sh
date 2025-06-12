#!/bin/bash

# Function to index BAM files
index_bam() {
    folder="${1%/}"  # Remove any trailing slash from folder name
    input_bam="${folder}/${folder}_pass_trimmed_sorted_rmdup_filtered.bam"
    
    # Check if the input BAM file exists
    if [[ -f "$input_bam" ]]; then
        echo "Indexing ${input_bam}..." | tee -a "${folder}/${folder}_index.log"
        samtools index "$input_bam" &>> "${folder}/${folder}_index.log"
        echo "Indexed ${input_bam}" | tee -a "${folder}/${folder}_index.log"
    else
        echo "BAM file not found for ${folder}, skipping indexing." | tee -a "${folder}/${folder}_index.log"
    fi
}

export -f index_bam  # Export the function for GNU parallel

# Run the command in parallel for each folder, with up to 178 concurrent jobs
echo "Starting BAM indexing with up to 178 concurrent jobs..."
parallel -j 45 index_bam ::: Sz*/

# Notify completion
echo "BAM indexing completed."


