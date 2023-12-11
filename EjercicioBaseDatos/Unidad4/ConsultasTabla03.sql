use empleados;

-- Consultas SQL para la base de datos empleados

-- 1. Lista el primer apellido de todos los empleados
SELECT apellido1 FROM empleado;

-- 2. Lista el primer apellido de los empleados eliminando los repetidos
SELECT DISTINCT apellido1 FROM empleado;

-- 3. Lista todas las columnas de la tabla empleado
SELECT * FROM empleado;

-- 4. Lista el nombre y los apellidos de todos los empleados
SELECT nombre, apellido1, apellido2 FROM empleado;

-- 5. Lista el código de los departamentos de los empleados
SELECT codigo_departamento FROM empleado;

-- 6. Lista códigos de departamentos sin repetidos
SELECT DISTINCT codigo_departamento FROM empleado;

-- 7. Lista el nombre y apellidos en una columna
SELECT CONCAT(nombre, ' ', apellido1, ' ', apellido2) AS nombre_completo FROM empleado;

-- 8. Lista nombre y apellidos en mayúsculas
SELECT UPPER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombre_completo_mayus FROM empleado;

-- 9. Lista nombre y apellidos en minúsculas
SELECT LOWER(CONCAT(nombre, ' ', apellido1, ' ', apellido2)) AS nombre_completo_minus FROM empleado;

-- 10. Lista código y NIF separando dígitos y letra
SELECT codigo, SUBSTRING(nif, 1, LENGTH(nif) - 1) AS digitos_nif, RIGHT(nif, 1) AS letra_nif FROM empleado;

-- 11. Lista nombre de cada departamento y presupuesto actual
SELECT nombre, presupuesto - gastos AS presupuesto_actual FROM departamento;

-- 12. Lista nombre departamentos y presupuesto actual ordenado ascendentemente
SELECT nombre, presupuesto - gastos AS presupuesto_actual FROM departamento ORDER BY presupuesto_actual ASC;

-- 13. Lista nombres de departamentos ascendente
SELECT nombre FROM departamento ORDER BY nombre ASC;

-- 14. Lista nombres de departamentos descendente
SELECT nombre FROM departamento ORDER BY nombre DESC;

-- 15. Lista apellidos y nombre de empleados, ordenados alfabéticamente
SELECT apellido1, apellido2, nombre FROM empleado ORDER BY apellido1, apellido2, nombre;

-- 16. Primeros 3 departamentos con mayor presupuesto
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto DESC LIMIT 3;

-- 17. Primeros 3 departamentos con menor presupuesto
SELECT nombre, presupuesto FROM departamento ORDER BY presupuesto ASC LIMIT 3;

-- 18. Primeros 2 departamentos con mayor gasto
SELECT nombre, gastos FROM departamento ORDER BY gastos DESC LIMIT 2;

-- 19. Primeros 2 departamentos con menor gasto
SELECT nombre, gastos FROM departamento ORDER BY gastos ASC LIMIT 2;

-- 20. 5 filas a partir de la tercera fila de la tabla empleado
SELECT * FROM empleado LIMIT 2, 5;

-- 21. Departamentos con presupuesto ≥ 150000 euros
SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 150000;

-- 22. Departamentos con < 5000 euros de gastos
SELECT nombre, gastos FROM departamento WHERE gastos < 5000;

-- 23. Departamentos con presupuesto entre 100000 y 200000 euros (sin BETWEEN)
SELECT nombre, presupuesto FROM departamento WHERE presupuesto >= 100000 AND presupuesto <= 200000;

-- 24. Departamentos fuera del rango 100000 a 200000 euros (sin BETWEEN)
SELECT nombre, presupuesto FROM departamento WHERE NOT (presupuesto >= 100000 AND presupuesto <= 200000);

-- 25. Departamentos con presupuesto entre 100000 y 200000 euros (con BETWEEN)
SELECT nombre, presupuesto FROM departamento WHERE presupuesto BETWEEN 100000 AND 200000;

-- 26. Departamentos fuera del rango 100000 a 200000 euros (con BETWEEN)
SELECT nombre, presupuesto FROM departamento WHERE NOT presupuesto BETWEEN 100000 AND 200000;

-- 27. Departamentos con gastos mayores que el presupuesto
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos > presupuesto;

-- 28. Departamentos con gastos menores que el presupuesto
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos < presupuesto;

-- 29. Departamentos con gastos iguales al presupuesto
SELECT nombre, gastos, presupuesto FROM departamento WHERE gastos = presupuesto;

-- 30. Empleados con segundo apellido NULL
SELECT * FROM empleado WHERE apellido2 IS NULL;

-- 31. Empleados con segundo apellido no NULL
SELECT * FROM empleado WHERE apellido2 IS NOT NULL;

-- 32. Empleados con segundo apellido López
SELECT * FROM empleado WHERE apellido2 = 'López';

-- 33. Empleados con segundo apellido Díaz o Moreno (sin IN)
SELECT * FROM empleado WHERE apellido2 = 'Díaz' OR apellido2 = 'Moreno';

-- 34. Empleados con segundo apellido Díaz o Moreno (con IN)
SELECT * FROM empleado WHERE apellido2 IN ('Díaz', 'Moreno');

-- 35. Empleados del departamento 3
SELECT nombre, apellido1, apellido2, nif FROM empleado WHERE codigo_departamento = 3;

-- 36. Empleados de los departamentos 2, 4 o 5
SELECT nombre, apellido1, apellido2, nif FROM empleado WHERE codigo_departamento IN (2, 4, 5);
