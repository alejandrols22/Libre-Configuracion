-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-10-2023 a las 16:44:04
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `phoneland`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `calcular_precio_con_iva` (IN `precio` DECIMAL(10,2))   BEGIN
	 DECLARE precio_total decimal (10,2);
    SET precio_total = precio+precio_con_iva(precio);
	select precio "el importe es ",precio," el iva es ", precio_con_iva(precio), " ", precio_total;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calculator_while` (IN `numero` INT)   BEGIN
DECLARE contador,operacion INT;

WHILE contador <= 10 DO
SET operacion = numero * contador;
SET contador = contador + 1;
SELECT CONCAT(numero, " x " ,contador, " = ",operacion);
END WHILE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcula_edad` (IN `nacimiento` INT)   BEGIN
    	DECLARE ACTUAL INT DEFAULT 2021;
        DECLARE EDAD INT;
        SET EDAD=ACTUAL-NACIMIENTO;
        SELECT EDAD;
     END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `complemento` (IN `tipo_puesto` VARCHAR(20), OUT `complemento_salarial` DECIMAL(10,2))   BEGIN
    IF tipo_puesto = 'administrativo' THEN
        SET complemento_salarial = 100;
    ELSEIF tipo_puesto = 'programador' THEN
        SET complemento_salarial = 300;
    ELSEIF tipo_puesto = 'director' THEN
        SET complemento_salarial = 500;
    ELSE
        SET complemento_salarial = 0;
    END IF;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor1` ()   BEGIN
     DECLARE v_id int;
     DECLARE v_nombre varchar(17);
     DECLARE c_clientes CURSOR FOR
     SELECT Id_CLIENTES, NOMBRE FROM clientes WHERE Id_CLIENTES > 5; 
     OPEN c_clientes;
     FETCH c_clientes INTO v_id, v_nombre;
     SELECT v_id, v_nombre;
     CLOSE c_clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor2` ()   BEGIN
     DECLARE v_id int;
     DECLARE v_nombre varchar(17);
     DECLARE last_row int default 0;
     DECLARE c_clientes CURSOR FOR
     SELECT Id_CLIENTES, NOMBRE FROM clientes WHERE Id_CLIENTES >= 3;
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET last_row = 1;
     OPEN c_clientes;
     clientes_cur: LOOP
         FETCH c_clientes INTO v_id, v_nombre;
         IF last_row=1 THEN
             LEAVE clientes_cur;
         END IF;
         SELECT v_id, v_nombre;
     END LOOP clientes_cur;
