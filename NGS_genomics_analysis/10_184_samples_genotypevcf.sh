# For chromosome X
gatk --java-options "-Xmx32g -Xms32g" \
    GenotypeGVCFs \
    -R /home//Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz \
    --variant "gendb://my_database_chrX" \
    -O X_genotyped.vcf.gz \
    --tmp-dir /home//Siva/raw_data/test/signor/cut/all_gvcfs/tmp_vcf \
    >> X_genotype.log 2>&1

# For chromosome 2L
gatk --java-options "-Xmx32g -Xms32g" \
    GenotypeGVCFs \
    -R /home//Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz \
    --variant "gendb://my_database_chr2L" \
    -O 2L_genotyped.vcf.gz \
    --tmp-dir /home//Siva/raw_data/test/signor/cut/all_gvcfs/tmp_vcf \
    >> 2L_genotype.log 2>&1

# For chromosome 2R
gatk --java-options "-Xmx32g -Xms32g" \
    GenotypeGVCFs \
    -R /home//Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz \
    --variant "gendb://my_database_chr2R" \
    -O 2R_genotyped.vcf.gz \
    --tmp-dir /home//Siva/raw_data/test/signor/cut/all_gvcfs/tmp_vcf \
    >> 2R_genotype.log 2>&1

# For chromosome 3L
gatk --java-options "-Xmx32g -Xms32g" \
    GenotypeGVCFs \
    -R /home//Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz \
    --variant "gendb://my_database_chr3L" \
    -O 3L_genotyped.vcf.gz \
    --tmp-dir /home//Siva/raw_data/test/signor/cut/all_gvcfs/tmp_vcf \
    >> 3L_genotype.log 2>&1

# For chromosome 3R
gatk --java-options "-Xmx32g -Xms32g" \
    GenotypeGVCFs \
    -R /home//Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz \
    --variant "gendb://my_database_chr3R" \
    -O 3R_genotyped.vcf.gz \
    --tmp-dir /home//Siva/raw_data/test/signor/cut/all_gvcfs/tmp_vcf \
    >> 3R_genotype.log 2>&1

# For chromosome 4
gatk --java-options "-Xmx32g -Xms32g" \
    GenotypeGVCFs \
    -R /home//Siva/raw_data/simulans/dsimM252v1.2+microbiome.fa.gz \
    --variant "gendb://my_database_chr4" \
    -O 4_genotyped.vcf.gz \
    --tmp-dir /home//Siva/raw_data/test/signor/cut/all_gvcfs/tmp_vcf \
    >> 4_genotype.log 2>&1

