# This script is for plotting purposes from the mutation area relationship scenario, there are many plot scripts here which will give the mutation area curve and also the extinction plots which gives us the thereotical and as well as observed species genetic diversity loss over the species geographic area loss

#this script uses the database constructed from the mar script which is derived from the 933 self compatible plant genomes and their location coords and their vcf file of the species 'Arabis aplina'

name="arabis_alpina"
nsnps=10000
maxsnps=400000
nsamplesMAR=100
mapresolution=1

#change the mypath for the plotting of the mar results (give the folder name properly)
mypath="/netscratch/dep_coupland/grp_fulgione/siva/mar/mar_chr1_wholegenome_analysis/mar_results_chr1_10k_snps_1degree_mapresolution"


freqfile="/netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/chr1.frq"
famfile="/netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/chr1.fam"
mapfile="/netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/chr1.map"
bedfile="/netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/chr1.bed"
latlonfile="/netscratch/dep_coupland/grp_fulgione/siva/mar/vcf_mar/933latlong.csv"

#load all the libraries for the file contents to be loaded and plotted 

require(mar)
require(dplyr)
  
library(sads)
library(sars)
library(DescTools)

message("run name ", name)

filecoords<-paste0(mypath,"/coords-",name,".rda")
filegenome<-paste0(mypath,"/genome-",name,".rda")
filegenemaps<-paste0(mypath,"/genemaps-",name,".rda")
filemares<-paste0(mypath,"/mares-",name,".rda")
filemar<-paste0(mypath,"/mar-",name,".rda")
fileemar<-paste0(mypath,"/emar-",name,".rda")
filemarz<-paste0(mypath,"/marz-",name,".rda")
fileemarz<-paste0(mypath,"/emarz-",name,".rda")
fileextinctionmar<-paste0(mypath,"/extinctionmar-",name,".rda")
fileextinctionsim<-paste0(mypath,"/extinctionsim-",name,".rda")
fileextinctionsimR2<-paste0(mypath,"/extinctionsimR2-",name,".rda")
  
#load(filetable)
#load(fileliksfs)
load(filecoords)
load(filegenome)
load(filegenemaps)
load(filemares)
load(filemar)
load(fileemar)
load(filemarz)
load(fileemarz)
load(fileextinctionmar)
load(fileextinctionsim)
load(fileextinctionsimR2)
  

library(ggplot2)

head(mares) 
#this mares df has thetaw, pi, M, E, N, a and asub columns where we focux on a and M where a stands for area of the sample random square grid and M gives the  mutation count of segregating sites where we imply a thereotical power law (M=c*A^z), other terms such as thetaw, pi exhibit the genetic diversity calculation (their exact calculation is described in the mar script in detail), N stands for the number of arabis samples falling within the random sampled square grid 

#this plot is an initial plot with no aesthetics along with a power law line which of M=cA^z 

ggplot(mares, aes(x = a, y = M)) +  
      geom_point(color = "purple", size = 2, alpha = 0.5) +  # Add blue points with increased size and transparency
      scale_x_log10() +  
      scale_y_log10() +  
      labs(title = "Log-Log Scatter Plot",  
           x = "Log(a)",  
           y = "Log(M)") +
      theme_minimal() +  # Apply a minimal theme
      theme(plot.title = element_text(size = 16, face = "bold"),  # Customize title font size and style
            axis.text = element_text(size = 12),  # Customize axis text size
            axis.title = element_text(size = 14))  # Customize axis title size

# the above plot with more aesthetics
library(ggplot2)
    
# Filter out data points where M is not equal to 0
filtered_mares <- subset(mares, M != 0)
    
   
# Generate x values for power law
x_values <- seq(min(mares$a), max(mares$a), length.out = 100)
x_values_gt_mar <- x_values

mar$par
# Calculate y values for the curve using the Power model (M=c*A^z with c abd z values when you run the command (mar$par))
y_values_curve <- 591.7892338 * x_values_gt_mar^0.3994184
    
