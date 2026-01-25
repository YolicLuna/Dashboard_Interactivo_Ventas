import pandas as pd

df = pd.read_csv('~/Desktop/Dashboard_Interactivo_Ventas/Data/sales_clean.csv')
print('Dataset cargado:', df.shape)

# Crear columna ventas totales
df['total_sales'] = df['quantity'] * df['unit_price']
print(df[['quantity', 'unit_price', 'total_sales']].head())

# margen o ganancia estimada

if 'cost' in df.columns:
    df['margin'] = df['total_sales'] - (df['quantity'] * df['cost'])
    df['margin_pct'] = (df['margin'] / df['total_sales']).round(2)
    print(df[['margin', 'margin_pct', 'total_sales']].head())
else:
    print('No se encontró la columna "cost".')

# kpis adicionales

df['avg_margin_per_item'] = (df['margin'] / df['quantity']).round(2)
df['avg_ticket'] = df['total_sales'] / df['quantity']

# Verificación rapida
print(df[['quantity', 'unit_price', 'cost', 'total_sales', 'margin']].head())


df.to_csv('~/Desktop/Dashboard_Interactivo_Ventas/Data/sales_processed.csv', index=False)
print('\nDataset limpio guardado en Data/sales_processed.csv')