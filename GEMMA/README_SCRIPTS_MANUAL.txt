This is the scripts manual used for the GEA (genome-environmental association) - GEMMA analysis, and in each step we will discuss and describe in detail what each scripts stands for and where the corresponding results are saved and apparently the folders are named such a way that the analysis are performed accordingly..


Lets describe in detail the folders arrangements first and then we will move onto what the scripts does and which commands lines are used to extract the information:

GEMMA script used: /netscratch/dep_coupland/grp_fulgione/siva/gemma/GEA_scripts/1_Gemma_script.sh

./RESULTS_GEA
	|
	|-> ${region}/ 
		|-> ${pruning_conditions}/ 
			|-> ${geneticPCs_covariates_condtion}/
				|-> ${FDR_conditions}/ 
					|-> association_files_results_gemma_FDR_corrected/
					|-> manhattan_plots/
					|-> significant_snps_fdr_threshold/ 
					|-> climate_tsv
					|-> snp_to_gene
						|-> AA_chr/
						|-> bedtools_intersect/
						|-> gene_list_per_variable/
						|-> rehh_output/
						|-> complete_gene_list.csv
						|-> file_list.txt
				
Each file is explained in detail:

1. ${region} stands for SC, spain, scad and alps, the results placed within this folder  -> the vcf file used for this analysis are all in the /netscratch/dep_coupland/grp_fulgione/siva/vcf/complete/${region} and the manual on how the vcf files are created are given in the respective folder.

	${region}/ 
	|-> SC/ (self_compatible_range_dataset_933_plants{this is the combined total of scad, spain and alps})
	|-> scad/ (scandinavainas_range_dataset_303_plants)
	|-> spain/ (spain,portugal_range_dataset_349_plants)
	|-> alps/ (central_european_alps_dataset_281_plants)

	script used: ./GEA_scripts/0_README_dataset_vcfcomplete_climatetsv.txt

2. ${pruning_conditions} this folder stands for the pruned/unpruned dataset results for each region and the vcf files are present in the /netscratch/dep_coupland/grp_fulgione/siva/vcf/complete/${region}/ (this is done by plink --indep-pairwise 50 5 0.5)
	
	${pruning_conditions}
	|-> pruned/ (pruned genetic vcf.gz dataset after biallelic, maf and missing data filration used)
	|-> unpruned/ (unpruned genetic dataset after biallelic, maf and missing data filtration used)
	
	script used: ./GEA_scripts/0_README_dataset_vcfcomplete_climatetsv.txt

3. ${geneticPCs_covariates_condition} stands for no_covariates/additional_genetic_pc_as_covariates, and it is not neccessary to use genetic PCs as covarites but it can be done, so i performed with and without the usage of covariate file (only for SC region) and for other regions, i performed the gemma analysis without the usage of covariates. All the gemma analysis is performed with the usage of centered_related_matri to account for population structure. 
	
	${geneticPCs_covariates_condtion}
	|-> additional_genetic_pc_as_covariates/ (genetic PCs as covarites are used within along with relatedness matrix)
	|-> no_covariates/ (only relatedness matrix is used in the gemma anaysis)
	
	the command line to create the genetic PCs for usaage: ./GEA_scripts/0_README_dataset_vcfcomplete_climatetsv.txt

4. ${FDR_conditions} stands for FDR_corrected_with_covariate_gemma_lmm/without_FDR_correction_with_covariate_gemma_lmm stands whether the p_wald scores gotten as the result from the gemma is been p_adjusted by BH correction/ or not.

	${FDR_condtions}
	|-> FDR_corrected_with_covariate_gemma_lmm/ (this pvalues are p-adjusted after the gemma analysis)
	|-> without_FDR_correction_with_covariate_gemma_lmm (these pvalues are not p-adjusted after the gemma analysis)

FDR_correction: (by this, i mean the p-value adjusted by BH correction, along with manhattan plots scripts also mentioned)
	(a) scripts used for pruned: ./GEA_scripts/2_pruned_dataset_FDR_correction_manhattan_script_significantsnps
	(b) scripts used for unpruned: ./GEA_scripts/2_unpruned_dataset_FDR_correction_manhattan_script_significantsnps.R

