Step1: Genetic data filtration of 933 self compatible plants

Genetic file used: 1000genome GATH4.2 file is present in /biodata/dep_coupland/grp_fulgione/common/1000Genomes/GATK4.2_1000Genomes_chrall.filteredQ30LD5UD100K.final.b.vcf.gz

We are focussing on the count og segregating sites over the area range loss, we can randomly take 10,000 SNPs as follows. Since my project mainly focusses on the self compatible range of plants excluding outcrosses from Italy and Greece, I will be focussing on the genetic data of 933 Self compatible plants which i call them as SC_933.vcf.gz. From this large vcf file, we will focussing on the random SNPs from chromosome1 for our analysis, as we will follow the similar protocol of the above paper


Scripts used to filter out the genetic data for analysis (whole genome analyis)

1. bcftools view -S /netscratch/dep_coupland/grp_fulgione/siva/vcf/sampleid/SC_samplesid_933.txt /biodata/dep_coupland/grp_fulgione/common/1000Genomes/GATK4.2_1000Genomes_chrall.filteredQ30LD5UD100K.final.b.vcf.gz -Oz -o SC_933.vcf.gz

2. bcftools view -r chr1 SC_933.vcf.gz -Oz -o SC_933_chr1_complete.vcf.gz

3. bcftools filter -e 'F_MISSING > 0.1' SC_933_chr1_complete.vcf.gz -Oz -o /netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/chr1.vcf.gz

4. plink --vcf chr1.vcf.gz --make-bed --out chr1

5. plink --file chr1 --recode --out chr1

6. plink --bfile chr1 --freq --out chr1

all the files generated from this such as bed/bim/fam/frq/map files of chr1.vcf.gz are present in (/netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/)

Step 2 - marpipeline scriptsss (an example script)

Step 3 - plotscripts_mar.R
