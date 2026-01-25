CREATE DATABASE IF NOT EXISTS Aurelion_Dashboard; -- Se crea la base de datos

USE Aurelion_Dashboard; -- Se selecciona la base de datos para su uso

-- Se crea la tabla clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    ciudad VARCHAR(50) NOT NULL,
    fecha_alta DATE NOT NULL
);

-- Se crea la tabla productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    categoria VARCHAR(25) NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL
    );

-- Se crea la tabla ventas
CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    id_cliente INT NOT NULL,
    nombre_cliente VARCHAR(50),
    email VARCHAR(100),
    medio_pago VARCHAR(25) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Se crea la tabla detalle ventas
CREATE TABLE Detalle_Ventas (
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(50) NOT NULL,
    cantidad DECIMAL(10, 2) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    importe DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);


-- Se verifica que las llaves foráneas se hayan creado correctamente
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'Aurelion'
  AND REFERENCED_TABLE_NAME IS NOT NULL;

-- Se verifica que las tablas se hayan creado correctamente
DESCRIBE Ventas;
DESCRIBE Clientes;
DESCRIBE Productos;
DESCRIBE Detalle_Ventas;