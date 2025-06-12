#!/bin/bash

# Reference prefix for BWA-MEM2
REF_PFX="/home/Siva/raw_data/simulans/ref/dsimM252v1.2"

# Process each directory one at a time
for dir in Sz*/; do
  cd "$dir" || continue
  
  # Get the name of the fastq.gz file
  files=(*_pass_trimmed.fastq.gz)
  
  if [[ ${#files[@]} -eq 1 ]]; then
    f="${files[0]}"
    
    OUT_PFX="$(cut -d '.' -f 1 <<<"$f")"
    
    HEADER="$(zcat "$f" | head -n 1)"
    RG_ID="${HEADER%% *}"  # Get the read group ID (e.g., SRR3585482)
    RG_ID="${RG_ID/@/}"    # Remove '@' if present
    
    FLOWCELL_ID="$(echo "$HEADER" | cut -d ':' -f 3)"  # Extract 'C4Y5PACXX'
    LANE="$(echo "$HEADER" | cut -d ':' -f 4)"          # Extract '1'
    
    PU="${FLOWCELL_ID}.${LANE}"
    
    SM="$OUT_PFX"
    echo "$f : $RG_ID $SM $PU"
    RG="@RG\tID:${RG_ID%.*.*}\tPL:ILLUMINA\tSM:${SM%_pass_trimmed}".

    # Run BWA-MEM2 for mapping
    bwa-mem2 mem -t 40 -R "$RG" "$REF_PFX" "$f" > "${OUT_PFX}.sam"

    echo "Mapping completed for $f in $dir"
    
  else
    echo "No or multiple FASTQ files found in $dir"
  fi
  
  cd ..
done

