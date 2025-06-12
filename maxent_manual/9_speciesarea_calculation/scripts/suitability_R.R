
library(openxlsx)
library(dplyr)


xlsx_folder_EC <- "D:\\Siva\\master thesis\\all\\suitable\\EC"
xlsx_files_EC <- list.files(xlsx_folder_EC, pattern = "\\.xlsx$", full.names = TRUE)

xlsx_folder_E <- "D:\\Siva\\master thesis\\all\\suitable\\E"
xlsx_files_E <- list.files(xlsx_folder_E, pattern = "\\.xlsx$", full.names = TRUE)

xlsx_folder_NE <- "D:\\Siva\\master thesis\\all\\suitable\\NE"
xlsx_files_NE <- list.files(xlsx_folder_NE, pattern = "\\.xlsx$", full.names = TRUE)

# xlsx_folder_C <- "/netscratch/dep_coupland/grp_fulgione/siva/maxent/variables_20_100km/Final_Modelsa/M_3_F_lh_Set1_20_C/regionarea/"
# xlsx_files_C <- list.files(xlsx_folder_C, pattern = "\\.xlsx$", full.names = TRUE)

compiled_df_EC <- data.frame()

for (xlsx_file in xlsx_files_EC) {
  df <- read.xlsx(xlsx_file, sheet = 1, colNames = TRUE)
  
  df$Total_product <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product")], na.rm = TRUE)
  df$Total_product_unknown <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$Total_cell_area <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer")], na.rm = TRUE)
  df$Total_cell_area_unknown <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  df$No_Scad_product <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product")], na.rm = TRUE)
  df$No_Scad_product_unknown <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$No_Scad_layer <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer")], na.rm = TRUE)
  df$No_Scad_layer_unknown <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  df$No_Africa_product <- rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product")], na.rm = TRUE)
  df$No_Africa_product_unknown <- rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$No_Africa_layer <- rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer")], na.rm = TRUE)
  df$No_Africa_layer_unknown <- rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  total_area_0 <- df$Total_cell_area[1]
  df$Total_product_normalised <- (df$Total_product / total_area_0) * 100
  df <- cbind(df, FileName = tools::file_path_sans_ext(basename(xlsx_file)))
  df <- cbind(df, Set = "EC")
  
  compiled_df_EC <- rbind(compiled_df_EC, df)
}


compiled_df_E <- data.frame()

for (xlsx_file in xlsx_files_E) {
  df <- read.xlsx(xlsx_file, sheet = 1, colNames = TRUE)
  
  df$Total_product <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product")], na.rm = TRUE)
  df$Total_product_unknown <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$Total_cell_area <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer")], na.rm = TRUE)
  df$Total_cell_area_unknown <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  df$No_Scad_product <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product")], na.rm = TRUE)
  df$No_Scad_product_unknown <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$No_Scad_layer <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer")], na.rm = TRUE)
  df$No_Scad_layer_unknown <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  df$No_Africa_product <- rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product")], na.rm = TRUE)
  df$No_Africa_product_unknown <- rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$No_Africa_layer <- rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer")], na.rm = TRUE)
  df$No_Africa_layer_unknown <- rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  total_area_0 <- df$Total_cell_area[1]
  df$Total_product_normalised <- (df$Total_product / total_area_0) * 100
  df <- cbind(df, FileName = tools::file_path_sans_ext(basename(xlsx_file)))
  df <- cbind(df, Set = "E")
  
  compiled_df_E <- rbind(compiled_df_E, df)
}

compiled_df_NE <- data.frame()

for (xlsx_file in xlsx_files_NE) {
  df <- read.xlsx(xlsx_file, sheet = 1, colNames = TRUE)
  
  df$Total_product <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product")], na.rm = TRUE)
  df$Total_product_unknown <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$Total_cell_area <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer")], na.rm = TRUE)
  df$Total_cell_area_unknown <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  df$No_Scad_product <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product")], na.rm = TRUE)
  df$No_Scad_product_unknown <- rowSums(df[, c("Africa_product", "Centraleuropean_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$No_Scad_layer <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer")], na.rm = TRUE)
  df$No_Scad_layer_unknown <- rowSums(df[, c("Africa_layer", "Centraleuropean_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  df$No_Africa_product <- rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product")], na.rm = TRUE)
  df$No_Africa_product_unknown <- rowSums(df[, c("Centraleuropean_product", "Scandinavians_product", "West_product", "Unknown_product")], na.rm = TRUE)
  
  df$No_Africa_layer <- rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer")], na.rm = TRUE)
  df$No_Africa_layer_unknown <- rowSums(df[, c("Centraleuropean_layer", "Scandinavians_layer", "West_layer", "Unknown_layer")], na.rm = TRUE)
  
  total_area_0 <- df$Total_cell_area[1]
  df$Total_product_normalised <- (df$Total_product / total_area_0) * 100
  df <- cbind(df, FileName = tools::file_path_sans_ext(basename(xlsx_file)))
  df <- cbind(df, Set = "NE")
  
  compiled_df_NE <- rbind(compiled_df_NE, df)
}

complied_data <- rbind(compiled_df_NE, compiled_df_EC, compiled_df_E)
complied_data$Threshold <- as.numeric(complied_data$Threshold)

write.csv(complied_data, file = "D:\\Siva\\master thesis\\all\\suitable\\complied.csv", row.names = FALSE)
write.xlsx(complied_data, file = "D:\\Siva\\master thesis\\all\\suitable\\complied.xlsx", rowNames = FALSE)

write.csv(df_subset, file = "D:\\Siva\\master thesis\\all\\suitable\\complied_df_subset.csv", row.names = FALSE)
write.xlsx(df_subset, file = "D:\\Siva\\master thesis\\all\\suitable\\complied_df_subset.xlsx", rowNames = FALSE)

complied_data <- read.csv("N:/dep_coupland/grp_fulgione/siva/final_maxent/final_model/Final_models/projection/results_copy_projections/EC_past/regionarear/all/suitable/complied.csv")