CLOSE c_clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ejemplo1` ()   BEGIN
SELECT 'Mi primer programa en MySQL';
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ejemplo2` ()   BEGIN
  DECLARE precio double;
  DECLARE iva double DEFAULT 0.21;
  DECLARE total double;
  set precio=100;
  SET total = precio+(precio * iva);
  SELECT CONCAT('El IVA es ', iva, ', el precio es ', precio, ' y el total es ', total);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ejemplo_bucle_loop` (IN `tope` INT, OUT `suma` INT)   BEGIN
	DECLARE contador INT;
	SET contador=0;
	SET suma=0;
	bucle: loop
		if contador>tope then
			leave bucle;
		END if;
	SET suma = suma + contador;
	SET contador=contador+1;
	END loop;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ejemplo_bucle_repeat` (IN `tope` INT, OUT `suma` INT)   BEGIN
	DECLARE contador INT;
	SET contador=1;
	SET suma=0;
	repeat
	SET suma=suma+contador;
	SET contador=contador+1;
	until contador>tope
	END repeat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ejemplo_bucle_while` (IN `tope` INT, OUT `suma` INT)   BEGIN
DECLARE contador INT;
SET contador = 1;
SET suma = 0;
WHILE contador <= tope DO
SET suma = suma + contador;
SET contador = contador + 1;
END WHILE;
SELECT suma;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `error1` (`p_id` INT)  MODIFIES SQL DATA BEGIN
    DECLARE CONTINUE HANDLER FOR 1062
    SELECT CONCAT('El código introducido ', p_id, ' está duplicado') AS error_grave;
    INSERT INTO clientes (id_clientes) VALUES (p_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `iva21` ()   BEGIN
	DECLARE iva, total DECIMAL(2, 2);
	SET iva:=0.21;
    SELECT  
    @total:=(precio*iva) as total, unidades, unidades*@total as totalin
    FROM productos inner join ventas on  productos.id_PRODUCTO=ventas.id_PRODUCTOS;
   
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `iva21_descuento` ()   BEGIN
    DECLARE iva DECIMAL(4, 2);
    DECLARE total_sin_iva, total_con_iva, total_con_descuento DECIMAL(10, 2);

    SET iva := 0.21;

    SELECT productos.NOMBRE, productos.precio, ventas.unidades,
        productos.precio * ventas.unidades AS 'Total sin IVA',
        (productos.precio * ventas.unidades) * (1 + iva) AS 'Total con IVA',
        ((productos.precio * ventas.unidades) * (1 + iva)) * 0.9 AS 'Total con descuento'
    FROM productos INNER JOIN ventas ON productos.id_PRODUCTO = ventas.id_PRODUCTOS;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar` (IN `valor` INT, OUT `resultado` INT)   BEGIN
    SET resultado = duplicar(valor);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `procesar_clientes` ()   BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE id_cliente INT;
  DECLARE nombre_cliente VARCHAR(50);
  DECLARE cur_clientes CURSOR FOR SELECT id_clientes, clientes.NOMBRE FROM clientes;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  OPEN cur_clientes;
  LOOP_CLIENTES: LOOP
    FETCH cur_clientes INTO id_cliente, nombre_cliente;
    IF done THEN
      LEAVE LOOP_CLIENTES;
    END IF;
    
    -- Aquí va el código para procesar el registro del cliente
    SELECT CONCAT('Cliente: ', id_cliente, ' - ', nombre_cliente);
     DEALLOCATE PREPARE cur_clientes;
  END LOOP;
  CLOSE cur_clientes;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_multiplica` (IN `VALOR` INT)   BEGIN
  DECLARE contador int DEFAULT 0;
  DECLARE operacion int;
  tabla_mul: LOOP  
    SET contador=contador+1;
    SET operacion=valor*contador;
    IF contador=11 THEN
      LEAVE tabla_mul;
    END IF;

    SELECT valor, "x", contador, "=", operacion;

  END LOOP tabla_mul;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tabla_while` (IN `num` INT)   BEGIN
DECLARE i INT DEFAULT 1;
WHILE i <= 10 DO
SELECT CONCAT(num, " x ", i, " = ", num * i) as tabla;
SET i = i + 1;
END WHILE;
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `calcular_iva` (`precio` DECIMAL(10,2), `fabricante` VARCHAR(50)) RETURNS DECIMAL(10,2)  BEGIN
    DECLARE iva DECIMAL(10,2);
    
    DECLARE fabricante_not_found CONDITION FOR SQLSTATE '45000';
    
    IF fabricante <> 'XIAOMI' THEN
        SET iva = precio * 0.21;
    ELSE
        SET iva = 0;
    END IF;
    
    IF iva IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No se pudo calcular el IVA.';
    END IF;
    
    RETURN iva;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `diff_fechas` (`fecha1` DATE, `fecha2` DATE) RETURNS INT(11)  BEGIN
    DECLARE diff INT;
    
    SET diff = DATEDIFF(fecha1, fecha2);
    SET diff = TRUNCATE(diff/365, 0); -- Dividir entre 365 y truncar
    
    RETURN diff;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `duplicar` (`valor` INT) RETURNS INT(11)  BEGIN
    RETURN valor * 2;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `funcion1` (`precio` INT) RETURNS INT(11)  BEGIN
	RETURN PRECIO*0.21;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `funcion2` (`precio` INT) RETURNS INT(11)  BEGIN
	RETURN funcion1(PRECIO)+PRECIO;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `INCREMENTO` (`tipo` VARCHAR(3), `precio` DECIMAL(10,2)) RETURNS DECIMAL(20,2)  BEGIN
	DECLARE incre int;
	if tipo="90" THEN
    	set incre=300;
    elseif tipo="120" THEN
    	set incre=600;
    ELSE
        SET incre = 0;
    END IF;
    
   RETURN precio + incre;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `precio_con_iva` (`tipo` VARCHAR(3), `precio` DECIMAL(10,2)) RETURNS DECIMAL(20,2)  BEGIN
	DECLARE incre int;
	if tipo="90" THEN
    	set incre=300;
    elseif tipo="120" THEN
    	set incre=600;
    ELSE
        SET incre = 0;
    END IF;
    
   RETURN precio + incre;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `TIPO_PHONE` (`PRECIOMOVIL` INT) RETURNS VARCHAR(11) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  begin
    declare TIPO VARCHAR(11);
    IF PRECIOMOVIL>300 THEN
	 	SET TIPO="GAMA ALTA";
	 	ELSE
	 	SET TIPO="GAMA BAJA";
    END IF;
    