5. association_files_results_gemma_FDR_corrected/
	This folder has the association results of the gemma after the FDR_correction, *.assoc.txt has the p_scores adjusted
   association_files_results_gemma/
	This folder has the association output files of the gemma analysis, *.assoc.txt has the p_scores for each SNPs

6. manhattan_plots/
	This folder has the images/plots/ manhattan plots of all the gemma outputs and the files are named accordingly, i used fdr_corrected_wald scores for  FDR_corrected_without_covariate_gemma_lmm/ folder within and p_wald scores for without_FDR_correction_without_covariate_gemma_lmm/ folder within
	
	(a) scripts used: ./GEA_scripts/2_pruned_dataset_FDR_correction_manhattan_script_significantsnps.R
	(b) scripts used: ./GEA_scripts/1_manhatthan_plot_attached_with_gemma_script.R

7. climate_tsv/ 
	This folder has all the tsv file used for the gemma analysis inputs - this has the climatic data of the present day coordinates of the samples within the vcf file. these individual tsv file are created from /netscratch/dep_coupland/grp_fulgione/siva/environmental_climatic_data/

8. significant_snps_fdr_threshold/
	This folder has the significant snps outputted from the association_files_results_gemma_FDR_corrected/ where the significant snps are selected by having a manual fdr threshold created by myself and this is just to see the amount of snps which passes the black dotted line of significance in the manhattan plot 
	
	(a) scripts used: ./GEA_scripts/2_pruned_dataset_FDR_correction_manhattan_script_significantsnps.R

9. snp_to_gene/
	This folder has the anaysis of the conversion of the significant snps from the output of gemma (assoc.txt) then find the corresponding genes within the region 

(a) Finding the regions of significance gemma: 
	snp_to_gene/rehh_output/ this has the output of the individual snps within the region based on the identifiation of the candiate region of significance based on the minimum nunber of markers to 4, and the minimum number of markers passing the threshold of -(log10(0.05/number of snps)) to be 2 within the window of 5000bp and overlaping window of 2500
	snp_to_gene/AA_chr/ this has the output of the chrom, start and the end of a region of significance 
	
	scripts used: ./GEA_scripts/3_FDR_pruned_regions_of_significance_gemma_loop.R, ./GEA_scripts/3_FDR_unpruned_regions_of_significance_gemma_loop.R, ./GEA_scripts/3_withoutFDR_pruned_regions_of_significance_gemma_loop.R, ./GEA_scripts/3_withoutFDR_unpruned_regions_of_significance_gemma_loop.R

		
(b) Bedtools interect:
	snp_to_gene/bedtools_intersect/ this folder has the bed file output for the output of AA_chr/ by searching them across the annotation gff. file
	
	scripts used: GEA_scripts/4_bedtools_interest_loop_FDR.sh

(c) Gene list identification for each variable:
	snp_to_gene/gene_list_per_variable/ this folder has individual files for each climatic variable where it specifiies the list of gene names within the region of significance, derived from the output of bedtools_intersect.
	snp_to_gene/complete_gene_list.csv this csv file is similair to a presence absence matrix csv file made by cumalative dumping of all climatic variables's gene list and this gives us the idea of the common genes shared within the region

	scripts used: ./GEA_scripts/5_FDR_pruned_gene_lists_gene_search_FDR_wrp.R, ./GEA_scripts/5_FDR_unpruned_gene_lists_gene_search_FDR_wrp.R, ./GEA_scripts/5_withoutFDR_pruned_gene_lists_gene_search_FDR_wrp.R , ./GEA_scripts/5_withoutFDR_unpruned_gene_lists_gene_search_FDR_wrp.R

(d) upset_plot and gene enrichment (topGO) analysis and individual snp analysis:
	Upset plot can be created from the complete_gene_list.csv file and from each individual gene_list file in the snp_to_gene/gene_list_per_variable/ we can make a gene ontology analysis and for each snp position, we can decide whether the snp lies within a gene or not by the help of below scripts named as such as the job implies.	

	scripts used: ./GEA_scripts/6_upset_plot.R, ./GEA_scripts/7_gene_enrichment_topGO_analysis.R, ./GEA_scripts/8_snpanalysis.sh

the order of individual scripts used are named in the ./GEA_scripts/ folder such that the files are named in such a way and numbered such a way of implying the steps in detail and their description of individual scripts and their outputs, inputs are specified in the above text.


Thank you!
With kind regards,
Siva Subramanian Ayeraselvan
