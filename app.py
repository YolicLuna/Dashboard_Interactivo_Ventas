from dash import Dash, html, dcc
import plotly.express as px
import pandas as pd
from db import read_sql_df

BOOTSTRAP_CSS = 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css'
BOOTSTRAP_JS = 'https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.min.js'

dates = read_sql_df('''
    SELECT MIN(fecha_alta) AS min_f, MAX(fecha_alta) AS max_f
    FROM Clientes;
''')

min_fecha = pd.to_datetime(dates.iloc[0, 0]).date()
max_fecha = pd.to_datetime(dates.iloc[0, 1]).date()

df_mes = read_sql_df("""
SELECT mes, COUNT(*) AS total_clientes
FROM Clientes
GROUP BY mes;
""")

fig = px.line(
    df_mes, x='mes', y='total_clientes',
    markers=True, 
    title='Clientes por mes. (MySQL)'
    )

df_ventas = read_sql_df("""
SELECT medio_pago, COUNT(*) AS cantidad_ventas
FROM Ventas
GROUP BY medio_pago
ORDER BY cantidad_ventas DESC;
""")

fig_medio = px.bar(
    df_ventas, x='medio_pago', y='cantidad_ventas',
    title='Ventas por medio de pago. (MySQL)',
    text_auto='.2s'
    )

app = Dash(
    __name__,
    external_stylesheets=[BOOTSTRAP_CSS],
    external_scripts=[BOOTSTRAP_JS],
    )
app.title = 'Clientes por mes. (MySQL)'

app.layout = html.Div(
    className='container',
    children=[
        html.Div(
            className='header',
            children=[
                html.H1('Dashboard de clientes', className='titulo'),
                html.P('4.1 Estructura: ENcabezado filtros kPIs' \
                    'Visualizaciones',
                    className='subtitulo',
                ),
            ],
        ),

        html.Div(
            className='filtros',
            children=[
                html.Div(
                    className='filtro-items',
                    children=[
                        html.Label('Metrica'),
                        dcc.Dropdown(
                            id='dd-metric',
                            options=[
                                {'label': 'Clientes', 'value': 'clientes'},
                                {'label': 'Margen', 'value': 'margen'},
                            ],
                            value='clientes',
                            clearable=False
                        ),
                    ],
                ),
                html.Div(
                    className='filtro-items',
                    children=[
                        html.Label('Rango de fechas'),
                        dcc.DatePickerRange(
                            id='dp_range',
                            min_date_allowed=min_fecha,
                            max_date_allowed=max_fecha,
                            start_date=min_fecha,
                            end_date=max_fecha,
                            display_format='YYYY-MM-DD',
                        ),
                    ],
                ),
            ],
        ),
        html.Div(
            className='kpis text-primary',
            children=[
                html.Div(
                    className='kpi-card',
                    children=[html.Div('Clientes Toltales',
                    className='kpi-label'),
                              html.Div('$ -', className='valor_kpi')],
                ),
                html.Div(
                    className='kpi-card',
                    children=[html.Div('N° Ordenes', className='kpi-label'),
                              html.Div('-', className='kpi-valor')],
                ),
                html.Div(
                    className='kpi-card',
                    children=[html.Div('Ticket promedio',
                    className='kpi-label'),
                              html.Div('$-', className='valor_kpi')],
                ),
            ],
        ),
        
        html.Div(
            className='row', children=[
                html.Div(className='col-6', children=[dcc.Graph
                (id='g-clientes', figure=fig)]),
                html.Div(className='col-6', children=[dcc.Graph
                (id='g-medios', figure=fig_medio)]),
            ]),
    ],
)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8050, debug=True)
