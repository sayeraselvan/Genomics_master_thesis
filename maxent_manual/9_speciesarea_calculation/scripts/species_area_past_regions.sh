#!/bin/bash

rscript="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/maxent_manual/9_speciesarea_calculation/scripts/corrected_regionarea.R"
python_script="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/maxent_manual/9_speciesarea_calculation/scripts/regionarea.py"
script="/netscratch/dep_coupland/grp_fulgione/siva/scripts/maxent/delete"

#repeat this with hi=E, hi=EC, hi=NE for e standing for extrapotion, ec with free extraploation with clamping, NE stands for no extrapolation

hi="E"


first="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/${hi}_past/masked/"
first1="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/${hi}_past/regionarear"

#for i in 1 10 -10 -20 -30 -40 -50 -60 -70 -80 -90 -100 -110 -120 -130 -140 -150 -160 -170 -180 -190 -200; do

for i in -20; do
    heyah="Arabis_alpina_Set_${i}_median_masked.asc"
    output="${hi}_${i}_median_masked"
    outputname="$first1/median_t_${hi}_Set_${i}.xlsx"
    outputname1="$first1/median_suitable_${hi}_Set_${i}.xlsx"
    output1="$script/$output"
    r_command="Rscript $rscript $heyah $output $first"
    python_command="python $python_script $output1 $outputname $outputname1"  # Modify with the actual command for your Python script
    combined_command="$r_command && $python_command"
    bsub -q short -R "rusage[mem=7000]" -M 9000 "$combined_command"
    echo $i
    #echo $output1
done

