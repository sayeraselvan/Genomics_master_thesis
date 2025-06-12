MaxENT modelling (Step 1 - Download climatic database)

This file has the complete tutorial on how to download the files for the climatic database 

1. Code to download the climate data for the current present environmental date: Below you can download the standard (19) WorldClim Bioclimatic variables for WorldClim version 2. They are the average for the years 1970-2000. Each download is a "zip" file containing 19 GeoTiff (.tif) files.

'wget https://geodata.ucdavis.edu/climate/worldclim/2_1/base/wc2.1_30s_bio.zip'

(files location path: /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/climatedatabase/current_trainingarea_presencelocations_climatedata/worldclimtiffilesof1970to2000)


2. Code to Download all the tif files from the worldclim climate data for future projection ranging for 2050 and 2070

'wget https://geodata.ucdavis.edu/cmip6/30s/CMCC-ESM2/ssp126/wc2.1_30s_bioc_CMCC-ESM2_ssp126_2021-2040.tif'
'wget https://geodata.ucdavis.edu/cmip6/30s/CMCC-ESM2/ssp245/wc2.1_30s_bioc_CMCC-ESM2_ssp245_2021-2040.tif'
'wget https://geodata.ucdavis.edu/cmip6/30s/CMCC-ESM2/ssp370/wc2.1_30s_bioc_CMCC-ESM2_ssp370_2021-2040.tif'
'wget https://geodata.ucdavis.edu/cmip6/30s/CMCC-ESM2/ssp585/wc2.1_30s_bioc_CMCC-ESM2_ssp585_2021-2040.tif'

#then we can crop this tif file using crop.R and bashcrop.sh in the scripts folder 

3. Use the scripts in this same folder (bufferdistance.R, bashbuffer.sh) to get the bufferered distance of 400km around each location point which is used as the training area for the maxent environmental model as this provides as the model calibration area, an idea of species domain's env conditions 

(/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/database_climate_presence_locations/current_trainingarea_climatedata/bufferdistance400kmtrainingarea) 

4. Use crop.R for the downloaded individual environmental tif files, and the climate files are stored in, they are used for projection - these folders include all the 19 bioclimatic variables 

Future asc projection files: (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/proj/
Past asc projection files: (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/proj_past) 
Present asc projection files: (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/proj_past/current/)

(a) Future asc files: /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/proj/
 	cc26bi50 - SSP 2.6 2050 scenario
	cc26bi70 - SSP 2.6 2070 scenario 
	cc45bi50 - SSP 4.5 2050 scenario
	cc45bi70 - SSP 4.5 2070 scenario
	cc60bi50 - SSP 6.0 2050 scenario
	cc60bi70 - SSP 6.0 2070 scenario
	cc85bi50 - SSP 8.5 2050 scenario
	cc85bi70 - SSP 8.5 2070 scenario
(b) Past asc files: /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/proj_past
	Set_[i] if
		 i > 0, it represent the year date of [i] x 100 years AD
		 i < 0, it represent the year date of [i] x 100 years BC
	for e.g. 
		Set_1 is 100 AD, Set_-100 is 10000 BC
		Set_-200 is 20000 BC which is 22000 years back from present
(c) Present asc files: /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/proj_past/current 
	This includes the current present environmental asc file derived from 1970-2000 worldclim climatic data



