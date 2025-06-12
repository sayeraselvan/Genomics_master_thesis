library("raster")

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
  stop("Usage: Rscript buffer.R <distance_buffer> <input_tif> <output_ascii_name>")
}

input_tif <- args[1]
output_tif <- args[2]

# Read occurrence data from a CSV file
occ_raw <- read.csv("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/database_climate_presence_locations/presencepointsofarabisalpina/processed_141_presence_locations.csv")
occ_clean <- subset(occ_raw, (!is.na(latitude)) & (!is.na(longitude)))
cat(nrow(occ_raw) - nrow(occ_clean), "records are removed")
dups <- duplicated(occ_clean[c("latitude", "longitude")])
occ_unique <- occ_clean[!dups,]
cat(nrow(occ_clean) - nrow(occ_unique), "records are removed")

coordinates(occ_unique) <- ~longitude + latitude
myCRS1 <- CRS("+init=epsg:4326")
crs(occ_unique) <- myCRS1

#input_directory <- "/netscratch/dep_coupland/grp_fulgione/siva/worldclim/new_1981_2010/crop"

# Read the specified GeoTIFF file
clim <- raster(file.path(input_tif))

# Extract conditions from the GeoTIFF for occurrence points
#conditions_occ <- extract(clim, occ_unique)

# Identify and remove bad records
#bad_records <- is.na(conditions_occ[, 1])
#table(bad_records)
#conditions_occ[bad_records,]

# Extract cells and remove duplicates
cells <- cellFromXY(clim, occ_unique)
#dups <- duplicated(cells)
#occ_final <- occ_unique[!dups,]
#cat(nrow(occ_unique) - nrow(occ_final), "records removed")
#length(occ_final)

# Buffer occurrence points
occ_buff <- buffer(occ_unique, width=400000)

studyArea <- crop(clim, extent(occ_buff))
studyArea <- mask(studyArea, occ_buff)

writeRaster(
  studyArea,
  filename = paste0("", output_tif, ""),
  format = "ascii",
  bylayer = TRUE,
  overwrite = TRUE
)

