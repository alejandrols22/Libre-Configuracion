use jardineria; 

-- 1. Listado de clientes que no han realizado ningún pago
SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- 2. Listado de clientes que no han realizado ningún pedido
SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
WHERE pe.codigo_cliente IS NULL;

-- 3. Listado de clientes que no han realizado ni pagos ni pedidos
SELECT c.nombre_cliente
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
WHERE p.codigo_cliente IS NULL AND pe.codigo_cliente IS NULL;

-- 4. Listado de empleados que no tienen un jefe asociado
SELECT e.nombre
FROM empleado e
WHERE e.codigo_jefe IS NULL;

-- 5. Listado de empleados que no tienen un cliente asociado

SELECT e.nombre, e.apellido1, e.apellido2
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.codigo_cliente IS NULL;

-- 6. Listado de empleados que no tienen un jefe asociado y que no tienen un cliente asociado

SELECT e.nombre, e.apellido1, e.apellido2
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE e.codigo_jefe IS NULL AND c.codigo_cliente IS NULL;

-- 7. Oficinas donde no trabajan empleados que han sido representantes de ventas de clientes que compraron productos de la gama Frutales
SELECT o.*
FROM oficina o
LEFT JOIN empleado e ON o.codigo_oficina = e.codigo_oficina AND e.puesto = 'Representante de Ventas'
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
LEFT JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
LEFT JOIN producto pr ON dp.codigo_producto = pr.codigo_producto AND pr.gama = 'Frutales'
WHERE e.codigo_empleado IS NULL;

-- 8. Clientes que han realizado pedidos pero no pagos
SELECT DISTINCT c.nombre_cliente
FROM cliente c
JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

-- 9. Datos de empleados que no tienen clientes asociados y el nombre de su jefe
SELECT e.nombre, j.nombre AS nombre_jefe
FROM empleado e
LEFT JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
LEFT JOIN empleado j ON e.codigo_jefe = j.codigo_empleado
WHERE c.codigo_cliente IS NULL;
