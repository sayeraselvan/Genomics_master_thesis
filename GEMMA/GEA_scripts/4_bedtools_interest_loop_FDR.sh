#!/bin/bash

input="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input


#!/bin/bash

input1="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input1



#!/bin/bash

input2="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input2


#!/bin/bash

input3="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/pruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input3


#!/bin/bash

input4="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input4


#!/bin/bash

input5="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input5



#!/bin/bash

input6="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input6


#!/bin/bash

input7="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/unpruned/no_covariates/without_FDR_correction_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input7



#!/bin/bash

input8="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input8


#!/bin/bash

input9="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input9



#!/bin/bash

input10="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input10


#!/bin/bash

input11="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/unpruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input11



#!/bin/bash

input12="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/alps/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input12


#!/bin/bash

input13="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/SC/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input13



#!/bin/bash

input14="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/scad/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input14


#!/bin/bash

input15="/netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/file_list.txt"

while read line; do
        BIOCLIM=$(echo $line | cut -d',' -f1)
        bedtools intersect -a /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/AA_chr/${BIOCLIM}.FDR.sig.bed -b /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/Arabis_alpina_mpipz_v5.1_annotation.gff -wb | tee /netscratch/dep_coupland/grp_fulgione/siva/gemma/RESULTS_GEA/spain/pruned/no_covariates/FDR_corrected_without_covariate_gemma_lmm/snp_to_gene/bedtools_intersect/${BIOCLIM}_bedtools_intersect_FDR_wb_out.txt
done < $input15




