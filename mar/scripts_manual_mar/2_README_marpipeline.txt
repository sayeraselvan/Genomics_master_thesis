2.9 Mutations Area relationship (MAR)
To quantify how genetic diversity within a species increases with geographic area, we constructed the MAR by subsampling regions of different size grids of the A. alpina range using 933 georeference genomes. We modeled the number of mutations/segregating sites (M) as a measure of genetic diversity, aligning with the species-centric version of SAR that utilizes species richness as the biodiversity measure. We sampled 10,000 SNPS randomly over the 933 individual plant samples. We formed a grid size of 1° to 1° latitude over longitude to understand the count of segregating sites/mutations over the potential species area. We sampled 3600 random square grids across the map to understand to fit the M (count of segregating sites) over the area of the square grid (A) over the MAR (Mutation Area Relationship), a power law relationship of equation M = c*𝐴^𝑧 where c is constant and the scaling value of z. The z value in A.alpina is scaled and compared with A.thaliana, where the z is 0.324 


The scripts used for this analysis are described as follows based on the genetic dataset used 
(a) ./Marpipeline_script_chr1_wholegenome.R  

We prefer ./Marpipeline_script_chr1_wholegenome.R because this constructs a z of 0.399 

The Mutation Area Relationship (MAR) is inferred from genomic data, demonstrating a power law relationship M = cAz, where M represents the count of segregation sites and A signifies the area. The scaling exponent, zMAR, is estimated at 0.399 (95% confidence interval = 0.387 to 0.412) for A.alpina.

Simulations on the extinction have been performed for two scenarios. In the first scenario, extinction is random, where the sample genome within the random grid selected out of all the grids of size 1° by 1° is removed from the face of the earth, and here, the genetic diversity loss concerning the area loss of the grid is studied. In the second scenario, the extinction is from south to north (warm edge) to understand how the genetic diversity is affected when the plant samples across the warm edge are removed along the south-to-north gradient as the temperature decreases from the equator to the poles. Their genetic diversity loss over the species-area loss is studied and fitted against the theoretical prediction of genetic diversity vs. geographical area loss to understand how well the MAR curve estimates the observed genetic diversity loss over area loss.

thsi pipeline calculates the count of segregating sites, area for every random sampled grid over the random sampled SNPs. Over th extinction scenario, we calculate the rate of genetic diversity losss (by comparing the loss of segregaaitng sites) over the species geographic area loss 

(To get a detailed descrition of the functions used, refer https://github.com/MoisesExpositoAlonso/mar/tree/master/R) 
