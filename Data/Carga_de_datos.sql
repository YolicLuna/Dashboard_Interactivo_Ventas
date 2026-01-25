-- Active: 1765753889814@@127.0.0.1@3306@Aurelion_Dashboard
/*
Antes de cargar los datos, es importante que los archivos xlsx se conviertan a formato CSV y que 
se guarden en la carpeta mysql-files del contenedor de MySQL.
Esto se puede hacer desde la terminal ubicandose en la carpeta donde están los archivos y ejecutar (en Linux o Mac):
sudo cp Ventas.csv /var/lib/mysql-files/ en caso de archivos csv

En Windows, se debe copiar el archivo directamente en la carpeta mysql-files del contenedor de MySQL.
Luego, se debe reiniciar el contenedor de MySQL para que pueda acceder a los nuevos archivos.

Asegurate de que las tablas se hayan creado con la misma estructura que los archivos a cargar, mismas columnas
y tipos de datos. Si no es así, ajusta la estructura de las tablas o los archivos antes de continuar.
*/

USE Aurelion_Dashboard; -- Selecciona la base de datos Aurelion


-- Se cargan los datos de cada archivo en su tabla correspondiente


LOAD DATA INFILE '/var/lib/mysql-files/Clientes.csv'  -- Ruta del archivo CSV en el servidor MySQL
INTO TABLE Clientes    -- Nombre de la tabla a la que se importarán los datos
FIELDS TERMINATED BY ','    -- Separador de campos en el archivo CSV
ENCLOSED BY '"'     -- Carácter que encierra los campos del archivo CSV
LINES TERMINATED BY '\n'    -- Separador de líneas en el archivo CSV    
IGNORE 1 ROWS;    -- Ignorar la primera fila (encabezados)

LOAD DATA INFILE '/var/lib/mysql-files/Productos.csv'
INTO TABLE Productos    
FIELDS TERMINATED BY ','    
ENCLOSED BY '"'     
LINES TERMINATED BY '\n'     
IGNORE 1 ROWS;    

LOAD DATA INFILE '/var/lib/mysql-files/Ventas.csv'  
INTO TABLE Ventas   
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'   
LINES TERMINATED BY '\n'  
IGNORE 1 ROWS;  

LOAD DATA INFILE '/var/lib/mysql-files/Detalle_ventas.csv' 
INTO TABLE Detalle_Ventas   
FIELDS TERMINATED BY ','  
ENCLOSED BY '"'  
LINES TERMINATED BY '\n'     
IGNORE 1 ROWS; 


-- Se verifica que los datos se hayan cargado correctamente

SELECT * FROM Clientes;
SELECT * FROM Productos;
SELECT * FROM Ventas;
SELECT * FROM Detalle_Ventas;