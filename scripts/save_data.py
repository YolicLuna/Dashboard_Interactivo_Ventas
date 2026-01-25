import pandas as pd

df = pd.read_csv('Data/sales_processed.csv', parse_dates=['order_date'])
print('Dataset cargado: ', df.shape)


df.to_csv('Data/|sales_final.csv', index=False, encoding='utf-8')

df.to_parquet('Data/sales_final.parquer', index=False)