return TIPO;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `Id_CLIENTES` int(2) NOT NULL,
  `FECHA_DE_ALTA` varchar(9) DEFAULT NULL,
  `CIF_NIF` varchar(9) DEFAULT NULL,
  `NOMBRE` varchar(17) DEFAULT NULL,
  `DIRECCION` varchar(18) DEFAULT NULL,
  `CP` int(5) DEFAULT NULL,
  `CIUDAD` varchar(7) DEFAULT NULL,
  `PROVINCIA` varchar(6) DEFAULT NULL,
  `EMPRESA` varchar(2) DEFAULT NULL,
  `COMO_NOS_CONOCIO` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id_CLIENTES`, `FECHA_DE_ALTA`, `CIF_NIF`, `NOMBRE`, `DIRECCION`, `CP`, `CIUDAD`, `PROVINCIA`, `EMPRESA`, `COMO_NOS_CONOCIO`) VALUES
(1, '15-nov-20', '11111111A', 'ANA PEREZ', 'CALLE SOL,12', 29002, 'GRANADA', 'MALAGA', 'NO', 'GOOGLE'),
(2, '16-nov-20', '33241111J', 'EVA RUIZ', 'CALLE LUNA,13', 29003, 'SEVILLA', 'MALAGA', 'NO', 'GOOGLE'),
(3, '19-nov-20', '11111116A', 'ALBERTO GONZALEZ', 'AV.ANDALUCIA,14', 29005, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(4, '21-nov-20', '33111111A', 'MARIO VARGAS', 'AV. ANDALUCIA, 15', 29005, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(5, '22-nov-20', '11341111A', 'ALFREDO SANEZ', 'CALLE CUARTELES 1', 29002, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(6, '23-nov-20', '34113411C', 'BARTOLOME SANCHEZ', 'CALLE SALISTRE ,12', 29002, 'MALAGA', 'MALAGA', 'NO', 'GOOGLE'),
(7, '24-nov-20', '11111111A', 'CARMEN RUIZ perez', 'HUELIN, 23', 29002, 'MALAGA', 'MALAGA', 'NO', 'REDES SOCIALES'),
(8, '26-nov-20', '33111111J', 'MARIA RUIZ', 'CALLE SALISTRE,14', 29002, 'MALAGA', 'MALAGA', 'NO', 'REDES SOCILAES'),
(9, '28-nov-20', '11111111A', 'MARIO SANCHEZ', 'CALLE SALISTRE,22', 29002, 'MALAGA', 'MALAGA', 'NO', 'REDES SOCIALES'),
(10, '03-dic-20', 'B33111111', 'CORSAN', 'CALLE CUARTELES', 29002, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(11, '05-dic-20', 'A11111111', 'FERROVIAL', 'HUELIN ,34', 29002, 'SEVILLA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(12, '06-dic-20', 'C33111111', 'CORTES INGLES', 'AVD , AMERICAS 12', 29005, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(13, '10-feb-20', 'C11111111', 'ENDESA', 'AVD, AMERICAS 14', 29005, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(14, '11-feb-20', 'C11111111', 'MICROSOFT IBERICA', 'AVD,AMERICAS 15', 29005, 'MALAGA', 'MALAGA', 'SI', 'REDES SOCIALES'),
(102, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, NULL, NULL, 'Gandalf', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Disparadores `clientes`
--
DELIMITER $$
CREATE TRIGGER `TRIGGER1` BEFORE INSERT ON `clientes` FOR EACH ROW BEGIN
    INSERT INTO clientes_copia  VALUES (NEW.id_clientes,NEW.nombre);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes_copia`
