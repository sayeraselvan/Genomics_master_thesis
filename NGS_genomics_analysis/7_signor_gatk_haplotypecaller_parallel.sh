#!/bin/bash

# Reference genome path
REFERENCE="/home/Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz"

# Function to run GATK HaplotypeCaller and log output
run_gatk() {
    folder="${1%/}"  # Remove any trailing slash from folder name
    input_bam="${folder}/${folder}_pass_trimmed_sorted_rmdup_filtered.bam"
    output_gvcf="${folder}/${folder}.g.vcf.gz"
    bamout="${folder}/${folder}.out.bam"
    log_file="${folder}/${folder}_gatk.log"
    
    # Check if the input BAM file exists
    if [[ -f "$input_bam" ]]; then
        echo "Processing ${folder}..." | tee -a "$log_file"
        gatk HaplotypeCaller -R "$REFERENCE" -I "$input_bam" -O "$output_gvcf" -bamout "$bamout" -ERC GVCF 2> "$log_file"
        echo "Completed ${folder}" | tee -a "$log_file"
    else
        echo "BAM file not found for ${folder}, skipping." | tee -a "$log_file"
    fi
}

export REFERENCE  # Export variables for GNU parallel
export -f run_gatk  # Export function for GNU parallel

# Run the command in parallel for each folder, with up to 20 concurrent jobs
parallel -j 20 run_gatk ::: Sz*/

