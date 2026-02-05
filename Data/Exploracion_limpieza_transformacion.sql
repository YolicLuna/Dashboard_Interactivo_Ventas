-- Active: 1770178667709@@127.0.0.1@3306@aurelion_dashboard
/* 
Lo que haremos en este script es explorar los datos cargados, realizando consultas sql para 
analisar la calidad de los datos, identificar posibles problemas, formatos inconsistentes,
valores nulos, duplicados o vacios, columnas innecesarias, etc.
Luego, realizaremos las transformaciones correspondientes para que las tablas queden limpias.
*/

USE Aurelion_Dashboard;


-- Exploración de la tabla Clientes

-- Primero revisamos la tabla completa
SELECT * FROM Clientes;

-- Listamos los nombres de cada cliente (valores unicos) para identificar inconsistencias o valores duplicados
SELECT DISTINCT nombre_cliente FROM Clientes ORDER BY nombre_cliente;

-- Hacemos lo mismo con los emails, añadiendo la columna de nombre_cliente para identificar posibles duplicados
SELECT DISTINCT email, nombre_cliente FROM Clientes ORDER BY email;

/*
Con esta ultima consulta, podemos ver que hay varios clientes que tienen dos emails diferentes,
por lo tanto, dos registros en la tabla. Esto puede ser un problema si queremos identificar las ventas totales de cada cliente,
ya que al cotejar las ventas por id de clientes, las ventas de estos clientes se dividirán entre los dos registros.
Pero vamos a profundizar más añadiendo a la consulta las columnas de ciudad y fecha de alta, para ver si hay más diferencias entre estos registros.
*/

SELECT DISTINCT email, nombre_cliente, ciudad, fecha_alta FROM Clientes ORDER BY email;

/* 
Al ejecutar la consulta, podemos ver que cada registro, aun que con mismo nombre de cliente, tienen
email, ciudad y checha de alta diferentes. Por lo tanto, la posibilidad de que sean registros duplicados (mismo cliente)
es muy baja. Por lo tanto, no haremos ninguna transformación en esta tabla.
*/

-- Crearemos una nueva columna llamada Mes, extrallendo el mes de la columna fecha_alta y guardando el mes por su nombre
-- Primero creamos y añadimos la nueva columna
ALTER TABLE Clientes
ADD COLUMN Mes VARCHAR(15);

-- Despues, añadimos los datos a cada fila existente, obteniendo el nombre del mes desde la columna existente, fecha
UPDATE Clientes
SET Mes = MONTHNAME(fecha_alta);



-- Exploración de la tabla Productos

-- Primero revisamos la tabla completa
SELECT * 
FROM Productos;

-- Listamos los productos pertenecientes a la categoria 'Alimentos' para saber si hay inconsistencias en los nombres
SELECT nombre_producto, categoria 
FROM Productos 
WHERE categoria = 'Alimentos';

/*
Al revisar la lista, podemos observar que existen varios productos que no pertenecen a la categoria 'Alimentos',
sino a la categoria 'Limpieza'. Por lo tanto, haremos una transformación para corregir la categoria de esos productos.
*/

-- Transformación para corregir la categoria de los productos
UPDATE Productos
SET categoria = 'Limpieza'
WHERE nombre_producto IN ('Desodorante Aerosol', 'Cepillo de Dientes', 'Mascarilla Capilar', 'Limpiavidrios 500ml', 'Esponjas x3', 'Shampoo 400ml', 'Servilletas x100');

-- Verificamos que los cambios se hayan realizado correctamente
SELECT nombre_producto, categoria 
FROM Productos 
WHERE nombre_producto IN ('Desodorante Aerosol', 'Cepillo de Dientes', 'Mascarilla Capilar', 'Limpiavidrios 500ml', 'Esponjas x3', 'Shampoo 400ml', 'Servilletas x100');

-- Listamos los productos pertenecientes a la categoria 'Limpieza' para saber si hay inconsistencias en los nombres
SELECT nombre_producto, categoria 
FROM Productos 
WHERE categoria = 'Limpieza';

/*
Al revisar la lista, podemos observar que existen varios productos que no pertenecen a la categoria 'Limpieza',
sino a la categoria 'Alimentos'. Por lo tanto, haremos una transformación para corregir la categoria de esos productos.
*/

-- Transformación para corregir la categoria de los productos
UPDATE Productos
SET categoria = 'Alimentos'
WHERE nombre_producto IN ('Pepsi 1.5L', 'Fanta Naranja 1.5L', 'Jugo de Naranja 1L', 'Energética Nitro 500ml', 'Yerba Mate Intensa 1kg', 'Té Negro 20 saquitos', 'Leche Entera 1L',
'Yogur Natural 200g', 'Queso Rallado 150g', 'Pan Lactal Blanco', 'Medialunas de Manteca', 'Galletitas Chocolate', 'Alfajor Triple', 'Papas Fritas Clásicas 100g', 'Maní Salado 200g',
'Chocolate Amargo 100g', 'Turrón 50g','Dulce de Leche 400g', 'Mermelada de Frutilla 400g', 'Helado Chocolate 1L', 'Vinagre de Alcohol 500ml', 'Arroz Largo Fino 1kg', 'Lentejas Secas 500g',
'Porotos Negros 500g', 'Azúcar 1kg','Caramelos Masticables', 'Chupetín', 'Stevia 100 sobres', 'Avena Instantánea 250g', 'Cerveza Negra 1L', 'Vino Blanco 750ml', 'Fernet 750ml', 'Ron 700ml',
'Whisky 750ml', 'Pizza Congelada Muzzarella', 'Verduras Congeladas Mix', 'Helado de Frutilla 1L', 'Aceitunas Negras 200g', 'Queso Azul 150g', 'Jugo en Polvo Limón', 'Caldo Concentrado Carne');


