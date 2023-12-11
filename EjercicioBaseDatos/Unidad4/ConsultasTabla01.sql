use instituto;

-- Consultas SQL para la base de datos del Instituto

-- 1. Nombres invertidos
SELECT nombre, REVERSE(nombre) AS nombre_invertido
FROM alumno;

-- 2. Nombres y apellidos invertidos
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo,
       REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombre_completo_invertido
FROM alumno;

-- 3. Nombres y apellidos en mayúsculas y luego invertidos en minúsculas
SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombre_completo_mayusculas,
       LOWER(REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2))) AS nombre_completo_invertido_minusculas
FROM alumno;

-- 4. Número de caracteres en el nombre y apellidos
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo,
       LENGTH(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS longitud_nombre
FROM alumno;

-- 5. Dirección de correo electrónico
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo,
       LOWER(CONCAT(nombre, '.', apellido1, '@iescelia.org')) AS correo_electronico
FROM alumno;

-- 6. Correo electrónico y contraseña generada
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo,
       LOWER(CONCAT(nombre, '.', apellido1, '@iescelia.org')) AS correo_electronico,
       CONCAT(REVERSE(apellido2), SUBSTRING(YEAR(fecha_nacimiento), 3, 4)) AS contraseña
FROM alumno;

-- Funciones de Fecha y Hora

-- 1. Desglose de la fecha de nacimiento
SELECT fecha_nacimiento,
       DAY(fecha_nacimiento) AS dia,
       MONTH(fecha_nacimiento) AS mes,
       YEAR(fecha_nacimiento) AS año
FROM alumno;

-- 2. Día de la semana y mes de la fecha de nacimiento
SELECT fecha_nacimiento,
       DAYNAME(fecha_nacimiento) AS dia_semana,
       MONTHNAME(fecha_nacimiento) AS nombre_mes
FROM alumno;

-- 3. Días desde la fecha de nacimiento hasta hoy
SELECT fecha_nacimiento,
       DATEDIFF(NOW(), fecha_nacimiento) AS dias_desde_nacimiento
FROM alumno;

-- 4. Edad de los alumnos
SELECT fecha_nacimiento,
       TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM alumno;
