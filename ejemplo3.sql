

CREATE TABLE clientes(
	idclientes INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(100),
    ciudad VARCHAR(50),
    provincia VARCHAR(50),
    cp VARCHAR(10),
    tipo_de_cliente VARCHAR(50),
    ingresos DOUBLE,
    fecha DATE
    
    
    
    
    );
    
CREATE TABLE productos(
	idproductos INT AUTO_INCREMENT PRIMARY KEY,
    idfabricante INT,
	nombre_producto VARCHAR(50),
    precio DOUBLE,
    INDEX idx_idfabricante(idfabricante)
    );
    
CREATE TABLE ventas( 
	idclientes INT,
    idventas INT AUTO_INCREMENT PRIMARY KEY,
    idprodutos INT,
    fecha_VENTAS DATE,
    INDEX idx_idclientes(idclientes),
    INDEX idx_idproductos(idproductos)
    );
    
    ALTER TABLE ventas
    ADD CONSTRAINT fx_clientes
    FOREIGN KEY(idclientes)
    REFERENCES clientes(idclientes);
    
INSERT INTO ventas (idclientes, idproductos, fecha_Ventas) VALUES(1,1, 2022-2-2)
