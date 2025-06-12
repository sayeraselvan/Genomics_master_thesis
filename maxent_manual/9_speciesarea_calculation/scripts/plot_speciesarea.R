library(openxlsx)
library(dplyr)

complied_data <- read.csv("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/past/complied_pastsuitabilityarea.csv")

df_subset <- complied_data

complied_data$Threshold <- as.numeric(complied_data$Threshold)
df_subset1 <- df_subset[df_subset$index == "0.7675-1.0", ]
df_subset2 <- df_subset[df_subset$index == "0.535-0.7675", ]
df_subset3 <- df_subset[df_subset$index == "0.3025-0.535", ]
df_subset4 <- df_subset[df_subset$index == "0.0-0.3025", ]

df_subset$Threshold <- as.numeric(df_subset$Threshold)

df_subset <- df_subset %>%
  mutate(FileName = gsub("median_suitable_EC_Set_", "", FileName))
df_subset <- df_subset %>%
  mutate(FileName = gsub("median_suitable_NE_Set_", "", FileName))
# df_subset <- df_subset %>%
#   mutate(FileName = gsub("tC_Set_", "", FileName))
df_subset <- df_subset %>%
  mutate(FileName = gsub("median_suitable_E_Set_", "", FileName))

df_subset <- df_subset %>%
  mutate(FileName = as.numeric(FileName))

# Arrange
df_subset <- df_subset %>%
  arrange(FileName)

df_subset$FileName <- df_subset$FileName * 100
df_subset$FileName <- df_subset$FileName - 2000
df_subset <- df_subset %>%
  arrange(FileName)
df_subset_1 <- df_subset[df_subset$index == "0.7675-1.0", ]

#here change the y accordingly to get the suitable area plot for each column (i used No_africa product for total consideratin suitable weighted area, refer to the README_9_speciesareacalculation.txt) for more details

p_subset <- ggplot(df_subset_1, aes(x = FileName, y = No_Africa_product, color = Set, shape = Set)) +
  geom_point(size = 3) +
  #geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") +  # Add a linear regression line without confidence interval
  scale_color_brewer(palette = "Set2") +  # Set color palette
  scale_shape_manual(values = c(16, 17, 18, 19)) +  # Set point shapes
  theme_minimal() +  # Use a minimal theme
  labs(title = "Weighted Area in percent wrt to total land area vs. Years 20000BC to 2000AD",
       x = "Years", y = "Weighted Area % wrt to total land area") +  # Add titles and labels
  theme(legend.position = "top",  # Adjust legend position
        legend.title = element_blank(),  # Remove legend title
        plot.title = element_text(size = 16, hjust = 0.5, face = "bold"),  # Adjust title appearance
        axis.title.x = element_text(size = 14),  # Adjust x-axis label appearance
        axis.title.y = element_text(size = 14),  # Adjust y-axis label appearance
        axis.text = element_text(size = 12),  # Adjust axis text appearance
        legend.text = element_text(size = 12))  # Adjust legend text appearance

print(p_subset)
colnames(df_subset)


