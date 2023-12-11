use empleados;

-- Inserta un nuevo departamento indicando su código, nombre y presupuesto
INSERT INTO departamento (codigo, nombre, presupuesto)
VALUES (10, 'Nuevo Departamento 1', 50000);

-- Inserta un nuevo departamento indicando su nombre y presupuesto
INSERT INTO departamento (nombre, presupuesto)
VALUES ('Nuevo Departamento 2', 60000);

-- Inserta un nuevo departamento indicando su código, nombre, presupuesto y gastos
INSERT INTO departamento (codigo, nombre, presupuesto, gastos)
VALUES (11, 'Nuevo Departamento 3', 70000, 10000);

-- Inserta un nuevo empleado asociado a uno de los nuevos departamentos
INSERT INTO empleado (codigo, nif, nombre, apellido1, apellido2, codigo_departamento)
VALUES (14, '12345678A', 'Nuevo Empleado 1', 'Apellido1', 'Apellido2', 10);

-- Inserta un nuevo empleado asociado a uno de los nuevos departamentos
INSERT INTO empleado (nif, nombre, apellido1, apellido2, codigo_departamento)
VALUES ('87654321B', 'Nuevo Empleado 2', 'Apellido1', 'Apellido2', 11);

-- Crea una nueva tabla departamento_backup y copia todos las filas de tabla departamento en departamento_backup
CREATE TABLE departamento_backup AS
SELECT * FROM departamento;

-- Elimina el departamento Proyectos si no tiene empleados asociados
DELETE FROM departamento WHERE nombre = 'Proyectos' AND codigo NOT IN (SELECT DISTINCT codigo_departamento FROM empleado);

-- Elimina el departamento Desarrollo si no tiene empleados asociados
DELETE FROM departamento WHERE nombre = 'Desarrollo' AND codigo NOT IN (SELECT DISTINCT codigo_departamento FROM empleado);

-- Actualiza el código del departamento Recursos Humanos y asígnale el valor 30 si no existe ya otro departamento con ese código
UPDATE departamento SET codigo = 30 WHERE nombre = 'Recursos Humanos' AND codigo <> 30;

-- Actualiza el código del departamento Publicidad y asígnale el valor 40 si no existe ya otro departamento con ese código
UPDATE departamento SET codigo = 40 WHERE nombre = 'Publicidad' AND codigo <> 40;

-- Actualiza el presupuesto de los departamentos sumándole 50000 € al valor del presupuesto actual, solamente a aquellos departamentos que tienen un presupuesto menor que 20000 €
UPDATE departamento SET presupuesto = presupuesto + 50000 WHERE presupuesto < 20000;
