#!/bin/bash

rscript="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/maxent_manual/9_speciesarea_calculation/scripts/corrected_regionarea.R"
python_script="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/maxent_manual/9_speciesarea_calculation/scripts/regionarea.py"
script="/netscratch/dep_coupland/grp_fulgione/siva/scripts/maxent/delete"

#repeat this for hi=EC, hi=E, hi=NE for each folder 
hi="EC"
first="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/${hi}_past/"
first1="/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/${hi}_past/regionarear"
for i in current gs85bi70 cc26bi50 cc26bi70 cc45bi50 cc45bi70 cc60bi50 cc60bi70 cc85bi50 cc85bi70; do
    heyah="Arabis_alpina_${i}_median.asc"
    output="${hi}_${i}_median"
    outputname="$first1/t_${hi}_Set_${i}.xlsx"
    outputname1="$first1/suitable_${hi}_Set_${i}.xlsx"
    output1="$script/$output"
    r_command="Rscript $rscript $heyah $output $first"
    python_command="python $python_script $output1 $outputname $outputname1"  # Modify with the actual command for your Python script
    combined_command="$r_command && $python_command"
    bsub -q short -R "rusage[mem=7000]" -M 10000 "$combined_command"
    echo $i
    #echo $output1
done

