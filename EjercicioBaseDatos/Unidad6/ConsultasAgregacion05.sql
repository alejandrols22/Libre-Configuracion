use universidad;

-- Número total de alumnas
SELECT COUNT(*) AS total_alumnas
FROM persona
WHERE tipo = 'alumno' AND sexo = 'M';

-- Alumnos nacidos en 1999
SELECT COUNT(*) AS total_alumnos_1999
FROM persona
WHERE tipo = 'alumno' AND YEAR(fecha_nacimiento) = 1999;

-- Número de profesores por departamento (solo departamentos con profesores)
SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.id
HAVING COUNT(p.id_profesor) > 0
ORDER BY numero_profesores DESC;

-- Listado de todos los departamentos y el número de profesores en cada uno
SELECT d.nombre AS nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.id;

-- Listado de grados y el número de asignaturas en cada uno (incluyendo grados sin asignaturas)
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.id;

-- Listado de grados con más de 40 asignaturas y el número de asignaturas en cada uno
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.id
HAVING COUNT(a.id) > 40;

-- Listado de grados, tipo de asignatura y suma de créditos por tipo
SELECT g.nombre AS nombre_grado, a.tipo, SUM(a.creditos) AS suma_creditos
FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.id, a.tipo;

-- Número de alumnos matriculados por año de inicio de curso escolar
SELECT ce.anyo_inicio, COUNT(am.id_alumno) AS numero_alumnos_matriculados
FROM curso_escolar ce
LEFT JOIN alumno_se_matricula_asignatura am ON ce.id = am.id_curso_escolar
GROUP BY ce.anyo_inicio;

-- Número de asignaturas impartidas por cada profesor (incluyendo profesores sin asignaturas)
SELECT p.id_profesor, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) AS numero_asignaturas
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
GROUP BY p.id_profesor, p.nombre, p.apellido1, p.apellido2
ORDER BY numero_asignaturas DESC;
