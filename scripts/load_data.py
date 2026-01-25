import pandas as pd
file_path = '~/Desktop/Dashboard_Interactivo_Ventas/Data/retail_data.xlsx'

xls = pd.ExcelFile(file_path)
print('Hojas disponibles: ', xls.sheet_names)

df_sales = pd.read_excel(file_path, sheet_name='sales_raw', parse_dates=['order_date'])

print('sales_raw cargada')
print('Shape:', df_sales.shape)
print(df_sales.head())
print('\nTipos de datos:')
print(df_sales.dtypes)

df_products = pd.read_excel(file_path, sheet_name='products')
df_customers = pd.read_excel(file_path, sheet_name='customers')
df_stores = pd.read_excel(file_path, sheet_name='stores')

print('products:', df_products.shape, '| customers:', df_customers.shape,
      '| stores:', df_stores.shape)


all_sheets = pd.read_excel(file_path, sheet_name=None)
for name, df in all_sheets.items():
    print(f'{name}: {df.shape}')