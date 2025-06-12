#!/bin/bash

# Function to process BAM files within a folder
process_bam_files() {
  FOLDER=$1
  OUTPUT_FILE="${FOLDER%/}_bam_stats.txt"  # Create a stats file for each folder

  # Create or empty the folder-specific stats file
  > "$OUTPUT_FILE"

  # Find all BAM files (sorted, rmdup, and filtered) in the folder
  for BAM_FILE in "${FOLDER}"*.bam; do
    if [[ -f "$BAM_FILE" ]]; then
      echo "Processing BAM file: $BAM_FILE" >> "$OUTPUT_FILE"

      # Run samtools stats, extract the 'SN' lines, and append output to the folder-specific file
      samtools stats "$BAM_FILE" | grep ^SN | cut -f 2- >> "$OUTPUT_FILE"

      echo "--------------------------------------------------" >> "$OUTPUT_FILE"
    else
      echo "No BAM file found in folder: $FOLDER" >> "$OUTPUT_FILE"
    fi
  done

  echo "BAM stats for folder $FOLDER written to: $OUTPUT_FILE"
}

export -f process_bam_files  # Export the function to be used by parallel

# Find all directories that match the pattern Sz*
dirs=()
for dir in Sz*/; do
  dirs+=("$dir")
done

# Run the process_bam_files function in parallel for each folder
if [[ ${#dirs[@]} -gt 0 ]]; then
  parallel -j 8 process_bam_files ::: "${dirs[@]}"
else
  echo "No directories found matching the pattern Sz*"
fi