p_subset <- ggplot(df_subset_1, aes(x = FileName, y = No_Africa_layer, color = Set, shape = Set)) +
  geom_point(size = 3) +
  geom_line(aes(group = Set), linewidth = 1) +  # Add lines connecting points within each set
  scale_color_brewer(palette = "Set2") +
  scale_shape_manual(values = c(16, 17, 18, 19)) +
  theme_minimal() +
  labs(title = "Weighted Area from the Years 20000BC to 2000AD",
       x = "Years", y = "Europe weighted area (km2)") +
  theme(legend.position = "top",
        legend.title = element_blank(),
        plot.title = element_text(size = 16, hjust = 0.5, face = "bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        axis.text = element_text(size = 12),
        legend.text = element_text(size = 12))

# Display or save the plot
print(p_subset)


library(ggplot2)

# Assuming df_subset_1 is your dataframe
# Assuming you want to adjust x-axis to range from -22000 to 0, with breaks every 2000

p_subset <- ggplot(df_subset4, aes(x = FileName, y = No_Africa_product, color = Set, shape = Set)) +
  geom_point(size = 3) +
  geom_line(aes(group = Set), linewidth = 1) +  # Add lines connecting points within each set
  scale_color_brewer(palette = "Set2") +
  scale_shape_manual(values = c(16, 17, 18, 19)) +
  theme_minimal() +
  labs(title = "Unsuitable Weighted Area (0.0-0.3025) from 22000 years back to present ",
       x = "Years ago", y = "Total Europe weighted area (km2)") +
  theme(legend.position = "top",
        legend.title = element_blank(),
        plot.title = element_text(size = 16, hjust = 0.5, face = "bold"),
        axis.title.x = element_text(size = 14),
        axis.title.y = element_text(size = 14),
        axis.text = element_text(size = 12),
        legend.text = element_text(size = 12),
        panel.grid.major = element_blank(),  # Remove major gridlines
        panel.grid.minor = element_blank(),  # Remove minor gridlines
        axis.ticks = element_line(color = "black"),  # Show axis ticks
        axis.line = element_line(color = "black"))  # Show axis lines

# Adjust x-axis range and breaks
p_subset <- p_subset + 
  scale_x_continuous(breaks = seq(-22000, 0, by = 2000),
                     labels = abs(seq(-22000, 0, by = 2000))) +  # Set absolute values for labels
  scale_y_continuous(labels = scales::comma)  # Format y-axis labels with commas

# Display or save the plot
print(p_subset)


 
################ future plots::
library(ggplot2)
library(readxl)
 
rcp26 <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/RCP26.xlsx")
rcp45 <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/RCP45.xlsx")
rcp60 <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/RCP60.xlsx")
rcp85 <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/RCP85.xlsx")

all_future <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/future.xlsx")

hs <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/future.xlsx", sheet="hs")
us <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/future.xlsx", sheet="us")
ls <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/future.xlsx", sheet="ls")
ms <- read_excel("/netscratch/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/species_area/all/future/future.xlsx", sheet="ms")

rcp26 <- rcp26[, !names(rcp26) %in% c("Africa_product", "Unknown_product")]
rcp45 <- rcp45[, !names(rcp45) %in% c("Africa_product", "Unknown_product")]
rcp60 <- rcp60[, !names(rcp60) %in% c("Africa_product", "Unknown_product")]
rcp85 <- rcp85[, !names(rcp85) %in% c("Africa_product", "Unknown_product")]

library(tidyr)
library(ggplot2)

rcp26_long <- pivot_longer(rcp26, 
                           cols = -name, 
                           names_to = "Region", 
                           values_to = "Product_Value")
rcp45_long <- pivot_longer(rcp45, 
                           cols = -name, 
                           names_to = "Region", 
                           values_to = "Product_Value")
rcp60_long <- pivot_longer(rcp60, 
                           cols = -name, 
                           names_to = "Region", 
                           values_to = "Product_Value")
rcp85_long <- pivot_longer(rcp85, 
                           cols = -name, 
                           names_to = "Region", 
                           values_to = "Product_Value")
library(ggplot2)

p <- ggplot(rcp26_long, aes(x = factor(name, levels = c("present", "2050", "2070")), 
                            y = Product_Value, 
                            color = Region, 
                            group = Region)) +
  geom_line(size = 1) +  # Increase line thickness
  labs(title = "",
       x = "",
       y = "Area (sq. km)",
       color = "Region") +
  theme_minimal() +
  theme(axis.line = element_line(size = 1, color = "grey"),  # Add bold axis lines
        axis.text = element_text(size = 12),  # Adjust axis text size
        axis.title = element_text(size = 14),  # Adjust axis title size and style
        legend.title = element_text(size = 14),  # Adjust legend title size and style
        legend.text = element_text(size = 12),  # Adjust legend text size
        plot.title = element_text(size = 16, hjust = 0.5, face = "bold")) +  # Adjust plot title size and style
  scale_y_continuous(labels = scales::comma)  # Format y-axis labels as numbers with commas

print(p)

library(dplyr)
library(tidyr)
library(ggplot2)

# Adding scenario column to each dataframe
rcp26 <- mutate(rcp26, scenario = "RCP26")
rcp45 <- mutate(rcp45, scenario = "RCP45")
rcp60 <- mutate(rcp60, scenario = "RCP60")
rcp85 <- mutate(rcp85, scenario = "RCP85")

# Combining dataframes
combined_data <- bind_rows(rcp26, rcp45, rcp60, rcp85)

# Reshaping data into long format
combined_data_long <- pivot_longer(combined_data, 
                                   cols = -c(name, scenario), 
                                   names_to = "Region", 
                                   values_to = "Product_Value")
combined_data_long <- combined_data_long %>%
  mutate(scenario = case_when(
    scenario == "RCP26" ~ "RCP 2.6",
    scenario == "RCP45" ~ "RCP 4.5",
    scenario == "RCP60" ~ "RCP 6.0",
    scenario == "RCP85" ~ "RCP 8.5",
    TRUE ~ scenario
  ))


# Plotting
p <- ggplot(combined_data_long, aes(x = factor(name, levels = c("present", "2050", "2070")), 
                                    y = Product_Value, 
                                    linetype = scenario,
                                    color = Region,
                                    group = paste(scenario, Region))) +
  geom_line(size = 1) +
  labs(title = "Weighted area across present and future",
       x = "",
       y = "Area (sq. km)",
       color = "Region",
       linetype = "Scenario",
       subtitle = "All RCP Scenarios and Regions") +
  theme_minimal() +
  scale_linetype_manual(values = c("RCP 2.6" = "solid", "RCP 4.5" = "dashed", "RCP 6.0" = "dotted", "RCP 8.5" = "dotdash")) +
  theme(axis.line = element_line(size = 1, color = "grey"),
        axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        legend.title = element_text(size = 14),
        legend.text = element_text(size = 12),
        plot.title = element_text(size = 16, hjust = 0.5, face = "bold"),
        plot.subtitle = element_text(size = 14, hjust = 0.5)) + scale_y_continuous(labels = scales::comma)

print(p)








