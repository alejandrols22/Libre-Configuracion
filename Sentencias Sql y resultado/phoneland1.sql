-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-10-2023 a las 18:21:10
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4
CREATE DATABASE ahora7;
use ahora7;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `phoneland1`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `idclientes` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellidos` varchar(50) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL,
  `ciudad` varchar(50) DEFAULT NULL,
  `provincia` varchar(50) DEFAULT NULL,
  `cp` varchar(10) DEFAULT NULL,
  `tipo_de_cliente` varchar(20) DEFAULT NULL,
  `ingresos` double DEFAULT NULL,
  `fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`idclientes`, `nombre`, `apellidos`, `direccion`, `ciudad`, `provincia`, `cp`, `tipo_de_cliente`, `ingresos`, `fecha`) VALUES
(1, 'Alberto', 'Ruiz', 'Avenida Gandalf', 'Gondor', 'Tierra media', '29003', 'empresa', 9000.5, '2023-01-15'),
(2, 'Laura', 'Perez', 'Calle Frodo', 'Bolso cerrado', 'La comarca', '28003', 'particular', 6000.75, '2023-02-20'),
(3, 'Sauron', 'Gonzalez', 'Avenida maligna', 'Mordor city', 'Mordor', '38003', 'particular', 8000.75, '2023-02-20');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idproducto` int(11) NOT NULL,
  `idfabricante` int(11) DEFAULT NULL,
  `nombre_producto` varchar(20) DEFAULT NULL,
  `precio` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idproducto`, `idfabricante`, `nombre_producto`, `precio`) VALUES
(1, 1, 'Movil iPhone', 999.99),
(2, 2, 'Movil Honor', 499.99),
(3, 3, 'Movil Samsung', 799.99),
(4, 4, 'Xiaomi', 300.2);

-- --------------------------------------------------------
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

CREATE TABLE `ventas` (
  `idclientes` int(11) DEFAULT NULL,
  
  `idventas` int(11) NOT NULL,
  `idproductos` int(11) DEFAULT NULL,
  `fecha_Ventas` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`idclientes`, `idventas`, `idproductos`, `fecha_Ventas`) VALUES
(1, 1, 1, '2023-01-10'),
(2, 2, 2, '2023-02-15'),
(3, 3, 3, '2023-03-20'),
(1, 4, 2, '2023-04-05'),
(2, 5, 1, '2023-05-10'),
(3, 6, 3, '2023-06-15');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`idclientes`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idproducto`),
  ADD KEY `idx_idfabricante` (`idfabricante`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`idventas`),
  ADD KEY `idx_idclientes` (`idclientes`),
  ADD KEY `idx_idproductos` (`idproductos`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `idclientes` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idproducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `idventas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `fk_idclientes` FOREIGN KEY (`idclientes`) REFERENCES `clientes` (`idclientes`),
  ADD CONSTRAINT `fk_idproductos` FOREIGN KEY (`idproductos`) REFERENCES `productos` (`idproducto`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
