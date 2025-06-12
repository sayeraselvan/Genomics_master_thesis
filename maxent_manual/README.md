# maxENT Analysis Directory
This directory contains all scripts and resources used for ecological niche modeling with maxENT as part of my Master’s thesis in Genomics. The workflow is organized into sequential steps, from data preparation to final analysis and visualization.

#📚 Directory Structure & Script Descriptions
Each numbered folder/script corresponds to a step in the MaxEnt modeling pipeline:

#Folder/Scripts structure
```
1_downloadclimate	Scripts to download and prepare climate/environmental data for modeling
2_presencelocations	Processes species presence location data for input to MaxEnt.
3_environmentalvariables_uncorrelated_maxent	Selects uncorrelated environmental variables for robust modeling.
4_modelcalibrationarea_trainingarea	Defines calibration and training areas for model building and evaluation.
5_replicates	Runs maxENT models with multiple replicates for robustness and uncertainty estimation.
6_bestmodelselection	Identifies the best model(s) based on performance metrics and selection criteria.
7_finalmodelprojection	Projects the final selected model onto current or future environmental scenarios.
8_maskingwithicesheet	Applies post-processing masks (glacial ice sheets for the LGM) to refine model projections.
9_speciesarea_calculation	Calculates species area metrics from the projection outputs of the best model.
10_additionalanalysis_mess	Additional exploratory scripts
11_plots_maxent	visualizations of MaxEnt results.
```
