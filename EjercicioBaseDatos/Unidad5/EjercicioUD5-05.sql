USE universidad;

-- Consultas sobre una tabla
-- Consultas sobre alumnos y asignaturas
-- 1. Listado de alumnas matriculadas en Ingeniería Informática (Plan 2015)
SELECT p.*
FROM persona p
JOIN alumno_se_matricula_asignatura asm ON p.id = asm.id_alumno
JOIN asignatura a ON asm.id_asignatura = a.id
JOIN grado g ON a.id_grado = g.id
WHERE p.sexo = 'F' AND g.nombre = 'Ingeniería Informática' AND p.tipo = 'alumno';

-- 2. Listado de asignaturas ofertadas en Ingeniería Informática (Plan 2015)
SELECT a.*
FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Ingeniería Informática';

-- 3. Listado de profesores y sus departamentos
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM persona p
JOIN profesor pr ON p.id = pr.id_profesor
JOIN departamento d ON pr.id_departamento = d.id
WHERE p.tipo = 'profesor'
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 4. Listado de asignaturas de un alumno específico
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin
FROM alumno_se_matricula_asignatura asm
JOIN asignatura a ON asm.id_asignatura = a.id
JOIN curso_escolar ce ON asm.id_curso_escolar = ce.id
JOIN persona p ON asm.id_alumno = p.id
WHERE p.nif = '26902806M';

-- 5. Departamentos con profesores en Ingeniería Informática
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor pr ON d.id = pr.id_departamento
JOIN asignatura a ON pr.id_profesor = a.id_profesor
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Ingeniería Informática';

-- 6. Alumnos matriculados en el curso escolar 2018/2019
SELECT p.*
FROM persona p
JOIN alumno_se_matricula_asignatura asm ON p.id = asm.id_alumno
JOIN curso_escolar ce ON asm.id_curso_escolar = ce.id
WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019 AND p.tipo = 'alumno';

