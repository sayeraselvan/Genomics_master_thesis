library(raster)

args <- commandArgs(trailingOnly = TRUE)

if (length(args) != 2) {
	stop("Usage: Rscript crop.R <x> <y>")
}

x <- args[1]
y <- as.numeric(args[2])

ext <- extent(-27, 55, 50, 80)

clim_layer <- raster(x)
cropped_layer <- crop(clim_layer, ext)
output_file <- paste0("bio_", y, ".asc")
writeRaster(cropped_layer, filename = output_file, format = "ascii")

print("Job is done")
