maxENT final model projection stage:

script used is present in  (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/final_projection.sh)

this creates the output folder within this path (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/)

--> EC_past (extrapolation with clamping scenario)
--> E_past (free extrapolation scenario)
--> NE_past (no extrapolation and no clamping scenario)

each folder has .html file which gives the detailed description of the projection

each projection in a different climate scenario has output projection of  min.asc, avg.asc,  median.asc, stddev.asc, max.asc. This is created by 10 bootstrap replicates thus we use the median.asc of these scenario

all the median.asc for each climate scenario is copied into the folder of (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/) and this is for subsequent analysis to calculate the weighted area for each country and regionwise after masking with the ice sheet  which will be discussed in the next readme file 




