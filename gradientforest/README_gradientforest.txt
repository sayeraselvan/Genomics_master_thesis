Hi, This folers contains the readme file for the gradeint forest analyses: 

2.8 Gradient Forest
We modeled the present-day patterns of genetic variation using a gradient forest (GF) analysis. This was implemented using the package “gradientForest” (Breiman, 2001) in R. This employs a nonparametric, machine-learning regression tree approach to map turnover patterns in biological composition using nonlinear functions of an environmental gradient. An initial Gradient Forest (GF) analysis was conducted on the ten uncorrelated Bioclimatic (BIO) WorldClim variables from the pre-processing of the MaxENT modeling, the Ariditiy Index variable, and the first six spatial variables to evaluate the relative importance of each predictor variable, utilizing weighted R2 values (split importance; Ellis et al., 2012).

Predictor variables include spatial and climatic variables. The spatial variables are generated by PCNM (Principal coordinates of neighbor matrices); this is an approach to identify spatial structures among the presence coordinates of the A.alpina population samples, and each variable determines the distance between sites with a spatial focus on the neighboring sites. Then, these distances are decomposed into a new set of independent (orthogonal) spatial variables. Among the climatic variables, we retained annual mean temperature, mean diurnal range, isothermality, annual range temperature, mean temperature of the wettest quarter, and mean temperature of the driest quarter; for precipitation, we retained annual precipitation, precipitation seasonality, precipitation of warmest quarter and precipitation of coldest quarter, one variable representing the aridity index of the month as a representative for drought environmental gradient. 

This is performed to analyze spatial biodiversity patterns as a function of environmental gradient. We will be able to identify which environmental variable has a strong driver in the turnover of allelic frequency.


Folders within this analysis are named after their following:

(a) ./climatedata_gradientforest 
	|
	|-> Climate_all/ (All the 19 bioclimatic variables used for the analysis)
	|
	|-> Climate_uncorr/ (Contains the uncorrelated variables out of 19 bioclimatic variable, this is done from maxent)
	|
	|-> presencelocations_AA_933points_latlong.csv (This file contains the presence locations of 933 self compatible plants of arabis alpine) 
	|
	|-> aridity_index_April_933presencelocations_AA_latlong.tsc (this file contains aridiity index value of the month April for the 933 individuals)

(b) ./snpdata_gradientforest
	These commands below will extract the snp data neccessary for gradient forest analysis:
	'''
	   vcftools --gzvcf /netscratch/dep_coupland/grp_fulgione/siva/vcf/mpruned.vcf.gz --012 --out snp
	   cut -f2- snp.012 | sed 's/-1/NA/g' >snp.temp
       	   tr -d '\t' <snp.012.pos | tr '\n' '\t' | sed 's/[[:space:]]*$//' >header
	   paste <(echo "ID" | cat - snp.012.indv) <(echo "" | cat header - snp.temp) > snp.forR
	   rm header snp.temp
	'''
        snp.forR -> file used for the genetic data analysis for the gradient forest

(c) ./scripts_gradientforest
	|
	|-> gradientforest_all.R (this script runs the GF considering the importance of all 19 bioclimatic variables)
	|
	|-> gradientforest_uncorrelated_maxent.R (this script covers only the uncorrelated variables out of 19, and checks out the importance of them, just an extension from maxent uncorrelated vairable detection)

(d) ./results_gradientforest/
	|
	|-> results_plots/ (this folder has all the plots figures of the graident analysis)
	|
	|-> GF_all.RDS (this is the RDS saved from gradientforest_all.R from ./scripts_gradientforest/ folder)
	|
	|-> GF_uncorr.RDS (this is the RDS saved from gradientforest_uncorrelated_maxent.R from ./scripts_gradientforest)


All the gradient forest scripts are taken up and modified from this github folder (https://github.com/pgugger/LandscapeGenomics/blob/master/2018_China/Exercise3.md)
