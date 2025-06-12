library(raster)
library(rgdal)
library(data.table)
library(openxlsx)

if (length(commandArgs(trailingOnly = TRUE)) == 0) {
          stop("Please provide the file name as a command-line argument.")}

input <- commandArgs(trailingOnly = TRUE)[1]
output <- commandArgs(trailingOnly = TRUE)[2]
first <- commandArgs(trailingOnly = TRUE)[3]

file <- paste0(first, input)

raster_data <- raster(file)

m <- raster_data

cell_areas <- area(m)
arealayer <- as.data.frame(cell_areas, xy=TRUE)

df1 <- data.frame(
  arealayer,
  cell_values = values(raster_data)
)

df1$product <- df1$cell_values * df1$layer
na.df1 <- na.omit(df1)

library(feather)
write_feather(na.df1, output)

