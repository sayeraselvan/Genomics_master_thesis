import geopandas as gpd
import pandas as pd
import sys

if len(sys.argv) != 4:
    print("Usage: python your_python_script.py output_file.feather outputfile.xlsx output_suitable.xlsx")
    sys.exit(1)

# Get output file name from command-line arguments

output_file = sys.argv[1]
output_name = sys.argv[2]
output_name_suitable = sys.argv[3]

df = pd.read_feather(output_file)
world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))
gdf = gpd.GeoDataFrame(df, geometry=gpd.points_from_xy(df.x, df.y))
gdf.crs = {'init' :'epsg:4326'}
result = gpd.sjoin(gdf, world, how='left')

threshold = 0
subset_df = result[result['cell_values'] >= threshold]
grouped_df = subset_df.groupby('name').agg({'product': 'sum', 'layer': 'sum'}).reset_index()
grouped_df['Threshold'] = threshold
grouped_df_pivoted = grouped_df.pivot(index='Threshold', columns='name', values=['product', 'layer'])
grouped_df_pivoted.columns = ['{}_{}'.format(col[1], col[0]) for col in grouped_df_pivoted.columns]
colnames = grouped_df_pivoted.columns
results_df = pd.DataFrame(columns=colnames)

thresholds = [i/20 for i in range(20)]  # Equivalent to seq(0, 0.95, by = 0.05)

for threshold in thresholds:
        subset_df = result[result['cell_values'] >= threshold]
        grouped_df = subset_df.groupby('name').agg({'product': 'sum', 'layer': 'sum'}).reset_index()
        grouped_df['Threshold'] = threshold
        grouped_df_pivoted = grouped_df.pivot(index='Threshold', columns='name', values=['product', 'layer'])
        grouped_df_pivoted.columns = ['{}_{}'.format(col[1], col[0]) for col in grouped_df_pivoted.columns]
        grouped_df_pivoted['Threshold'] = threshold
        results_df = pd.concat([results_df, grouped_df_pivoted], axis=0)
        
results_df.reset_index(inplace=True)
results_df.to_excel(output_name, index=True)
thresholds = [0, 0.3025, 0.5350, 0.7675, 1.0]

threshold1 = 0
subset_df1 = result[result['cell_values'] >= threshold1]
grouped_df1 = subset_df1.groupby('name').agg({'product': 'sum', 'layer': 'sum'}).reset_index()
grouped_df1['Threshold'] = threshold1
grouped_df_pivoted1 = grouped_df1.pivot(index='Threshold', columns='name', values=['product', 'layer'])
grouped_df_pivoted1.columns = ['{}_{}'.format(col[1], col[0]) for col in grouped_df_pivoted1.columns]
colnames1 = grouped_df_pivoted1.columns
combined_df = pd.DataFrame(columns=colnames1)

for i in range(len(thresholds) - 1):
    min_threshold, max_threshold = thresholds[i], thresholds[i + 1]    
    subset_df1 = result[(result['cell_values'] >= min_threshold) & (result['cell_values'] < max_threshold)]
    grouped_df1 = subset_df1.groupby('name').agg({'product': 'sum', 'layer': 'sum'}).reset_index()
    grouped_df1['Threshold'] = i
    grouped_df_pivoted1 = grouped_df1.pivot(index='Threshold', columns='name', values=['product', 'layer'])
    grouped_df_pivoted1.columns = [f'{col[1]}_{col[0]}' for col in grouped_df_pivoted1.columns]
    combined_df = pd.concat([combined_df, grouped_df_pivoted1])

combined_df.reset_index(inplace=True)
combined_df.to_excel(output_name_suitable, index=True)
