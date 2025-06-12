#!/bin/bash
# this is the main script 

start=$(date +%s)

if [ $# -lt 3 ] || [ $# -gt 4 ]; then
	echo "Usage: $0 <vcf_file> <tsv_file> <threshold_pvalue> <covariate_file>"
        exit 1
fi

vcf_file="$1"
tsv_file="$2"
threshold_pvalue="$3"
covariate_file="$4"

if [ ! -e $vcf_file ]; then
	echo "File $vcf_file does not exist"
	exit 0
elif [[ $vcf_file != *.vcf ]] && [[ $vcf_file != *.vcf.gz ]]; then
	echo "We prefer .vcf.gz file extension"
	exit 0
fi

no_samples=$(bcftools query -l $vcf_file | wc -l)
no_env=$(cat $tsv_file | wc -l)

if [[ $no_samples != $no_env ]]; then
	echo "No of samples and env variables are not equal, check the files again"
	exit 0
fi

vcf_prefix="${vcf_file%.vcf.gz}"

if [ -e ${vcf_prefix}.ped ] && [ -e ${vcf_prefix}.map ]; then
	echo -e "${vcf_prefix}.ped and ${vcf_prefix}.map already exists. Go to next step."
else
	if [[ $vcf_file == *.vcf ]]; then
		printf "vcftools --vcf $vcf_file --plink --out ${vcf_prefix}"
		vcftools --vcf $vcf_file --plink --out ${vcf_prefix}
	elif [[ $vcf_file == *.vcf.gz ]]; then
		printf "vcftools --gzvcf $vcf_file --plink --out ${vcf_prefix}"
		vcftools --gzvcf $vcf_file --plink --out ${vcf_prefix} 
	fi
fi


if [ "$#" -eq 4 ]; then
	covariate_file=$4
	if [ -e $covariate_file ]; then		
		covariatefile_lines=$(cat $covariate_file | wc -l)
		if [[ $covariatefile_lines != $no_env ]]; then
			echo $covariatefile_lines
			echo $no_env
			echo "No. in covariate file and no. of env variables are not equal! check the files again"
			exit 0	
		else
			covariate_prefix="${covariate_file%.*}"
		fi
	else
		echo "covariate file doesn't exist in this path"
		exit 0
	fi
fi

echo "VCFrun is succesful"

if [ -e ${vcf_prefix}.bed ] && [ -e ${vcf_prefix}.bim ] && [ -e ${vcf_prefix}.fam ]; then
	echo "${vcf_prefix}.bed, ${vcf_prefix}.bim, ${vcf_prefix}.fam already exist. Move on to next step."
else
	plink --file ${vcf_prefix} --make-bed --out ${vcf_prefix}
	printf "plink - bed/bim/fam files running"	
fi

echo "plink run to make bed/bim/fam files is successful" 
								
fam_file="${vcf_prefix}.fam"
output="${fam_file%.fam}1.fam"

awk '{$6=""; print}' "$fam_file" > "$output"

echo "6th column of fam file is modified"

tsv_file1="${tsv_file%.tsv}1.tsv"
output_file="${output%1.fam}.fam"

cut -f 2 $tsv_file > $tsv_file1

paste -d ' ' $output $tsv_file1 > $output_file
rm $tsv_file1 $output

echo "\n#######GEMMA pipeline is on########"

gemma -bfile ${output_file%.fam} -gk 1 -o ${output_file%.fam}_${tsv_file%.tsv}

#gemma -bfile ${output_file%.fam} -k output/${output_file%.fam}_${tsv_file%.tsv}.cXX.txt -lmm 4 -o ${output_file%.fam}_${tsv_file%.tsv}
gemma --bfile ${output_file%.fam} -k ${output_file%.fam}_${tsv_file%.tsv}.cXX.txt -c $covariate_file -lmm 4 -o ${output_file%.fam}_${tsv_file%.tsv}

output_gemma="${output_file%.fam}_${tsv_file%.tsv}.assoc.txt"

Rscript plot.R "$output_gemma" "$threshold_pvalue"

echo "R script has finished execution. Continuing with gemma script..."

current_path=$(pwd)
folder_name=$(basename "$current_path")
original_filename="manhattan_plot.png"

#new_filename="${folder_name}_${original_filename}"

new_filename="${vcf_prefix}_${tsv_file%.tsv}.png"

mv "$original_filename" "$new_filename"

echo "File renamed to: $new_filename"



