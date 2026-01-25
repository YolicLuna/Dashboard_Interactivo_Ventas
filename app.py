from dash import Dash, html, dcc
import plotly.express as px
from db import read_sql_df

SQL = """
SELECT Mes, COUNT(*) AS total_clientes
FROM Clientes
GROUP BY Mes;
"""

df = read_sql_df(SQL)

app = Dash(__name__)
app.title = 'Clientes por mes. (MySQL)'

fig = px.line(
    df, x='Mes', y='total_clientes',
    markers=True, title='Clientes por mes. (MySQL)'
)

app.layout = html.Div(
    [
        html.H1('Dashboard - Conexion Mysql'),
        dcc.Graph(figure=fig, id='clientes-mensuales'),
    ],
    style={'maxWidth': '900px', 'margin': '0 auto', 'padding': '16px'},
)

if __name__ == '__main__':
    app.run(host='127.0.0.1', port=8050, debug=True)
