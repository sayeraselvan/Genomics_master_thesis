#!/bin/bash

# Set the queue and resource constraints
queue="multicore40"
mem_per_task=25000
total_memory=50000

for i in {1..19}; do
    bio_number="bio_$i"

    # Command to execute Rscript with bsub
    cmd="bsub -q $queue -R 'rusage[mem=$mem_per_task]' -M $total_memory \"Rscript /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/maxent_manual/1_downloadclimate/bufferdistance.R /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/database_climate_presence_locations/worldclimtiffilesof1970to2000/wc2.1_30s_bio_${bio_number}.tif /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/database_climate_presence_locations/current_trainingarea_climatedata/bufferdistance400kmtrainingarea/output_wc2.1_30s_bio_${bio_number}.asc\""

    # Execute the command
    eval "$cmd"
done


