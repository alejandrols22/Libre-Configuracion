use tienda;

-- Devuelve los nombres de los fabricantes que tienen productos asociados (Utilizando EXISTS)
SELECT nombre
FROM fabricante
WHERE EXISTS (
    SELECT 1
    FROM producto
    WHERE producto.codigo_fabricante = fabricante.codigo
);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados (Utilizando NOT EXISTS)
SELECT nombre
FROM fabricante
WHERE NOT EXISTS (
    SELECT 1
    FROM producto
    WHERE producto.codigo_fabricante = fabricante.codigo
);

use empleados;

-- 1. Devuelve los nombres de los departamentos que tienen empleados asociados (Utilizando EXISTS).
SELECT nombre
FROM departamento
WHERE EXISTS (
    SELECT 1
    FROM empleado
    WHERE empleado.codigo_departamento = departamento.codigo
);

-- 2. Devuelve los nombres de los departamentos que no tienen empleados asociados (Utilizando NOT EXISTS).
SELECT nombre
FROM departamento
WHERE NOT EXISTS (
    SELECT 1
    FROM empleado
    WHERE empleado.codigo_departamento = departamento.codigo
);

use gestion_ventas;

-- 1. Devuelve un listado de los clientes que no han realizado ningún pedido (Utilizando NOT EXISTS).
SELECT c.nombre, c.apellido1, c.apellido2
FROM cliente c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido p
    WHERE p.id_cliente = c.id
);

-- 2. Devuelve un listado de los comerciales que no han realizado ningún pedido (Utilizando NOT EXISTS).
SELECT co.nombre, co.apellido1, co.apellido2
FROM comercial co
WHERE NOT EXISTS (
    SELECT 1
    FROM pedido p
    WHERE p.id_comercial = co.id
);

use jardineria;

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT *
FROM cliente
WHERE NOT EXISTS (
    SELECT *
    FROM pago
    WHERE codigo_cliente = cliente.id
);

-- 2. Devuelve un listado que muestre solamente los clientes que han realizado algún pago.
SELECT *
FROM cliente
WHERE EXISTS (
    SELECT *
    FROM pago
    WHERE codigo_cliente = cliente.id
);

-- 3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT *
FROM producto
WHERE NOT EXISTS (
    SELECT *
    FROM detalle_pedido
    WHERE codigo_producto = producto.id
);

-- 4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT *
FROM producto
WHERE EXISTS (
    SELECT *
    FROM detalle_pedido
    WHERE codigo_producto = producto.id
);
