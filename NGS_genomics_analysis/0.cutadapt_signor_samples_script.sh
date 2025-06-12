#!/bin/bash

# Input directory containing .fastq.gz files
input_dir="/home/Siva/raw_data/signor"

# Create the input directory if it doesn't exist
if [ ! -d "$input_dir" ]; then
    echo "Error: Directory $input_dir not found."
    exit 1
fi

# Function to run cutadapt for a single file
run_cutadapt() {
    input_file="$1"

    # Check if the input file exists
    if [ ! -f "$input_file" ]; then
        echo "Error: File $input_file not found."
        return 1
    fi

    # Set the adapter sequence and cutadapt options
    adapter_seq="AGATCGGAAGAGCACACGTCTGAACTCCAGTCA"
    cutadapt_opts="--cores=12 --quality-cutoff 13 --minimum-length 35 --no-indels --action=trim"

    # Base name for the output file in the same directory
    base_name=$(basename "$input_file" ".fastq.gz")
    output_file="${base_name}_trimmed.fastq.gz"  # Output filename in the same directory

    echo "Processing $input_file with adapter sequence: $adapter_seq"

    # Run cutadapt with options
    cutadapt -a "$adapter_seq" -o "$output_file" "$input_file" $cutadapt_opts

    # Check for success
    if [ $? -eq 0 ]; then
        echo "Successfully processed $input_file -> $output_file"
    else
        echo "Error processing $input_file"
    fi
}

# Export the function for parallel usage
export -f run_cutadapt

# Find all .fastq.gz files in the input directory and process them in parallel
find "$input_dir" -name "*.fastq.gz" | parallel -j 40 run_cutadapt

echo "All FASTQ files have been processed in parallel."