--

CREATE TABLE `clientes_copia` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes_copia`
--

INSERT INTO `clientes_copia` (`id`, `nombre`) VALUES
(121, 'Gandalf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_PRODUCTO` int(2) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `NOMBRE` varchar(58) DEFAULT NULL,
  `FABRICANTE` varchar(7) DEFAULT NULL,
  `PRECIO` varchar(8) DEFAULT NULL,
  `PVP` decimal(10,2) DEFAULT NULL,
  `Descripcion` varchar(50) DEFAULT NULL,
  `Columna 8` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_PRODUCTO`, `id_proveedor`, `NOMBRE`, `FABRICANTE`, `PRECIO`, `PVP`, `Descripcion`, `Columna 8`) VALUES
(1, 1, 'XIAOMI IMI10LITE5G 6GB+128GBAzulBoreal', 'XIOAMI', '220,00 €', NULL, 'Alta gama usando en entornos de empresa', NULL),
(2, 2, 'SAMSUN GALAXYS20-FE-5G 8GB+256 AZUL MARINO MOVIL LIBRE', 'SAMSUNG', '650,00 €', NULL, NULL, NULL),
(3, 1, 'APPLE Iphone 11 128GB BLANCO MOVIL LIBRE', 'APPLE', '650,00 €', NULL, NULL, NULL),
(4, 1, 'XIAOMI MI 10T Pro 8 GB+256 GB Lunar Silver movil libre', 'XIOAMI', '580,00 €', NULL, 'gama baja entorno hogar', NULL),
(5, 1, 'SAMSUN GALAYI S20 FE 5G 8GB + 256 violeta movil libre', 'SAMSUNG', '600,00 €', NULL, NULL, NULL),
(6, 1, 'XIAOMI REDMI NOTE 9,4GB + 128 GB Polar white', 'XIOAMI', '100,00 €', NULL, NULL, NULL),
(7, 1, 'XIOAMI Mi 10 Lite 5G 6GB +128 Gris CoSmico', 'XIOAMI', '189,00 €', NULL, NULL, NULL),
(8, 1, 'SAMNUNG GALAXI A31 AZUL 4 GB + 64 GB Movil Libre', 'SAMSUNG', '100,00 €', NULL, NULL, NULL),
(9, 1, 'APPLE IPHONE 11 128GB Malva movil libre', 'APPLE', '650,00 €', NULL, 'alta gama entorno empresa', NULL),
(10, 2, 'SAMSUN GALAXY A51 4+128GB AZUL MOVIL LIBRE', 'SAMSUNG', '190,00 €', NULL, NULL, NULL),
(11, 2, 'LG K30 NEGRO 2GB + 16 GB MOVIL LIBRE', 'LG', '70,00 €', NULL, NULL, NULL),
(12, 2, 'iaomi Redmi Note 8 Pro Mineral Grey 128 GB + 6 GB Móvil li', 'XIOAMI', '180,00 €', NULL, NULL, NULL),
(13, 2, 'Samsung Galaxy S10 Lite 8 GB + 128 GB Azul móvil libre', 'SAMSUNG', '300,00 €', NULL, 'alta gama entorno hogar', NULL),
(14, 1, 'Samsung Galaxy S10 Lite 8 GB + 128 GB Azul móvil libre', 'APPLE', '600,00 €', NULL, NULL, NULL),
(15, 1, 'amsung Galaxy A21s 4 + 64 GB blanco móvil libre', 'SAMSUNG', '100,00 €', NULL, NULL, NULL),
(16, 1, 'Bronze móvil libre', 'SAMSUNG', '850,00 €', NULL, 'baja gama entorno empresa', NULL),
(17, 1, 'Xiaomi MI 10T Pro 8 GB + 256 GB Cosmic Black móvil libre', 'XIOAMI', '580,00 €', NULL, NULL, NULL),
(18, 1, 'Huawei P40 Lite 6+128 GB Verde móvil libre', 'HUAWEI', '190,00 €', NULL, NULL, NULL),
(19, 1, 'LG K51S 3+64 GB titán móvil libr', 'LG', '100,00 €', NULL, NULL, NULL),
(20, 2, 'LENOVO ONM', 'LENOVO', '200', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id_proveedor` int(11) NOT NULL,
  `nombre_proveedor` varchar(30) NOT NULL,
  `tlf_proveedor` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id_proveedor`, `nombre_proveedor`, `tlf_proveedor`) VALUES
(1, 'Apple', '123456789'),
(2, 'Microsoft', '123456789'),
(3, 'alberto', ''),
(4, 'eva', ''),
(5, 'eva', ''),
(6, 'eva', ''),
(7, 'HP', '');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `Id_VENTAS` int(2) NOT NULL,
  `id_PRODUCTOS` int(2) DEFAULT NULL,
  `Id_CLIENTES` int(2) DEFAULT NULL,
  `FECHA_DE_VENTA` varchar(9) DEFAULT NULL,
  `UNIDADES` int(2) DEFAULT NULL,
  `FEMISION` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`Id_VENTAS`, `id_PRODUCTOS`, `Id_CLIENTES`, `FECHA_DE_VENTA`, `UNIDADES`, `FEMISION`) VALUES
(1, 1, 6, '01-oct-20', 10, '2023-03-15'),
(52, 2, 13, '16-sep-20', 1, '2023-03-15'),
(53, 1, 13, '30-nov-20', 1, '2023-03-15'),
(54, 10, 6, '18-dic-20', 1, '2023-03-15'),
(55, 8, 4, '19-dic-20', 1, '2023-03-15'),
(56, 7, 6, '20-dic-20', 1, NULL),
(58, 11, 4, '22-dic-20', 1, NULL),
(60, 5, 14, '24-dic-20', 1, NULL),
(61, 2, 14, '18-nov-20', 1, NULL),
(62, 2, 11, '26-dic-20', 1, NULL),
(64, 4, 2, '28-dic-20', 1, NULL),
(65, 6, 12, '29-dic-20', 1, NULL),
(68, 5, 8, '01-nov-20', 1, NULL),
(69, 9, 1, '02-ene-21', 1, NULL),
(70, 12, 10, '03-ene-21', 1, NULL),
(71, 12, 11, '04-ene-21', 1, NULL),
(72, 8, 7, '05-ene-21', 1, NULL),
(73, 3, 2, '01-oct-20', 1, NULL),
(74, 12, 6, '07-ene-21', 1, NULL),
(75, 9, 14, '08-ene-21', 1, NULL),
(76, 3, 13, '09-ene-21', 1, NULL),
(77, 12, 12, '10-ene-21', 1, NULL),
(78, 10, 2, '11-ene-21', 1, NULL),
(80, 6, 6, '13-ene-21', 1, NULL),
(81, 12, 9, '14-ene-21', 1, NULL),
(82, 3, 3, '15-ene-21', 1, NULL),
(85, 7, 7, '18-ene-21', 1, NULL),
(86, 8, 6, '19-ene-21', 1, NULL),
(87, 10, 14, '20-ene-21', 1, NULL),
(89, 9, 10, '22-ene-21', 1, NULL),
(90, 8, 13, '23-ene-21', 1, NULL),
(91, 1, 6, '11-nov-20', 1, NULL),
(92, 11, 13, '25-ene-21', 1, NULL),
(94, 2, 11, '27-ene-21', 1, NULL),
(95, 14, 4, '28-ene-21', 1, NULL),
(96, 8, 2, '29-ene-21', 1, NULL),
(99, 7, 13, '01-feb-21', 1, NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Id_CLIENTES`);

--
-- Indices de la tabla `clientes_copia`
--
ALTER TABLE `clientes_copia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_PRODUCTO`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id_proveedor`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`Id_VENTAS`),
  ADD KEY `id_PRODUCTOS` (`id_PRODUCTOS`),
  ADD KEY `Id_CLIENTES` (`Id_CLIENTES`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id_proveedor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id_proveedor`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_PRODUCTOS`) REFERENCES `productos` (`id_PRODUCTO`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`Id_CLIENTES`) REFERENCES `clientes` (`Id_CLIENTES`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
