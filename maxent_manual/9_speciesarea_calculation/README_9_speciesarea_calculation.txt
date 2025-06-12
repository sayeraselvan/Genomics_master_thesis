maxENT modelling: 

Step9: species area calculation

The scripts are present in the scripts folder within this manual:
(a) species_area_future_regions.sh 

(b) species_area_past_regions.sh 

these are the scripts which are used to calculate the total weighted area (files are named as median_t_{EC/E/NE}_{time}.xlsx) and the suitable weighted area output files (files are named as median_suitable_{EC/NE/E}_{time}.xlsx) in the respective folder:

(a) EC_past --> /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/EC_past/regionarear
(b) E_past --> /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/E_past/regionarear
(c) NE_past --> /netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/NE_past/regionarear

Now the outputs .xlsx files from this, all the weighted area is complied together to get the complete area picture and are present in the folder (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_are/all/)

this folder has two folders within, they are past and future: there are complied area csf files and their columns and the file description will be discussed in detail as follows

There are two types of area calculation:
(a) weighted area -> summation of {raster cell area * probabilty of the species presence in the particular raster cell}
(b) layer area -> summation of the raster cell area 

Columns in the complied area csv files are disclosed as follows and here we consider only the cells whose posterior probabiliy of species presence is greater than the index/threshold:

"index" -> consider the raster map cells which has probability above this value
"Threshold" -> same as index column
"Africa_product" -> weighted area in africa continent 
"Centraleuropean_product" ->  weighted area in central european countires
"Scandinavians_product" ->  weighted area in scandinavian countties
"Unknown_product" -> these coordinates are not considered, listed as unknown coordinates not falling in any countries
"West_product" -> weighted area in spain and portugal
"Africa_layer" -> layer area in africa
"Centraleuropean_layer" -> layer area in central european countires
"Scandinavians_layer" -> layer area in scandinavians countires
"Asiancountries_product" -> weighted area in asian countries in the asc file
"Asiancountries_layer" -> layer area in the asian countires in the asc file 
"Unknown_layer" -> layer area in the cordinaties whose coords fall in no countries
"West_layer" -> layer area in spaina nd portugal 
"Total_product" -> rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product")]
"Total_product_unknown" -> rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")]
"Total_cell_area" -> rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer")]
"Total_cell_area_unknown" -> rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")]
"No_Scad_product" -> rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product")]
"No_Scad_product_unknown" ->  rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product", "Unknown_product")]
"No_Scad_layer" -> rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer")]
"No_Scad_layer_unknown" -> rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer", "Unknown_layer")]
"No_Africa_product" -> rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product")]
"No_Africa_product_unknown" -> rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")]
"No_Africa_layer" -> rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer")]
"No_Africa_layer_unknown" ->  rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")]
"Total_product_normalised" -> (df$Total_product / df$Total_cell_area[1]) * 100
"FileName" -> filename basically in the format median_{t/suitable}_{EC/NE/E}_{projection_scenario}
"Set" -> NE/EC/E

present conditons: projection scenario is Set_20 
LGM scenario: projection scenario is Set_-200

the files in the below folder are grouped together and plotted to make the respective plots with the help of the script called suitability_R.R in the scripts folder of this file path

(a) past folder:
	|
	|--> complied_pastsuitabilityarea.csv (all suitaibilty index range csv files of the past are grouped together)
	|
	|--> complied_pasttotalweightedarea.csv (all total weighted area from the threshold of the past csv files are grouped together)
	|
	|--> complied_pasttotalweightedarea_subset_threshold0.csv (only the subset of the above file complied_pasttotalweightedarea.csv where the threshold is 0 is taken to plot the total weighted area above probabiloty index 0)

(b) future folder: 
	|
	|--> complied_suitablearea_future.csv (all suitabilty index range csv files of the future are grouped together)
	|
	|--> complied_totalweightedarea_future.csv (all total weighted area from the threshold of the future csv files are grouped together)
	|
	|--> future.xlsx (total weighted area for the subset from threshold 0 and it is manually edited to make this file from the complied_totalweightedarea_future.csv)
	|
	|--> other files such as RCP26, RCP45, RCP60, RCP85.xlsx files are the total wegihted area for the threshold above 0 and it is for different climate scenario stated as SSP2.6, SSP4.5, SSP6.0, SSP8.5

The plot script is all described in plot_speciesarea.R script in the scripts foler of this files path to make any plots 

