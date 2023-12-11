use instituto2;

-- 1. Listado con los datos de todas las alumnas que se han matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN alumno_se_matricula_asignatura asm ON p.id = asm.alumno_id
JOIN asignatura a ON asm.asignatura_id = a.id
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Ingeniería Informática' AND p.tipo = 'alumno' AND p.sexo = 'F';

-- 2. Listado con todas las asignaturas ofertadas en el Grado en Ingeniería Informática (Plan 2015).
SELECT a.nombre
FROM asignatura a
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Ingeniería Informática';

-- 3. Listado de los profesores junto con el nombre del departamento al que están vinculados. Ordenados alfabéticamente por apellidos y nombre.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento
FROM profesor pr
JOIN persona p ON pr.id_profesor = p.id
JOIN departamento d ON pr.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 4. Listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno con NIF '26902806M'.
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin
FROM alumno_se_matricula_asignatura asm
JOIN asignatura a ON asm.asignatura_id = a.id
JOIN curso_escolar ce ON asm.id_curso_escolar = ce.id
JOIN persona p ON asm.alumno_id = p.id
WHERE p.dni = '26902806M';

-- 5. Listado de departamentos con profesores que imparten en Ingeniería Informática.
SELECT DISTINCT d.nombre
FROM departamento d
JOIN profesor pr ON d.id = pr.id_departamento
JOIN profesor_asignatura pa ON pr.id_profesor = pa.id_profesor
JOIN asignatura a ON pa.id_asignatura = a.id
JOIN grado g ON a.id_grado = g.id
WHERE g.nombre = 'Ingeniería Informática';

-- 6. Listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT p.nombre, p.apellido1, p.apellido2
FROM persona p
JOIN alumno_se_matricula_asignatura asm ON p.id = asm.alumno_id
JOIN curso_escolar ce ON asm.id_curso_escolar = ce.id
WHERE ce.anyo_inicio = 2018 AND ce.anyo_fin = 2019;
