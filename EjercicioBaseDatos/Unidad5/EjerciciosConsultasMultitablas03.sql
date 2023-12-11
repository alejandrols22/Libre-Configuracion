use empleados;

-- Consultas multitablas para la base de datos Gestión de Empleados

-- 1. Empleados y los datos de los departamentos donde trabaja cada uno
SELECT e.*, d.*
FROM empleado e
JOIN departamento d ON e.codigo_departamento = d.codigo;

-- 2. Empleados y datos de departamentos ordenados por nombre de departamento y apellidos y nombre del empleado
SELECT e.*, d.*
FROM empleado e
JOIN departamento d ON e.codigo_departamento = d.codigo
ORDER BY d.nombre, e.apellido1, e.apellido2, e.nombre;

-- 3. Código y nombre del departamento con empleados
SELECT DISTINCT d.codigo, d.nombre
FROM departamento d
JOIN empleado e ON d.codigo = e.codigo_departamento;

-- 4. Código, nombre del departamento y presupuesto actual de departamentos con empleados
SELECT d.codigo, d.nombre, (d.presupuesto - d.gastos) AS presupuesto_actual
FROM departamento d
JOIN empleado e ON d.codigo = e.codigo_departamento;

-- 5. Nombre del departamento donde trabaja el empleado con NIF '38382980M'
SELECT d.nombre
FROM departamento d
JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.nif = '38382980M';

-- 6. Nombre del departamento donde trabaja Pepe Ruiz Santana
SELECT d.nombre
FROM departamento d
JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.nombre = 'Pepe' AND e.apellido1 = 'Ruiz' AND e.apellido2 = 'Santana';

-- 7. Datos de los empleados del departamento de I+D
SELECT e.*
FROM empleado e
JOIN departamento d ON e.codigo_departamento = d.codigo
WHERE d.nombre = 'I+D'
ORDER BY e.apellido1, e.apellido2, e.nombre;

-- 8. Datos de empleados que trabajan en Sistemas, Contabilidad o I+D
SELECT e.*
FROM empleado e
JOIN departamento d ON e.codigo_departamento = d.codigo
WHERE d.nombre IN ('Sistemas', 'Contabilidad', 'I+D')
ORDER BY e.apellido1, e.apellido2, e.nombre;

-- 9. Nombre de empleados de departamentos con presupuesto fuera del rango 100000 a 200000 euros
SELECT e.nombre
FROM empleado e
JOIN departamento d ON e.codigo_departamento = d.codigo
WHERE NOT (d.presupuesto BETWEEN 100000 AND 200000);

-- 10. Nombre de los departamentos con empleados cuyo segundo apellido es NULL
SELECT DISTINCT d.nombre
FROM departamento d
JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.apellido2 IS NULL;
