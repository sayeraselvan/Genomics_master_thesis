#!/bin/bash

# Set the directory where your files are located, ### scripy to make the folders with the names:
input_dir="/home/vetlinux05/Siva/raw_data/test/signor/cut"  # Change this to your actual folder path

# Loop through each fastq.gz file in the directory
for file in "$input_dir"/*_pass_trimmed.fastq.gz; do
    # Extract the SRR number from the filename
    base_name=$(basename "$file")
    srr_number=$(echo "$base_name" | cut -d'_' -f1)

    # Create a directory named after the SRR number
    mkdir -p "$input_dir/$srr_number"

    # Optionally, move the corresponding file into the new directory
    mv "$file" "$input_dir/$srr_number/"
done