# Create the plot
ggplot(filtered_mares, aes(x = a, y = M)) +  
      geom_point(color = "purple", size = 2, alpha = 0.5) +  # Add purple points with increased size and transparency
      geom_line(data = data.frame(x = x_values_gt_mar, y = y_values_curve), aes(x = x, y = y), color = "gray", linetype = "solid", size = 2) +  # Add a solid gray curve for values greater than mar
      scale_x_log10() +  
      scale_y_log10() +  
      theme_minimal() +  # Apply a minimal theme
      theme(plot.title = element_text(size = 16, face = "bold"),  # Customize title font size and style
            axis.text = element_text(size = 12),  # Customize axis text size
            axis.title = element_text(size = 14),  # Customize axis title size
            panel.grid = element_blank(),  # Remove gridlines inside the plot
            panel.border = element_rect(colour = "black", fill = NA, size = 1),  # Customize panel border
            axis.line = element_line(colour = "black", size = 1)) +
      labs(title = "Mutation Area relationship",
           x = "Species Area",
           y = "Genetic variation (mutation count")# Customize axis lines 

### Extinction scenarioss, we will see how this is calculated in the mar script, this is plotting purposes

res1 <- xsim[xsim$type == "random", ]
res2 <- xsim[xsim$type == "southnorth",]

res <- rbind(res1, res2)  
res$type <- ifelse(res$type == "Southnorth", "South to north",
                   ifelse(res$type == "random", "Random",
                          ifelse(res$type == "southnorth", "South to north",
                                 res$type)))  # Update the values accordingly
res$Extinction <- res$type 
new_row <- data.frame(thetaw = 0,  # Specify the values accordingly
                      pi = 0,
                      M = 0,
                      E = 0,
                      N = 1000,
                      a = 2000,
                      asub = 400000,
                      ax = 1,
                      mx = 1,
                      type = "Random",
                      Extinction = "Random")
res <- rbind(res, new_row)

new_row <- data.frame(thetaw = 0,  # Specify the values accordingly
                      pi = 0,
                      M = 0,
                      E = 0,
                      N = 1000,
                      a = 2000,
                      asub = 400000,
                      ax = 1,
                      mx = 1,
                      type = "South to north",
                      Extinction = "South to north")
res <- rbind(res, new_row)

table(res$type)  
    
ggplot(res, aes(x = ax*100, y = mx*100, shape = type)) +
  geom_point(size = 3) +
  labs(title = "Scatter Plot of ax vs mx",
       x = "ax",
       y = "mx") +
  theme_minimal()

### ecnahnced plot of this::
library(ggplot2)

# Plot the scatter plot with enhanced aesthetics
enhanced_plot <- ggplot(res, aes(x = ax * 100, y = mx * 100, shape = type)) +
  geom_point(size = 3, color = "blue", fill = "lightblue", alpha = 0.7) +  # Custom point appearance
  labs(title = "Scatter Plot of ax vs mx",
       x = "ax",
       y = "mx") +
  theme_minimal() +
  theme(legend.position = "bottom")  # Move legend to the bottom

# Display the enhanced scatter plot
enhanced_plot

### final plot with more aesthethics
library(ggplot2)
    
curve_function_1 <- function(x) x
curve_function_2 <- function(x) {
  y <- 100*(1 - (1 - (x/100))^0.3)
  return(y)
}
curve_function_3 <- function(x) {
  y <- 100*(1 - (1 - (x/100))^0.4)
  return(y)
}
curve_function_4 <- function(x) {
  y <- 100*(1 - (1 - (x/100))^0.5)
  return(y)
}


