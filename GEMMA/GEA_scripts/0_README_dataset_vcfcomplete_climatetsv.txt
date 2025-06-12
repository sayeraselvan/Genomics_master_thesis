Genetic dataset construction:
bcftools view -i 'TYPE="snp" && N_ALT=1 && F_missing <= 0.1' -O z -o bm_977.vcf.gz GATK4.2_977Genomes_chrall1.filteredQ30LD5UD100K.final.b.vcf.gz
