#!/bin/bash

# Path to the folder containing the SRR directories
base_dir="/home/Siva/raw_data/test/signor/cut"  # Change this to your actual folder path

# Path to the file containing SRR to strain mappings
map_file="/home/Siva/raw_data/test/signor/file_names_samples.txt"  # Change this to where you store the mappings

# Loop through the mapping file
while read -r srr strain; do
    # Rename folder
    if [ -d "$base_dir/$srr" ]; then
        mv "$base_dir/$srr" "$base_dir/$strain"
    fi
    
    # Rename the file inside the renamed folder
    if [ -f "$base_dir/$strain/${srr}_pass_trimmed.fastq.gz" ]; then
        mv "$base_dir/$strain/${srr}_pass_trimmed.fastq.gz" "$base_dir/$strain/${strain}_pass_trimmed.fastq.gz"
    fi
done < "$map_file"

