use jardineria;

-- Ejercicios de consultas multitablas sobre la base de datos Jardinería

-- 1. Listado de clientes y sus representantes de ventas
SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 2. Nombre de clientes que han realizado pagos y sus representantes de ventas
SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;

-- 3. Nombre de clientes que no han realizado pagos y sus representantes de ventas
SELECT c.nombre_cliente, e.nombre, e.apellido1
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
WHERE p.codigo_cliente IS NULL;

-- 4. Nombre de clientes que han hecho pagos y sus representantes, con ciudad de la oficina
SELECT DISTINCT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 5. Nombre de clientes que no han hecho pagos y sus representantes, con ciudad de la oficina
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina
WHERE p.codigo_cliente IS NULL;

-- 6. Dirección de oficinas con clientes en Fuenlabrada
SELECT o.linea_direccion1, o.linea_direccion2
FROM oficina o
JOIN empleado e ON o.codigo_oficina = e.codigo_oficina
JOIN cliente c ON e.codigo_empleado = c.codigo_empleado_rep_ventas
WHERE c.ciudad = 'Fuenlabrada';

-- 7. Nombre de clientes y representantes con ciudad de la oficina del representante
SELECT c.nombre_cliente, e.nombre, e.apellido1, o.ciudad
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
JOIN oficina o ON e.codigo_oficina = o.codigo_oficina;

-- 8. Nombre de empleados y sus jefes
SELECT e1.nombre AS Empleado, e2.nombre AS Jefe
FROM empleado e1
LEFT JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

-- 9. Nombre de clientes con pedidos no entregados a tiempo
SELECT c.nombre_cliente
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

-- 10. Gamas de producto compradas por cada cliente
SELECT c.nombre_cliente, gp.gamas
FROM cliente c
JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
JOIN detalle_pedido dp ON p.codigo_pedido = dp.codigo_pedido
JOIN producto pr ON dp.codigo_producto = pr.codigo_producto
JOIN gama_producto gp ON pr.gama = gp.gama;
