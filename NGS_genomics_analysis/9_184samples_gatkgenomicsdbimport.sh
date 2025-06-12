#!/bin/bash

# Define memory allocation and path to temporary storage
MEMORY="40g"  # Adjust as needed if more memory is available
TMP_DIR="/home/vetlinux05/Siva/raw_data/test/signor/cut/all_gvcfs/tmp"
SAMPLE_MAP="cohort.sample_map"
LOG_FILE="gatk_genomicsdbimport.log"

# Define the chromosomes you want to process
CHROMOSOMES=("X" "2L" "2R" "3L" "3R" "4")

# Export variables for use in the parallel environment
export MEMORY TMP_DIR SAMPLE_MAP LOG_FILE

# Initialize log file
echo "Starting GenomicsDBImport for each chromosome at $(date)" > $LOG_FILE

# Run GenomicsDBImport in parallel for each chromosome
parallel -j 6 "gatk --java-options '-Xmx${MEMORY} -Xms${MEMORY}' GenomicsDBImport \
       --genomicsdb-workspace-path my_database_chr{1} \
       --batch-size 50 \
       -L {1} \
       --sample-name-map ${SAMPLE_MAP} \
       --tmp-dir ${TMP_DIR} \
       --reader-threads 5 && \
       echo 'Chromosome {1} completed at $(date)' >> ${LOG_FILE}" ::: "${CHROMOSOMES[@]}"

# Write final log entry
echo "All chromosomes processed and completed at $(date)" >> ${LOG_FILE}
echo "All jobs completed successfully. Log saved to ${LOG_FILE}."

