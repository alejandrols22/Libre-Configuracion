use empleados; 

-- Suma del presupuesto de todos los departamentos
SELECT SUM(presupuesto) AS suma_presupuesto FROM departamento;

-- Media del presupuesto de todos los departamentos
SELECT AVG(presupuesto) AS media_presupuesto FROM departamento;

-- Valor mínimo del presupuesto de todos los departamentos
SELECT MIN(presupuesto) AS minimo_presupuesto FROM departamento;

-- Nombre del departamento y presupuesto del departamento con menor presupuesto
SELECT nombre, presupuesto FROM departamento WHERE presupuesto = (SELECT MIN(presupuesto) FROM departamento) LIMIT 1;

-- Valor máximo del presupuesto de todos los departamentos
SELECT MAX(presupuesto) AS maximo_presupuesto FROM departamento;

-- Nombre del departamento y presupuesto del departamento con mayor presupuesto
SELECT nombre, presupuesto FROM departamento WHERE presupuesto = (SELECT MAX(presupuesto) FROM departamento) LIMIT 1;

-- Número total de empleados en la tabla empleado
SELECT COUNT(*) AS total_empleados FROM empleado;

-- Número de empleados que no tienen NULL en su segundo apellido
SELECT COUNT(*) AS empleados_sin_apellido2 FROM empleado WHERE apellido2 IS NOT NULL;

-- Número de empleados por departamento
SELECT d.nombre AS nombre_departamento, COUNT(e.codigo) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY d.codigo;

-- Nombre de los departamentos con más de 2 empleados
SELECT d.nombre AS nombre_departamento, COUNT(e.codigo) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY d.codigo
HAVING numero_empleados > 2;

-- Número de empleados por departamento (incluyendo los que no tienen empleados)
SELECT d.nombre AS nombre_departamento, IFNULL(COUNT(e.codigo), 0) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
GROUP BY d.codigo;

-- Número de empleados por departamento con presupuesto mayor a 200000 euros
SELECT d.nombre AS nombre_departamento, COUNT(e.codigo) AS numero_empleados
FROM departamento d
LEFT JOIN empleado e ON d.codigo = e.codigo_departamento
WHERE d.presupuesto > 200000
GROUP BY d.codigo;
