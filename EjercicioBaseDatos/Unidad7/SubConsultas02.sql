use tienda;

-- Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT nombre
FROM producto
WHERE precio >= ALL (SELECT precio FROM producto);

-- Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
SELECT nombre
FROM producto
WHERE precio <= ALL (SELECT precio FROM producto);

-- Devuelve los nombres de los fabricantes que tienen productos asociados (utilizando ALL o ANY).
SELECT nombre
FROM fabricante
WHERE codigo IN (SELECT DISTINCT codigo_fabricante FROM producto);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados (utilizando ALL o ANY).
SELECT nombre
FROM fabricante
WHERE codigo NOT IN (SELECT DISTINCT codigo_fabricante FROM producto);

-- Devuelve los nombres de los fabricantes que tienen productos asociados (utilizando IN o NOT IN).
SELECT nombre
FROM fabricante
WHERE codigo IN (SELECT DISTINCT codigo_fabricante FROM producto);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados (utilizando IN o NOT IN).
SELECT nombre
FROM fabricante
WHERE codigo NOT IN (SELECT DISTINCT codigo_fabricante FROM producto);

use empleados;

-- Devuelve el nombre del departamento con mayor presupuesto y la cantidad que tiene asignada (sin usar MAX, ORDER BY ni LIMIT).
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto >= ALL (SELECT presupuesto FROM departamento);

-- Devuelve el nombre del departamento con menor presupuesto y la cantidad que tiene asignada (sin usar MIN, ORDER BY ni LIMIT).
SELECT nombre, presupuesto
FROM departamento
WHERE presupuesto <= ALL (SELECT presupuesto FROM departamento);

-- Devuelve los nombres de los departamentos que tienen empleados asociados (utilizando ALL o ANY).
SELECT nombre
FROM departamento
WHERE codigo IN (SELECT DISTINCT codigo_departamento FROM empleado);

-- Devuelve los nombres de los departamentos que no tienen empleados asociados (utilizando ALL o ANY).
SELECT nombre
FROM departamento
WHERE codigo NOT IN (SELECT DISTINCT codigo_departamento FROM empleado);
 
-- Devuelve los nombres de los departamentos que tienen empleados asociados (utilizando IN o NOT IN).
SELECT nombre
FROM departamento
WHERE codigo IN (SELECT DISTINCT codigo_departamento FROM empleado);

-- Devuelve los nombres de los departamentos que no tienen empleados asociados (utilizando IN o NOT IN).
SELECT nombre
FROM departamento
WHERE codigo NOT IN (SELECT DISTINCT codigo_departamento FROM empleado);

use gestion_ventas;

-- Devuelve el pedido más caro que existe en la tabla pedido sin hacer uso de MAX, ORDER BY ni LIMIT.
SELECT cantidad
FROM pedido
WHERE cantidad >= ALL (SELECT cantidad FROM pedido);

-- Devuelve un listado de los clientes que no han realizado ningún pedido (utilizando ANY o ALL).
SELECT nombre, apellido1, apellido2
FROM cliente
WHERE id NOT IN (SELECT DISTINCT id_cliente FROM pedido);

-- Devuelve un listado de los comerciales que no han realizado ningún pedido (utilizando ANY o ALL).
SELECT nombre, apellido1, apellido2
FROM comercial
WHERE id NOT IN (SELECT DISTINCT id_comercial FROM pedido);

-- Devuelve un listado de los clientes que no han realizado ningún pedido (utilizando IN o NOT IN).
SELECT nombre, apellido1, apellido2
FROM cliente
WHERE id NOT IN (SELECT DISTINCT id_cliente FROM pedido);

-- Devuelve un listado de los comerciales que no han realizado ningún pedido (utilizando IN o NOT IN).
SELECT nombre, apellido1, apellido2
FROM comercial
WHERE id NOT IN (SELECT DISTINCT id_comercial FROM pedido);

use jardineria;
-- Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente
FROM cliente
WHERE limite_credito >= ALL (SELECT limite_credito FROM cliente);

-- Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre
FROM producto
WHERE precio_venta >= ALL (SELECT precio_venta FROM producto);

-- Devuelve el producto que menos unidades tiene en stock.
SELECT *
FROM producto
WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock FROM producto);

-- Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT nombre, apellido1, puesto
FROM empleado
WHERE codigo_empleado NOT IN (SELECT DISTINCT codigo_empleado_rep_ventas FROM cliente);

-- Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

-- Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pago);

-- Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT nombre
FROM producto
WHERE codigo_producto NOT IN (SELECT DISTINCT codigo_producto FROM detalle_pedido);

-- Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT e.nombre, e.apellido1, e.apellido2, e.puesto, o.telefono
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE e.codigo_empleado NOT IN (SELECT DISTINCT codigo_empleado_rep_ventas FROM cliente);

-- Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT DISTINCT o.*
FROM oficina o
WHERE o.codigo_oficina NOT IN (SELECT DISTINCT e.codigo_oficina
                              FROM empleado e
                              JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
                              JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
                              JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
                              JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
                              WHERE pr.gama = 'Frutales');

-- Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT nombre_cliente
FROM cliente
WHERE codigo_cliente IN (SELECT DISTINCT codigo_cliente FROM pedido)
      AND codigo_cliente NOT IN (SELECT DISTINCT codigo_cliente FROM pago);

use universidad;

-- Devuelve todos los datos del alumno más joven.
SELECT *
FROM alumno
WHERE fecha_nacimiento = (SELECT MIN(fecha_nacimiento) FROM alumno);

-- Devuelve un listado con los profesores que no están asociados a un departamento.
SELECT *
FROM profesor
WHERE id_departamento IS NULL;

-- Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT *
FROM departamento
WHERE codigo NOT IN (SELECT DISTINCT id_departamento FROM profesor);

-- Devuelve un listado con los profesores que tienen un departamento asociado y que no imparten ninguna asignatura.
SELECT *
FROM profesor
WHERE id_departamento IS NOT NULL
      AND codigo NOT IN (SELECT DISTINCT id_profesor FROM asignatura);

-- Devuelve un listado con las asignaturas que no tienen un profesor asignado.
SELECT *
FROM asignatura
WHERE id_profesor IS NULL;

-- Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT *
FROM departamento
WHERE codigo NOT IN (SELECT DISTINCT id_departamento FROM asignatura);

