-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-05-2023 a las 11:40:56
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
-- Base de datos: `instituto`
--
CREATE DATABASE instituto;
USE instituto;


DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `CURSOR2` ()   BEGIN
    DECLARE v_id INT;
    DECLARE v_nombre VARCHAR(50);
    DECLARE v_ultima_fila INT DEFAULT 0;
    DECLARE c_alumnos CURSOR FOR
        SELECT id, nombre FROM alumno WHERE id<=6;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_ultima_fila=1;
    OPEN c_alumnos;
    alumnos_cursor: LOOP
        FETCH c_alumnos INTO v_id, v_nombre;
        IF v_ultima_fila=1 THEN
            LEAVE alumnos_cursor;
        END IF;
        SELECT v_id, v_nombre;
    END LOOP alumnos_cursor;
    CLOSE c_alumnos;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `error1` (`p_id` INT)  MODIFIES SQL DATA BEGIN
    

    insert into clientes (id_clientes) values (p_id);
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `area_circulo` (`radio` FLOAT) RETURNS FLOAT  BEGIN
    DECLARE area FLOAT;
    
    SET area = PI() * POW(radio, 2);
    SET area = TRUNCATE(area, 2); -- Redondear a dos decimales
    
    RETURN area;


END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `diff_fechas` (`fecha1` DATE, `fecha2` DATE) RETURNS INT(11)  BEGIN
    DECLARE diff INT;
    
    SET diff = DATEDIFF(fecha1, fecha2);
    SET diff = TRUNCATE(diff/365, 0); -- Dividir entre 365 y truncar
    
    RETURN diff;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `es_par` (`numero` INT) RETURNS TINYINT(1)  BEGIN
    IF numero % 2 = 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `mayor_de_tres` (`num1` FLOAT, `num2` FLOAT, `num3` FLOAT) RETURNS FLOAT  BEGIN
    DECLARE mayor FLOAT;
    
    IF num1 >= num2 AND num1 >= num3 THEN
        SET mayor = num1;
    ELSEIF num2 >= num1 AND num2 >= num3 THEN
        SET mayor = num2;
    ELSE
        SET mayor = num3;
    END IF;
    
    RETURN mayor;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `nombre_dia_semana` (`dia` INT) RETURNS VARCHAR(20) CHARSET utf8mb4 COLLATE utf8mb4_general_ci  BEGIN
    DECLARE nombre VARCHAR(20);
    
    CASE dia
        WHEN 1 THEN SET nombre = 'lunes';
        WHEN 2 THEN SET nombre = 'martes';
        WHEN 3 THEN SET nombre = 'miércoles';
        WHEN 4 THEN SET nombre = 'jueves';
        WHEN 5 THEN SET nombre = 'viernes';
        WHEN 6 THEN SET nombre = 'sábado';
        WHEN 7 THEN SET nombre = 'domingo';
        ELSE SET nombre = 'día inválido';
    END CASE;
    
    RETURN nombre;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `id` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido1` varchar(100) NOT NULL,
  `apellido2` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date NOT NULL,
  `es_repetidor` enum('sí','no') NOT NULL,
  `teléfono` varchar(9) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`id`, `nombre`, `apellido1`, `apellido2`, `fecha_nacimiento`, `es_repetidor`, `teléfono`) VALUES
(1, 'María', 'Sánchez', 'Pérez', '1990-12-01', 'no', NULL),
(2, 'Juan', 'Sáez', 'Vega', '1998-04-02', 'no', '618253876'),
(3, 'Pepe', 'Ramírez', 'Gea', '1988-01-03', 'no', NULL),
(4, 'Lucía', 'Sánchez', 'Ortega', '1993-06-13', 'sí', '678516294'),
(5, 'Paco', 'Martínez', 'López', '1995-11-24', 'no', '692735409'),
(6, 'Irene', 'Gutiérrez', 'Sánchez', '1991-03-28', 'sí', NULL),
(7, 'Cristina', 'Fernández', 'Ramírez', '1996-09-17', 'no', '628349590'),
(8, 'Antonio', 'Carretero', 'Ortega', '1994-05-20', 'sí', '612345633'),
(9, 'Manuel', 'Domínguez', 'Hernández', '1999-07-08', 'no', NULL),
(10, 'Daniel', 'Moreno', 'Ruiz', '1998-02-03', 'no', NULL),
(11, 'Bilbo', '', NULL, '0000-00-00', 'sí', NULL);

--
-- Disparadores `alumno`
--
DELIMITER $$
CREATE TRIGGER `TRIGGER1` 
BEFORE INSERT ON `alumno` 
FOR EACH ROW BEGIN
    INSERT INTO alumnos_replica  VALUES (NEW.id,NEW.nombre);
END
$$
DELIMITER ;

DELIMITER $$



CREATE TRIGGER `TRIGGER2` 
AFTER UPDATE ON `alumno` 
FOR EACH ROW BEGIN
    INSERT INTO audita
    VALUES (
        CONCAT('modificacion realizada por ', USER(),
        ' el dia ', NOW(), ' valores antiguos ', OLD.id, ' y ',
        OLD.nombre, ' valores nuevos ', NEW.id, ' ', NEW.nombre)
    );
END
$$
DELIMITER ;




-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumnos_replica`
--

CREATE TABLE `alumnos_replica` (
  `id` int(11) NOT NULL,
  `alumno` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumnos_replica`
--

INSERT INTO `alumnos_replica` (`id`, `alumno`) VALUES
(11, 'Gandalf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audita`
--

CREATE TABLE `audita` (
  `mensaje` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audita`
--

INSERT INTO `audita` (`mensaje`) VALUES
('modificacion realizada por root@localhost el dia 2023-05-22 11:32:07 valores antiguos 11 y Gandalf valores nuevos 11 Bilbo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `alumnos_replica`
--
ALTER TABLE `alumnos_replica`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `alumno`
--
ALTER TABLE `alumno`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
