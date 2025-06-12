library(raster)

# Paths to ice sheet and ASC file folders
ice_sheet_folder <- "/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/icesheet/"
asc_files_folder <- "/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/E_past/"

# Get the list of ice sheet TIF and ASC files
ice_sheet_files <- list.files(ice_sheet_folder, pattern = "\\.tif$", full.names = TRUE)
asc_files <- list.files(asc_files_folder, pattern = "\\.asc$", full.names = TRUE)

# Loop over each ice sheet file
for (ice_sheet_file in ice_sheet_files) {
  icesheet <- raster(ice_sheet_file)

  # Construct the corresponding ASC file name
  asc_file <- gsub(".tif", ".asc", ice_sheet_file)
  asc_file <- file.path(asc_files_folder, basename(asc_file))

  # Check if the ASC file exists
  if (file.exists(asc_file)) {
    # Read the ASC file
    asc_raster <- raster(asc_file)
    ice_sheet <- projectRaster(icesheet, asc_raster)
    masked_raster <- mask(asc_raster, ice_sheet, inverse=TRUE)
    masked_raster1 <- mask(ice_sheet, asc_raster)
    masked_raster1[!is.na(masked_raster1)] <- 0
    masked_raster1[masked_raster1[] == 1] <- 0
    masked_asc_file <- gsub(".tif", "_masked.asc", basename(ice_sheet_file))
    masked_asc_file <- file.path(asc_files_folder, masked_asc_file)
    final_raster <- merge(masked_raster, masked_raster1)
    writeRaster(final_raster, filename = masked_asc_file, format = "ascii", overwrite = TRUE)
  } else {
    cat("ASC file not found for", ice_sheet_file, "\n")
  }
}

