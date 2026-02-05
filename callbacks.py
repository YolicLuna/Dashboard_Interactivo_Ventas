from dash import Dash, html, dcc, Input, Output, State
from dash.exceptions import PreventUpdate

app = Dash(__name__)
app.title = 'Comparativa:cambio inmediato vs botón'

app.layout = html.Div([
    html.H2('Comparativa de callbacks'),

    html.Div([
        html.H4('1) Cambio inmediato (Input_Output)'),
            dcc.Input(id='input-inmediato', type='text', value='Dash', debounce=True),
            html.Div(id='out-inmediato', style={'marginTop':'6px', 'fontWeight':'bold'})
    ], style={'border':'1px solid #ddd', 'borderRadius':'8px', 'padding':'12px',
              'marginBottom':'16px'}),

    
    html.Div([
        html.H4('2) Solo al presionar botón (Input n_clicks + State)'),
        dcc.Input(id='input-boton', type='text', value='Dash'),
        html.Button('Actualizar', id='boton', n_clicks=0, style={'marginLeft':'8px'}),
        html.Div(id='out-boton', style={'marginTop':'6px', 'fontWeight':'bold'})
    ], style={'border':'1px solid #ddd', 'borderRadius':'8px', 'padding':'12px'})
])

@app.callback(
    Output('out-inmediato', 'children'),
    Input('input-inmediato', 'value')
)
def inmed(valor):
    return f'Hola {valor} (inmediato)'

@app.callback(
    Output('out-boton', 'children'),
    Input('boton', 'n_clicks'),
    State('input-boton', 'value'),
    prevent_initial_call=True
)
def con_boton(n_clicks, valor):
    if not n_clicks:
        raise PreventUpdate
    return f'Hola {valor} -(con botón, clicks. {n_clicks})'

if __name__ == '__main__':
    app.run(debug=True)