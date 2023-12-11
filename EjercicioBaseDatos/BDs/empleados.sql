


--
-- Base de datos: `empleados`
--
DROP DATABASE IF EXISTS empleados;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE empleados;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento`
--

CREATE TABLE `departamento` (
  `codigo` int(10) UNSIGNED NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `presupuesto` double UNSIGNED NOT NULL,
  `gastos` double UNSIGNED NOT NULL
) ;

--
-- Volcado de datos para la tabla `departamento`
--

INSERT INTO `departamento` (`codigo`, `nombre`, `presupuesto`, `gastos`) VALUES
(1, 'Desarrollo', 120000, 6000),
(2, 'Sistemas', 150000, 21000),
(3, 'Recursos Humanos', 280000, 25000),
(4, 'Contabilidad', 110000, 3000),
(5, 'I+D', 375000, 380000),
(6, 'Proyectos', 0, 0),
(7, 'Publicidad', 0, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `codigo` int(10) UNSIGNED NOT NULL,
  `nif` varchar(9) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido1` varchar(100) NOT NULL,
  `apellido2` varchar(100) DEFAULT NULL,
  `codigo_departamento` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`codigo`, `nif`, `nombre`, `apellido1`, `apellido2`, `codigo_departamento`) VALUES
(1, '32481596F', 'Aarón', 'Rivero', 'Gómez', 1),
(2, 'Y5575632D', 'Adela', 'Salas', 'Díaz', 2),
(3, 'R6970642B', 'Adolfo', 'Rubio', 'Flores', 3),
(4, '77705545E', 'Adrián', 'Suárez', NULL, 4),
(5, '17087203C', 'Marcos', 'Loyola', 'Méndez', 5),
(6, '38382980M', 'María', 'Santana', 'Moreno', 1),
(7, '80576669X', 'Pilar', 'Ruiz', NULL, 2),
(8, '71651431Z', 'Pepe', 'Ruiz', 'Santana', 3),
(9, '56399183D', 'Juan', 'Gómez', 'López', 2),
(10, '46384486H', 'Diego', 'Flores', 'Salas', 5),
(11, '67389283A', 'Marta', 'Herrera', 'Gil', 1),
(12, '41234836R', 'Irene', 'Salas', 'Flores', NULL),
(13, '82635162B', 'Juan Antonio', 'Sáez', 'Guerrero', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `departamento`
--
ALTER TABLE `departamento`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`codigo`),
  ADD UNIQUE KEY `nif` (`nif`),
  ADD KEY `codigo_departamento` (`codigo_departamento`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `departamento`
--
ALTER TABLE `departamento`
  MODIFY `codigo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `codigo` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`codigo_departamento`) REFERENCES `departamento` (`codigo`);
COMMIT;


