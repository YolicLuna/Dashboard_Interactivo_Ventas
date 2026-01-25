import pandas as pd

file_path = '~/Desktop/Dashboard_Interactivo_Ventas/Data/retail_data.xlsx'

df = pd.read_excel(file_path, sheet_name='sales_raw', parse_dates=['order_date'])
print('Data set cargado:', df.shape, 'filas x columnas')

# Exploración rápida de datos

print('\nColumnas:', df.columns.tolist())
print('\nTipos de datos:')
print(df.dtypes)

print('\nValores nulos por columna:')
print(df.isna().sum())

# Eliminar duplicados

before = df.shape[0]
df = df.drop_duplicates()
after = df.shape[0]

print(f'\nFilas eliminadas por duplicados: {before - after}')


# Manejar valores nulos

df['discount'] = df['discount'].fillna(0)

df = df.dropna(subset=['order_date', 'quantity'])

print('\nNulos restantes:')
print(df.isna().sum())


# Ajustar tipos de datos

df['product_id'] = df['product_id'].astype(str)
df['store_id'] = df['store_id'].astype(str)
df['quantity'] = df['quantity'].astype(int)
df['unit_price'] = df['unit_price'].astype(float)

# Extraer columnas de fechas

df['year'] = df['order_date'].dt.year
df['month'] = df['order_date'].dt.month

print(df.head())


# Guardar dataset limpio
df.to_csv('~/Desktop/Dashboard_Interactivo_Ventas/Data/sales_clean.csv', index=False)
print('\nDataset limpio guardado en Data/sales_clean.csv')