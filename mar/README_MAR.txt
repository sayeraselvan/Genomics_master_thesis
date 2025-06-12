Hey!

This is the complete documentation of the Mar analysis (mutation-area relationship) and this is extended from the paper titled "Genetic diversity loss in Antropocene" (https://www.science.org/doi/10.1126/science.abn5642)

Marpipeline.R used is created by the authors of the above mentioned paper and credits go to them,
I have extended this study onto the genetic diversity of Arabis alpina to understand how its genetic diveristy loss can be predicted over the species geographic loss and does it follow a power law curve. 

we are focussing on the count og segregating sites over the area range loss, we can randomly take 10,000 SNPs as follows. Since my project mainly focusses on the self compatible range of plants excluding outcrosses from Italy and Greece, I will be focussing on the genetic data of 933 Self compatible plants which i call them as SC_933.vcf.gz. From this large vcf file, we will focussing on the random SNPs from chromosome1 for our analysis, as we will follow the similar protocol of the above paper

I have performed the mar analysis (manual, command line are present in the ./scripts_manual_mar/1_README_geneticdata.txt)

Chr1 analysis without pruning, without maf filtration: Wholegenome analysis of the self compatible plants - taking 10,000 random SNPS out of all the complete genome, to reduce the complexity and the keep the extent of computational power sufficient enough, I subsetted only the chr1 genomic data and randomly sampled 10k snps

./mar_chr1_wholegenome_analysis/ 
	|
	|-> mar_results_chr1_10k_snps_1degree_mapresolution/ (chr1 dataset, 10ksnps, 1degree map, 100 nsamplesMAR) this leads to a z = 0.3994184
	|
	|-> mar_script_chr1_10k_snps_1degree_mapresolution.R (script used for the above analysis)


The value of z = 0.399 is obtained by trying to fit the segregating site count (M) with respect the grid cell area (A) into the power law M = c*A^z 

Refer to ./scripts_manual_mar/2_README_marpipeline.txt for complete understanding

./scripts_manual_mar/
	|
	|-> 1_README_geneticdata.txt: This manual file contains how the genetic data has been processed for the mar pipeline
	|
	|-> 2_README_marpipeline.txt: Marpipeline manual
	|
	|-> 3_plotscripts_mar.R: this section contains the plot script for mar pipeline outputs
 
./vcf_mar/ -> has all the files neccessary to run marpipeline

Thank you so much!

With kind regards,
Siva