-- Verificamos que los cambios se hayan realizado correctamente
SELECT nombre_producto, categoria 
FROM Productos 
WHERE nombre_producto IN ('Pepsi 1.5L', 'Fanta Naranja 1.5L', 'Jugo de Naranja 1L', 'Energética Nitro 500ml', 'Yerba Mate Intensa 1kg', 'Té Negro 20 saquitos', 'Leche Entera 1L',
'Yogur Natural 200g', 'Queso Rallado 150g', 'Pan Lactal Blanco', 'Medialunas de Manteca', 'Galletitas Chocolate', 'Alfajor Triple', 'Papas Fritas Clásicas 100g', 'Maní Salado 200g',
'Chocolate Amargo 100g', 'Turrón 50g','Dulce de Leche 400g', 'Mermelada de Frutilla 400g', 'Helado Chocolate 1L', 'Vinagre de Alcohol 500ml', 'Arroz Largo Fino 1kg', 'Lentejas Secas 500g',
'Porotos Negros 500g', 'Azúcar 1kg','Caramelos Masticables', 'Chupetín', 'Stevia 100 sobres', 'Avena Instantánea 250g', 'Cerveza Negra 1L', 'Vino Blanco 750ml', 'Fernet 750ml', 'Ron 700ml',
'Whisky 750ml', 'Pizza Congelada Muzzarella', 'Verduras Congeladas Mix', 'Helado de Frutilla 1L', 'Aceitunas Negras 200g', 'Queso Azul 150g', 'Jugo en Polvo Limón', 'Caldo Concentrado Carne');

-- Por ultimo, verificamos que el precio unitario no tenga valores nulos, negativos o vacios
SELECT nombre_producto, precio_unitario
FROM Productos
WHERE precio_unitario IS NULL OR precio_unitario < 0 OR precio_unitario = '';

/*
La consults no arroja ningun resultado, loq eu indica que todo esta bien con la columna precio_unitario.
Con esto ultimo terminamos la transfromación y limpieza de la tabla Productos.
*/


-- Exploración de la tabla Ventas
-- Primero revisamos la tabla completa
SELECT * 
FROM Ventas;

/*
Lo primero que se puede observar es que la tabla contiene las columnas id_cliente, nombre_cliente y email.
Esto podría ser redundante, ya que la información del cliente ya está almacenada en la tabla Clientes.
En la tabla Ventas, basta con almacenar el id_cliente para relacionar ambas tablas. 
Por lo tanto, se realiza la eliminación de las columnas nombre_cliente y email.
*/

-- Eliminación de las columnas nombre_cliente y email de la tabla Ventas
ALTER TABLE Ventas
DROP COLUMN nombre_cliente,
DROP COLUMN email;

-- Verificamos que las columnas se hayan eliminado correctamente
SELECT * FROM Ventas;

-- Ahora, listamios los medios de pago (valores unicos) para identificar inconsistencias.

SELECT DISTINCT medio_pago
FROM Ventas
ORDER BY medio_pago;

/*
La consulta arroja los unicos 4 medios de pago que contiene la tabla, sin inconsistencias.
Con esto damos por terminada la exploración y limpieza de la tabla Ventas.
*/

-- Crearemos una nueva columna llamada Mes, extrallendo el mes de la columna fecha y guardando el mes por su nombre
-- Primero creamos y añadimos la nueva columna
ALTER TABLE Ventas 
ADD COLUMN Mes VARCHAR(15);

-- Despues, añadimos los datos a cada fila existente, obteniendo el nombre del mes desde la columna existente, fecha
UPDATE Ventas
SET Mes = MONTHNAME(fecha);


-- Exploración de la tabla Detalle_Ventas

-- Primero revisamos la tabla completa
SELECT * 
FROM Detalle_Ventas;

/*
Podemoas ver algo parecido a a tabla Ventas, ya que esta tabla contiene las columnas id_producto, nombre_producto y precio_unitario.
Esto podría ser redundante, ya que la información del producto ya está almacenada en la tabla Productos.
En la tabla Detalle_Ventas, basta con almacenar el id_producto para relacionar ambas tablas.
Por lo tanto, se realiza la eliminación de las columnas nombre_producto y precio_unitario.
*/

-- Eliminación de las columnas nombre_producto y precio_unitario de la tabla Detalle_Ventas.

ALTER TABLE Detalle_Ventas
DROP COLUMN nombre_producto,
DROP COLUMN precio_unitario;

-- Verificamos que las columnas se hayan eliminado correctamente
SELECT * FROM Detalle_Ventas;

-- Verificamos que las columnas cantidad e importe no tengan valores nulos, negativos o vacios
SELECT cantidad FROM Detalle_Ventas WHERE cantidad IS NULL OR cantidad < 0 OR cantidad = '';
SELECT importe FROM Detalle_Ventas WHERE importe IS NULL OR importe < 0 OR importe = '';

/*
Ambas consultas no arrojan ningun resultado, lo que indica que todo esta bien con las columnas inspeccionadas.
Con esto terminamos la exploración y limpieza de la tabla Detalle_Ventas.
*/



-- Hemos terminado la exploración y limpieza de todas la tablas del proyecto Aurelion.
