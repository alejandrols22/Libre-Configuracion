use universidad;

-- Listado de profesores y los departamentos que tienen vinculados, incluyendo profesores sin departamento asociado.
SELECT d.nombre AS nombre_departamento, p.apellido1, p.apellido2, p.nombre
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- Listado de profesores que no están asociados a un departamento.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
WHERE pr.id_departamento IS NULL AND p.tipo = 'profesor';

-- Listado de departamentos que no tienen profesores asociados.
SELECT d.nombre
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
WHERE pr.id_profesor IS NULL;

-- Listado con los profesores que no imparten ninguna asignatura.

SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
LEFT JOIN profesor pr ON p.id = pr.id_profesor
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL AND p.tipo = 'profesor';

-- Listado con las asignaturas que no tienen un profesor asignado.

SELECT a.nombre
FROM asignatura a
WHERE a.id_profesor IS NULL;

-- Listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.

SELECT d.nombre
FROM departamento d
LEFT JOIN profesor pr ON d.id = pr.id_departamento
LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor
WHERE a.id IS NULL;
