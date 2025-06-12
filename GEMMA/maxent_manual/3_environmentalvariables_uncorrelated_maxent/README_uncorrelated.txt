MaxENT modelling - Step 3 to find the highly uncorrelated variables and used them for the analysis

Among the 118 different climatic variables, (ranging from 19 bioclimatic variables, 12 monthly minimum temperature, maximum temperature, average temperature, precipitaion, aridity index, wind speed, vapour pressure, solar radiation, elevation.

the files with every coordinates and their climatic data is present in (/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/database_climate_presence_locations/presencepointsofarabisalpina)

Among the 118 climatic variables, we are considering only the 19 bioclimatic variables for maxent modeling, this is because the 19 climatic variables includes

BIO1 = Annual Mean Temperature

BIO2 = Mean Diurnal Range (Mean of monthly (max temp - min temp))

BIO3 = Isothermality (BIO2/BIO7) (×100)

BIO4 = Temperature Seasonality (standard deviation ×100)

BIO5 = Max Temperature of Warmest Month

BIO6 = Min Temperature of Coldest Month

BIO7 = Temperature Annual Range (BIO5-BIO6)

BIO8 = Mean Temperature of Wettest Quarter

BIO9 = Mean Temperature of Driest Quarter

BIO10 = Mean Temperature of Warmest Quarter

BIO11 = Mean Temperature of Coldest Quarter

BIO12 = Annual Precipitation

BIO13 = Precipitation of Wettest Month

BIO14 = Precipitation of Driest Month

BIO15 = Precipitation Seasonality (Coefficient of Variation)

BIO16 = Precipitation of Wettest Quarter

BIO17 = Precipitation of Driest Quarter

BIO18 = Precipitation of Warmest Quarter

BIO19 = Precipitation of Coldest Quarter

Niche modeling has to be performed with the environmental variables that determine the microhabitat niche of the plant thus, to select the variables, we performed a principal component analysis using all the bioclimatic variables to understand how correlated they are and performed a stepwise correlation analysis to detect pairs of variables with coefficients |r| >= 0.85 (using the R package ntbox from Osorio‐Olvera et al., 2020)  and excluded the correlated variable which had a high correlation and thus removed 10 out of 19 variables. After the process of variable selection, for temperature, we retained annual mean temperature, mean diurnal range, isothermality, annual range temperature, mean temperature of the wettest quarter, and mean temperature of the driest quarter; for precipitation, we retained annual precipitation, precipitation seasonality, precipitation of warmest quarter and precipitation of coldest quarter.

Also the correlation values of the 19 bioclimatic variables for the 141 coordinates is depicted in the form of csv file named (./correlation_between_bio1_to_bio19.csv)
