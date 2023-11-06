/*CREATE DATABASE IF NOT EXISTS phoneland_cenec; */
USE phoneland_cenec;
-- Creación de la tabla "clientes"
CREATE TABLE `clientes` (
  `Id_CLIENTES` int(11) NOT NULL,
  `FECHA_DE_ALTA` DATE,
  `CIF_NIF` varchar(9) DEFAULT NULL,
  `NOMBRE_CLIENTE` VARCHAR(20) DEFAULT NULL,
  `DIRECCION` varchar(18) DEFAULT NULL,
  `CP` int(5) DEFAULT NULL,
  `CIUDAD` varchar(7) DEFAULT NULL,
  `PROVINCIA` varchar(6) DEFAULT NULL,
  `EMPRESA` varchar(2) DEFAULT NULL,
  `COMO_NOS_CONOCIO` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`Id_CLIENTES`)
);

-- Creación de la tabla "proveedores"
CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_proveedor` varchar(30) NOT NULL,
  `tlf_proveedor` varchar(10) NOT NULL,
  PRIMARY KEY (`id_proveedor`)
);
-- Insertar datos en la tabla "clientes"
INSERT INTO `clientes` (`Id_CLIENTES`, `FECHA_DE_ALTA`, `CIF_NIF`, `NOMBRE`, `DIRECCION`, `CP`, `CIUDAD`, `PROVINCIA`, `EMPRESA`, `COMO_NOS_CONOCIO`) VALUES
  (1, '2020-11-15', '11111111A', 'ANA PEREZ', 'CALLE SOL,12', 29002, 'GRANADA', 'MALAGA', 'NO', 'GOOGLE'),
  (2, '2020-11-16', '33241111J', 'EVA RUIZ', 'CALLE LUNA,13', 29003, 'SEVILLA', 'MALAGA', 'NO', 'GOOGLE');
  -- Insertar otros registros aquí...

-- Creación de la tabla "productos"
CREATE TABLE `productos` (
  `id_PRODUCTO` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `NOMBRE` varchar(58) DEFAULT NULL,
  `FABRICANTE` varchar(7) DEFAULT NULL,
  `PRECIO` decimal(10,2) DEFAULT NULL,
  `PVP` decimal(10,2) DEFAULT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `Columna 8` int(11) DEFAULT NULL,
  `fecha_entrada` DATE DEFAULT NULL,
  PRIMARY KEY (`id_PRODUCTO`),
  KEY `id_proveedor` (`id_proveedor`),
  CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`)
);

-- Insertar datos en la tabla "productos"
INSERT INTO `productos` (`id_PRODUCTO`, `id_proveedor`, `NOMBRE`, `FABRICANTE`, `PRECIO`, `PVP`, `Descripcion`, `Columna 8`, `fecha_entrada`) VALUES
  (1, 3, 'XIAOMI IMI10LITE5G 6GB+128GBAzulBoreal', 'XIOAMI', 220.00, NULL, 'Alta gama usando en entornos de empresa', NULL, '2023-10-18'),
  (2, 5, 'SAMSUN GALAXYS20-FE-5G 8GB+256 AZUL MARINO MOVIL LIBRE', 'SAMSUNG', 650.00, NULL, NULL, NULL, '2023-10-18');
  -- Insertar otros registros aquí...



-- Insertar datos en la tabla "proveedores"
INSERT INTO `proveedores` (`nombre_proveedor`, `tlf_proveedor`) VALUES
  ('Apple', '123456789'),
  ('Microsoft', '123456789');
  -- Insertar otros registros aquí...

-- Creación de la tabla "ventas"
CREATE TABLE `ventas` (
  `Id_VENTAS` int(11) NOT NULL,
  `id_PRODUCTOS` int(11) DEFAULT NULL,
  `Id_CLIENTES` int(11) DEFAULT NULL,
  `FECHA_DE_VENTA` DATE DEFAULT NULL,
  `UNIDADES` int(11) DEFAULT NULL,
  `FEMISION` DATE DEFAULT NULL,
  PRIMARY KEY (`Id_VENTAS`),
  KEY `id_PRODUCTOS` (`id_PRODUCTOS`),
  KEY `Id_CLIENTES` (`Id_CLIENTES`),
  CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_PRODUCTOS`) REFERENCES `productos` (`id_PRODUCTO`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`Id_CLIENTES`) REFERENCES `clientes` (`Id_CLIENTES`) ON DELETE SET NULL ON UPDATE CASCADE
);

-- Insertar datos en la tabla "ventas"
INSERT INTO `ventas` (`Id_VENTAS`, `id_PRODUCTOS`, `Id_CLIENTES`, `FECHA_DE_VENTA`, `UNIDADES`, `FEMISION`) VALUES
  (1, 1, 6, '2020-10-01', 10, '2023-03-15'),
  (52, 2, 13, '2020-09-16', 1, '2023-03-15');
  -- Insertar otros registros aquí...