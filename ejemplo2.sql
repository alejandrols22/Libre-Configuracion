create database ejemplo_2;

use ejemplo_2;

CREATE TABLE clientes (
	idclientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(50),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    cp VARCHAR(10),
    tipo_de_cliente VARCHAR(20),
    ingresos double,
    fecha date
    
    );
    
CREATE TABLE producto(
	idproductos INT AUTO_INCREMENT ,
    idfabricante int,
    nombre_producto VARCHAR(20),
	precio DOUBLE,
	INDEX idx_idfabricante (idfabricante)
	);

CREATE TABLE ventas (
	fecha_ventas DATE,
    INDEX idx_idclientes (idclientes),
    INDEX idx_idproductos (idproductos)
    );
    
    
    
    
    ALTER TABLE ventas
    ADD CONSTRAINT fx_idclientes
    FOREIGN KEY (idclientes)
    REFERENCES clientes(idclientes);
    
    
    INSERT INTO