snp <- read.table("snp.forR", header = T, row.names = 1)


library(raster)
library(rgdal)
clim.list <- dir("/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/climatedata_gradientforest/Climate_all", full.names=T, pattern='.tif')
clim.layer <-  stack(clim.list)  #stacks the layers into a single object


extent <- c(-27, 55, 25, 80) 
clim.layer.crop <- crop(clim.layer, extent)


sample.coord <-read.csv("/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/climatedata_gradientforest/presencelocations_AA_933points_latlong.csv", header=T, stringsAsFactors=F)
sample.coord

crs.wgs <- "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0"  #defines the spatial projection system that the points are in (usually WGS84)
sample.coord.sp <- SpatialPointsDataFrame(sample.coord[,c('longitude','latitude')], proj4string=CRS(crs.wgs), data=sample.coord)

clim.points1 <- extract(clim.layer.crop, sample.coord.sp) #extracts the data for each point (projection of climate layer and coordinates must match)
df <- read.table("/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/climatedata_gradientforest/aridity_index_April_933presencelocations_AA_latlong.tsv", header=FALSE)
df <- df[,2]
head(df)
clim.points <- cbind(clim.points1, df)
colnames(clim.points)[ncol(clim.points)] <- "ai_Apr"
head(clim.points)


clim.points <- cbind(sample.coord, clim.points)  #combines the sample coordinates with the climate data points
write.table(clim.points, "/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/climatedata_gradientforest/clim.points_all", sep="\t", quote=F, row.names=F)  #save the table for later use
clim.points

library(vegan)
coord <- clim.points[,c("longitude","latitude")]
pcnm <- pcnm(dist(coord))  #this generates the PCNMs, you could stop here if you want all of them
keep <- round(length(which(pcnm$value > 0))/2)
pcnm.keep <- scores(pcnm)[,1:keep]  #keep half of positive ones as suggested by some authors
pcnm.keep

library(gradientForest)
env.gf <- cbind(clim.points[,c("bio_1", "bio_2", "bio_3", "bio_4", "bio_5", "bio_6", "bio_7", "bio_8", "bio_9", "bio_10", "bio_11", "bio_12", "bio_13", "bio_14", "bio_15","bio_16", "bio_17", "bio_18", "bio_19", "ai_Apr")], pcnm.keep)

maxLevel <- log2(0.368*nrow(env.gf)/2)

gf <- gradientForest(cbind(env.gf, snp), predictor.vars=colnames(env.gf), response.vars=colnames(snp), ntree=500, maxLevel=maxLevel, trace=T, corr.threshold=0.50)
saveRDS(gf, file="/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/results_gradientforest/GF_all.RDS")


pdf("/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/results_gradientforest/results_plots/GF_VariableImportance_all.pdf")
plot(gf, plot.type = "O")
dev.off()

by.importance <- names(importance(gf))

pdf("/netscratch/dep_coupland/grp_fulgione/siva/gradientforest_analyses/results_gradientforest/results_plots/GF_TurnoverFunctions_all.pdf")
plot(gf, plot.type = "C", imp.vars = by.importance, show.species = F, common.scale = T, cex.axis = 1, cex.lab = 1.2, line.ylab = 1, par.args = list(mgp = c(1.5, 0.5, 0), mar = c(2.5, 2, 2, 2), omi = c(0.2, 0.3, 0.2, 0.4)))
dev.off()
