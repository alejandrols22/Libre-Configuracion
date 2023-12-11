use instituto;

-- Datos del alumno con ID igual a 1:
SELECT * FROM alumno WHERE id = 1;
-- Datos del alumno con teléfono igual a 692735409:
SELECT * FROM alumno WHERE teléfono = '692735409';
-- Listado de todos los alumnos que son repetidores:
SELECT * FROM alumno WHERE es_repetidor = 'sí';
-- Listado de todos los alumnos que no son repetidores:
SELECT * FROM alumno WHERE es_repetidor = 'no';
-- Listado de alumnos nacidos antes del 1 de enero de 1993:
SELECT * FROM alumno WHERE fecha_nacimiento < '1993-01-01';
-- Listado de alumnos nacidos después del 1 de enero de 1994:
SELECT * FROM alumno WHERE fecha_nacimiento > '1994-01-01';
-- Listado de alumnos nacidos después del 1 de enero de 1994 y no son repetidores:
SELECT * FROM alumno WHERE fecha_nacimiento > '1994-01-01' AND es_repetidor = 'no';
-- Listado de todos los alumnos nacidos en 1998:
SELECT * FROM alumno WHERE YEAR(fecha_nacimiento) = 1998;
-- Listado de todos los alumnos que no nacieron en 1998:
SELECT * FROM alumno WHERE YEAR(fecha_nacimiento) <> 1998;


-- OPERADOR BETWEEN 
-- 1) Devuelve los datos de los alumnos que hayan nacido entre el 1 de enero de 1998 y el 31 de mayo de 1998. 
SELECT * FROM alumno WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '1998-05-31';


-- Ejercicios con Operadores y funciones 
-- Nombre de los alumnos y el nombre invertido:
SELECT nombre, REVERSE(nombre) AS nombre_invertido FROM alumno;
-- Nombre y apellidos de los alumnos y estos invertidos:
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo, 
       REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombre_completo_invertido 
FROM alumno;
-- Nombre y apellidos en mayúsculas y luego invertidos en minúsculas:
SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombre_completo_mayuscula, 
       LOWER(REVERSE(CONCAT(nombre, ' ', apellido1, ' ', apellido2))) AS nombre_completo_invertido_minuscula 
FROM alumno;
-- Nombre y apellidos, y la longitud de estos:
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo, 
       LENGTH(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS longitud_nombre_completo 
FROM alumno;
-- Nombre y apellidos, y dirección de correo electrónico:
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo, 
       LOWER(CONCAT(nombre, '.', apellido1, '@iescelia.org')) AS correo_electronico 
FROM alumno;
-- Nombre y apellidos, dirección de correo electrónico, y contraseña generada:
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo, 
       LOWER(CONCAT(nombre, '.', apellido1, '@iescelia.org')) AS correo_electronico, 
       CONCAT(REVERSE(apellido2), SUBSTRING(YEAR(fecha_nacimiento), 1, 4)) AS contraseña 
FROM alumno;

-- Funciones de fecha y hora

-- Fecha de nacimiento y sus componentes (día, mes, año):
SELECT fecha_nacimiento, 
       DAY(fecha_nacimiento) AS dia, 
       MONTH(fecha_nacimiento) AS mes, 
       YEAR(fecha_nacimiento) AS año 
FROM alumno;
-- Fecha de nacimiento, día de la semana y nombre del mes:
SELECT fecha_nacimiento, 
       DAYNAME(fecha_nacimiento) AS dia_semana, 
       MONTHNAME(fecha_nacimiento) AS nombre_mes 
FROM alumno;
-- Fecha de nacimiento y días transcurridos desde la fecha actual:
SELECT fecha_nacimiento, 
       DATEDIFF(NOW(), fecha_nacimiento) AS dias_desde_nacimiento 
FROM alumno;
-- Fecha de nacimiento y edad aproximada:
SELECT fecha_nacimiento, 
       YEAR(NOW()) - YEAR(fecha_nacimiento) - (DATE_FORMAT(NOW(), '%m%d') < DATE_FORMAT(fecha_nacimiento, '%m%d')) AS edad_aproximada 
FROM alumno;


