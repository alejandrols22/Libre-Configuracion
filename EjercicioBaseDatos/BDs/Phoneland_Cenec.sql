-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         8.0.31 - MySQL Community Server - GPL
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.5.0.6677
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para phoneland_shop
CREATE DATABASE IF NOT EXISTS `phoneland_shop` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `phoneland_shop`;

-- Volcando estructura para tabla phoneland_shop.clientes
CREATE TABLE IF NOT EXISTS `clientes` (
  `idclientes` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `tipo_de_cliente` varchar(20) DEFAULT NULL,
  `ingresos` double DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`idclientes`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla phoneland_shop.clientes: 4 rows
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` (`idclientes`, `nombre`, `apellidos`, `direccion`, `ciudad`, `provincia`, `cp`, `tipo_de_cliente`, `ingresos`, `fecha`) VALUES
	(1, 'Alberto', 'Ruiz', 'Avenida Gandalf', 'Gondor', 'Tierra media', '29003', 'empresa', 9000.5, '2023-01-15'),
	(2, 'Laura', 'Perez', 'Calle Frodo', 'Bolso cerrado', 'La comarca', '28003', 'particular', 6000.75, '2023-02-20'),
	(3, 'Sauron', 'Gonzalez', 'Avenida maligna', 'Mordor city', 'Mordor', '38003', 'particular', 8000.75, '2023-02-20'),
	(4, 'Cristina', 'Perez', 'Avenida Andalucia', 'Málaga', 'Málaga', '29003', 'empresa', 2900.5, '2023-02-15');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;

-- Volcando estructura para tabla phoneland_shop.historial
CREATE TABLE IF NOT EXISTS `historial` (
  `idhistorial` int NOT NULL AUTO_INCREMENT,
  `fecha_hora_actual` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `mensaje` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idhistorial`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla phoneland_shop.historial: 1 rows
/*!40000 ALTER TABLE `historial` DISABLE KEYS */;
INSERT INTO `historial` (`idhistorial`, `fecha_hora_actual`, `mensaje`) VALUES
	(1, '2023-11-22 19:20:59', 'Se ha borrado el registro con idventas = 10, idclientes = 2, idproductos = 2, fecha_Ventas = 2023-01-01');
/*!40000 ALTER TABLE `historial` ENABLE KEYS */;

-- Volcando estructura para función phoneland_shop.max_precio_fabricante
DELIMITER //
CREATE FUNCTION `max_precio_fabricante`(nombre_fabricante VARCHAR(50)) RETURNS decimal(10,2)
BEGIN
    DECLARE max_precio DECIMAL(10,2);
    SELECT MAX(precio) INTO max_precio FROM productos 
    INNER JOIN fabricante ON fabricante.codigo=producto.codigo_fabricante
    WHERE fabricante.nombre = nombre_fabricante; -- aquí se agrega el cierre del paréntesis y la cláusula WHERE
    RETURN max_precio;
END//
DELIMITER ;

-- Volcando estructura para tabla phoneland_shop.productos
CREATE TABLE IF NOT EXISTS `productos` (
  `idproducto` int NOT NULL AUTO_INCREMENT,
  `idfabricante` int DEFAULT NULL,
  `nombre_producto` varchar(20) DEFAULT NULL,
  `precio` double DEFAULT NULL,
  PRIMARY KEY (`idproducto`),
  KEY `idx_idfabricante` (`idfabricante`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla phoneland_shop.productos: 3 rows
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` (`idproducto`, `idfabricante`, `nombre_producto`, `precio`) VALUES
	(1, 1, 'Movil iPhone', 999.99),
	(2, 2, 'Movil Honor', 499.99),
	(3, 3, 'Movil Samsung', 799.99);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;

-- Volcando estructura para tabla phoneland_shop.replica_ventas
CREATE TABLE IF NOT EXISTS `replica_ventas` (
  `idclientes` int DEFAULT NULL,
  `idventas` int NOT NULL DEFAULT '0',
  `idproductos` int DEFAULT NULL,
  `fecha_Ventas` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla phoneland_shop.replica_ventas: 5 rows
/*!40000 ALTER TABLE `replica_ventas` DISABLE KEYS */;
INSERT INTO `replica_ventas` (`idclientes`, `idventas`, `idproductos`, `fecha_Ventas`) VALUES
	(3, 7, 3, '2023-01-01'),
	(1, 7, 2, '2023-01-01'),
	(1, 11, 2, '2023-01-01'),
	(2, 9, 2, '2023-01-01'),
	(1, 10, 2, '2023-01-01');
/*!40000 ALTER TABLE `replica_ventas` ENABLE KEYS */;

-- Volcando estructura para tabla phoneland_shop.ventas
CREATE TABLE IF NOT EXISTS `ventas` (
  `idclientes` int DEFAULT NULL,
  `idventas` int NOT NULL AUTO_INCREMENT,
  `idproductos` int DEFAULT NULL,
  `fecha_Ventas` date DEFAULT NULL,
  PRIMARY KEY (`idventas`),
  KEY `idx_idclientes` (`idclientes`),
  KEY `idx_idproductos` (`idproductos`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Volcando datos para la tabla phoneland_shop.ventas: 11 rows
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` (`idclientes`, `idventas`, `idproductos`, `fecha_Ventas`) VALUES
	(1, 1, 1, '2023-01-10'),
	(2, 2, 2, '2023-02-15'),
	(3, 3, 3, '2023-03-20'),
	(1, 4, 2, '2023-04-05'),
	(2, 5, 1, '2023-05-10'),
	(3, 6, 3, '2023-06-15'),
	(2, 7, 2, '2023-01-01'),
	(2, 8, 3, '2023-01-01'),
	(2, 9, 2, '2023-01-01'),
	(2, 10, 2, '2023-01-01'),
	(1, 11, 2, '2023-01-01');
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;

-- Volcando estructura para disparador phoneland_shop.TRIGGER1
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `TRIGGER1` BEFORE INSERT ON `ventas` FOR EACH ROW BEGIN
    INSERT INTO replica_ventas (idventas, idclientes, idproductos, fecha_Ventas)
    VALUES (NEW.idventas, NEW.idclientes, NEW.idproductos, NEW.fecha_Ventas);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador phoneland_shop.TRIGGER_UPDATE_VENTAS2
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `TRIGGER_UPDATE_VENTAS2` AFTER UPDATE ON `ventas` FOR EACH ROW BEGIN
    -- Actualizar en replica_ventas después de una actualización
    UPDATE replica_ventas
    SET idclientes = NEW.idclientes,
        idproductos = NEW.idproductos,
        fecha_Ventas = NEW.fecha_Ventas
    WHERE idventas = NEW.idventas;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