connected_plot <- ggplot(res, aes(x = ax * 100, y = mx * 100, shape = Extinction, color = Extinction)) +
  geom_point(size = 3) +  # Plot the points
  geom_path() +  # Connect the points
  geom_function(fun = curve_function_1, color = "gray", linetype = "dashed", size = 1) +  # y = x line
  geom_function(fun = curve_function_2, color = "gray", linetype = "dashed", size = 1) +  # y = 1 - (1-x)^0.3 line
  geom_function(fun = curve_function_3, color = "gray", linetype = "dashed", size = 1) +  # y = 1 - (1-x)^0.4 line
  geom_function(fun = curve_function_4, color = "gray", linetype = "dashed", size = 1) +  # y = 1 - (1-x)^0.4 line
  theme_minimal() +
  labs(title = "", x = "Species geographic range area loss %", y = "Genetic diversity loss %") +
  scale_x_continuous(breaks = c(0, 20, 40, 60, 80, 100)) +  # Set x-axis breaks
  scale_y_continuous(breaks = c(0, 20, 40, 60, 80, 100)) +  # Set y-axis breaks
  theme(panel.grid = element_blank(),  # Remove grid lines inside
        panel.border = element_rect(color = "black", fill = NA, size = 1),  # Add border lines
        axis.line = element_line(color = "black", size = 1),
        axis.text = element_text(size = 15),  # Adjust axis label size
        axis.title = element_text(size = 14),
        legend.title = element_text(size = 16, face = "bold"),  # Adjust legend title size and style
        legend.text = element_text(size = 14))  + # Adjust y-axis label size
  coord_fixed(ratio = 1)   # Adjust axis title size

connected_plot

################ this is too draw the geographic map of the europe with samples 

# Load required libraries
library(ggplot2)

# Convert coordinates into a dataframe
coords <- as.data.frame(coords)
colnames(coords) <- c("longitude", "latitude")

# Step 3: Bin coordinates into a 1°-by-1° grid and calculate density
coords$grid_x <- floor(coords$longitude)
coords$grid_y <- floor(coords$latitude)
density_data <- aggregate(rep(1, nrow(coords)), 
                          by = list(coords$grid_x, coords$grid_y), 
                          FUN = sum)

# Step 4: Create a gradient density map
ggplot() +
  geom_tile(data = density_data, aes(x = Group.1, y = Group.2, fill = x), alpha = 0.6) +  # Density grid
  scale_fill_gradient(low = "lightblue", high = "darkblue") +  # Gradient color scale
  labs(title = "Density of Individual Genomes in Eurasia",
       fill = "Density") +
  theme_minimal()

####################
# Load required libraries
library(ggplot2)
library(maps)
library(mapdata)

# Download world map data
world_map <- map_data("worldHires")

# Filter map data within specified latitude and longitude ranges
europe_map <- subset(world_map, lat >= 30 & lat <= 70 & long >= -20 & long <= 25)

# Convert coordinates into a dataframe
coords <- as.data.frame(coords)
colnames(coords) <- c("longitude", "latitude")

# Step 3: Bin coordinates into a 1°-by-1° grid and calculate density
coords$grid_x <- floor(coords$longitude)
coords$grid_y <- floor(coords$latitude)
density_data <- aggregate(rep(1, nrow(coords)), 
                          by = list(coords$grid_x, coords$grid_y), 
                          FUN = sum)

# Step 4: Create a gradient density map overlaying Europe
ggplot() +
  geom_polygon(data = europe_map, aes(x = long, y = lat, group = group), fill = "white", color = "black") +  # Europe map
  geom_tile(data = density_data, aes(x = Group.1, y = Group.2, fill = x), alpha = 1) +  # Density grid
  scale_fill_gradient(low = "lightblue", high = "darkblue") +  # Gradient color scale
  labs(title = "", x="", y="",
       fill = "Indivudal genomes") +
  theme_minimal()+ theme(panel.grid = element_blank(),  # Remove grid lines inside
                         #panel.border = element_rect(color = "black", fill = NA, size = 1),  # Add border lines
                         #axis.line = element_line(color = "black", size = 1),
                         axis.text = element_text(size = 12),  # Adjust axis label size
                         axis.title = element_text(size = 14)) 
ggplot() +
  geom_polygon(data = europe_map, aes(x = long, y = lat, group = group), fill = "white", color = "black") +  # Europe map
  geom_tile(data = density_data, aes(x = Group.1, y = Group.2, fill = x), alpha = 1) +  # Density grid
  scale_fill_gradient(low = "lightblue", high = "darkblue", breaks = c(0, 25, 50, 75, 100, 150)) +  # Gradient color scale with specified breaks
  labs(title = "", x = "", y = "", fill = "Individual genomes") +
  theme_minimal() +
  theme(panel.grid = element_blank(),  # Remove grid lines inside
        axis.text = element_text(size = 12),  # Adjust axis label size
        axis.title = element_text(size = 14))
#legend.position = "top")  # Position legend at the top

