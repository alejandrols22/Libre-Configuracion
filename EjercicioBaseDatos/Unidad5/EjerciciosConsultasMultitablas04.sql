use tienda;

-- 1. Listado de todos los fabricantes y sus productos, incluyendo los que no tienen productos
SELECT f.nombre AS Fabricante, p.nombre AS Producto
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;

-- 2. Listado de fabricantes que no tienen ningún producto asociado
SELECT f.nombre AS Fabricante
FROM fabricante f
LEFT JOIN producto p ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- 3. La justificación sobre la existencia de productos sin fabricantes:
-- No pueden existir productos que no estén relacionados con un fabricante debido a la restricción de la clave extranjera en la columna 'codigo_fabricante' de la tabla 'producto', que debe hacer referencia a un 'codigo' válido en la tabla 'fabricante'.



-- 4. Listado de todos los empleados y los departamentos donde trabajan, incluyendo los que no tienen departamento
SELECT e.nombre AS Empleado, d.nombre AS Departamento
FROM empleado e
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo;

-- 5. Listado de empleados que no tienen ningún departamento asociado
SELECT e.nombre AS Empleado
FROM empleado e
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo
WHERE d.codigo IS NULL;

-- 6. Listado de departamentos que no tienen ningún empleado asociado
SELECT d.nombre AS Departamento
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.codigo_empleado IS NULL;

-- 7. Listado de todos los empleados y los departamentos donde trabajan, incluyendo empleados sin departamento y departamentos sin empleados, ordenados por nombre de departamento
-- Parte 1: Empleados con o sin departamento
SELECT e.nombre AS Empleado, d.nombre AS Departamento
FROM empleado e
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo
UNION
-- Parte 2: Departamentos sin empleados
SELECT e.nombre, d.nombre
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.codigo_empleado IS NULL
ORDER BY Departamento;

-- Nota: MySQL no soporta FULL OUTER JOIN directamente, por lo que normalmente se simula usando UNION de un LEFT JOIN y un RIGHT JOIN, filtrando los registros que no coinciden.

-- Simulando un FULL OUTER JOIN en MySQL para el punto 7
SELECT e.nombre AS Empleado, d.nombre AS Departamento
FROM empleado e
LEFT JOIN departamento d ON e.codigo_departamento = d.codigo
UNION
SELECT e.nombre, d.nombre
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE e.codigo_empleado IS NULL
ORDER BY Departamento;

-- 8. Listado de empleados sin departamento y departamentos sin empleados, ordenados por nombre de departamento
-- Parte 1: Empleados sin departamento
SELECT e.nombre AS Empleado, 'Sin Departamento' AS Departamento
FROM empleado e
WHERE e.codigo_departamento IS NULL
UNION
-- Parte 2: Departamentos sin empleadoss
SELECT 'Sin Empleado' AS Empleado, d.nombre AS Departamento
FROM departamento d
WHERE NOT EXISTS (SELECT * FROM empleado e WHERE e.codigo_departamento = d.codigo)
ORDER BY Departamento;
