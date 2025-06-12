import geopandas as gpd
import pandas as pd
import sys

if len(sys.argv) != 4:
    print("Usage: python your_python_script.py output_file.feather outputfile.xlsx")
    sys.exit(1)

# Get output file name from command-line arguments
output_file = sys.argv[1]
output_name = sys.argv[2]
output_suitable = sys.argv[3]

df = pd.read_feather(output_file)
world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))
gdf = gpd.GeoDataFrame(df, geometry=gpd.points_from_xy(df.x, df.y))
gdf.crs = {'init' :'epsg:4326'}
result = gpd.sjoin(gdf, world, how='left')

def map_to_region(country):
    # Groupings based on your previous categorization
    scandanavians = ['Greenland', 'Norway', 'Sweden', 'Denmark', 'Iceland', 'Finland']
    west_spain_portugal = ['Portugal', 'Spain']
    africa = ['Tunisia', 'Syria', 'Algeria', 'Morocco', 'Libya', 'Mauritania', 'Western Sahara', 'Egypt']
    central_european = ['Russia', 'Estonia', 'United Kingdom', 'Latvia', 'Lithuania', 'Belarus', 'Ireland', 'Germany',
                        'Poland', 'Netherlands', 'Ukraine', 'Belgium', 'Czechia', 'France', 'Luxembourg',
                        'Slovakia', 'Austria', 'Hungary', 'Moldova', 'Romania', 'Switzerland', 'Italy', 'Slovenia',
                        'Croatia', 'Serbia', 'Bosnia and Herz.', 'Bulgaria', 'Montenegro', 'Kosovo', 'Albania',
                        'North Macedonia', 'Greece']
    asian_countries = ['Kazakhstan', 'Georgia', 'Turkmenistan', 'Azerbaijan', 'Armenia', 'Iran', 'Iraq', 'Jordan',
                   'Israel', 'Lebanon', 'Saudi Arabia', 'Kuwait', 'Qatar']
    if country in scandanavians:
        return 'Scandinavians'
    elif country in west_spain_portugal:
        return 'West'
    elif country in africa:
        return 'Africa'
    elif country in central_european:
        return 'Centraleuropean'
    elif country in asian_countries:
	    return 'Asiancountries'
    else:
        return 'Unknown'

result['Region'] = result['name'].apply(map_to_region)

results_df = pd.DataFrame(columns=['Threshold', 'Africa_product', 'Centraleuropean_product', 'Scandinavians_product', 'Unknown_product',
                                    'West_product', 'Africa_layer', 'Centraleuropean_layer',
                                    'Scandinavians_layer', 'Asiancountries_product', 'Asiancountries_layer', 'Unknown_layer', 'West_layer'])
combined_df = results_df

thresholds = [i/20 for i in range(20)]  # Equivalent to seq(0, 0.95, by = 0.05)

for threshold in thresholds:
	subset_df = result[result['cell_values'] >= threshold]
	grouped_df = subset_df.groupby('Region').agg({'product': 'sum', 'layer': 'sum'}).reset_index()
	grouped_df['Threshold'] = threshold
	grouped_df_pivoted = grouped_df.pivot(index='Threshold', columns='Region', values=['product', 'layer'])
	grouped_df_pivoted.columns = ['{}_{}'.format(col[1], col[0]) for col in grouped_df_pivoted.columns]
	grouped_df_pivoted['Threshold'] = threshold
	results_df = pd.concat([results_df, grouped_df_pivoted], axis=0)

results_df.reset_index(inplace=True)
results_df.to_excel(output_name, index=True)


result['Region'] = result['name'].apply(map_to_region)

threshold_ranges = [(0.0, 0.3025), (0.3025, 0.5350), (0.5350, 0.7675), (0.7675, 1.0)]

for min_threshold, max_threshold in threshold_ranges:
    subset_df1 = result[(result['cell_values'] >= min_threshold) & (result['cell_values'] < max_threshold)]
    grouped_df1 = subset_df1.groupby('Region').agg({'product': 'sum', 'layer': 'sum'}).reset_index()
    grouped_df1['Threshold'] = f'{min_threshold}-{max_threshold}'
    grouped_df_pivoted1 = grouped_df1.pivot(index='Threshold', columns='Region', values=['product', 'layer'])
    grouped_df_pivoted1.columns = ['{}_{}'.format(col[1], col[0]) for col in grouped_df_pivoted1.columns]
    combined_df = pd.concat([combined_df, grouped_df_pivoted1])

combined_df.reset_index(inplace=True)
combined_df.to_excel(output_suitable, index=True)
