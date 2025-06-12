maxENT modelling: Step 4

Model calibration area Selecting the appropriate background area, also known as the "calibration area" or "study area," is an important decision in species distribution modeling (Elith et al., 2011; Raes, 2012). Extending the boundaries of this area beyond its actual presence risks inflating model accuracy, often constraining it within geographic limits, species dispersal abilities, and accounting for interactions with other species and sampling biases (Jarnevich et al., 2017). Despite the species's broader distribution, local or regional studies may constrain the background area. Large geographical ranges of species pose computational challenges, leading to resource-intensive and time-consuming computations (Rotllan-Puig & Traveset, 2021). We established buffer distances of 10, 25, 50, 100, 200, and 400 km around the known presence locations to delineate the species study area. This approach aimed to comprehensively capture the species' environmental domain and assess its historical migration patterns, considering its current presence in specific locations. Evaluating the model accuracy revealed that the 400 km buffer distance yielded a more representative set of background points, significantly enhancing the precision and extending the range of accurate predictions for the species


we chose a 400km buffer distance to get model calibration area aka training area to train the model for the climatic data files:

the files are present in this folder (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/database_climate_presence_locations/current_trainingarea_climatedata/bufferdistance400kmtrainingarea)

the script (bufferdistace400km.R) is present in this folder. we have found the uncorrelated environemental variables from the Step 3. 
