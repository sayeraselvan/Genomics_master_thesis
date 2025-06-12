#!/bin/bash

process_sam() {
  SAM_FILE=$1
  OUT_PFX="${SAM_FILE%.sam}_sorted"

  # Sort the SAM file to BAM, ensuring coordinate order
  picard SortSam I="$SAM_FILE" O="${OUT_PFX}.bam" SORT_ORDER=coordinate

  # Verify that the BAM file is sorted
  if samtools view -H "${OUT_PFX}.bam" | grep -q 'SO:coordinate'; then
    echo "BAM file is sorted. Proceeding with MarkDuplicates." 
    # Mark duplicates
    picard -Xmx20g MarkDuplicates REMOVE_DUPLICATES=true \
      I="${OUT_PFX}.bam" O="${OUT_PFX}_rmdup.bam" \
      M="${OUT_PFX}_rmdup_metrics.txt" VALIDATION_STRINGENCY=SILENT

    # Get flagstat for the sorted BAM
    samtools flagstat "${OUT_PFX}.bam" > "${OUT_PFX}_flagstat.txt"

    # Index the BAM file
    samtools index "${OUT_PFX}.bam"

    # Get flag stats for the sorted BAM with duplicates marked
    samtools flagstat "${OUT_PFX}_rmdup.bam" > "${OUT_PFX}_rmdup_flagstat.txt"

    # Filter for mapped reads with a mapping quality >= 20
    samtools view -q 20 -F 0x0004 -b "${OUT_PFX}_rmdup.bam" > "${OUT_PFX}_rmdup_filtered.bam"

    # Get flag stats for the filtered BAM
    samtools flagstat "${OUT_PFX}_rmdup_filtered.bam" > "${OUT_PFX}_rmdup_filtered_flagstat.txt"
  else
    echo "BAM file is not sorted. Check the sorting step."
  fi
}

export -f process_sam  # Export the function to be used by parallel

# Find all SAM files and process them in parallel
find Sz*/ -name '*_pass_trimmed.sam' | parallel -j 8 process_sam


