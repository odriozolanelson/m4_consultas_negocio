-- ══════════════════════════════════════════
-- Ventas_Tech
-- Autor: Nelson Odriozola
-- Fecha: 22/06/2026
-- Modulo 4
-- ══════════════════════════════════════════

-- Consulta 1 — Resumen ejecutivo mensual 
SELECT 
    MONTH(fecha_venta)AS Mes_Venta,
    SUM(cantidad * precio_unitario) AS Total_Facturado,
    COUNT(id_venta) AS Cantidad_de_Pedidos,
    AVG(cantidad * precio_unitario) AS Ticket_Promedio
FROM Ventas
GROUP BY MONTH(fecha_venta);


-- Consulta 2 — Ranking de productos
SELECT TOP 5
	id_producto,
	SUM(cantidad * precio_unitario) AS Total_Facturado,
	SUM(cantidad) AS Cantidades_Vendidas
FROM Ventas
GROUP BY id_producto
ORDER BY Total_Facturado DESC;

-- Consulta 3 — Clientes recurrentes
SELECT
	id_cliente,
	COUNT(id_venta) AS Cantidad_Pedidos,
	SUM(cantidad * precio_unitario) AS Total_Gastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1;


-- Consulta 4 — Meses por encima/por debajo del promedio 
SELECT
	MONTH(fecha_venta) AS Mes_Venta,
	SUM(cantidad * precio_unitario) AS Total_Facturado,
	AVG(SUM(cantidad * precio_unitario)) OVER() AS Promedio_General,
	CASE 
		WHEN SUM(cantidad * precio_unitario) >= AVG(SUM(cantidad * precio_unitario)) OVER() 
		THEN 'Igual o Por encima'
		ELSE 'Por debajo'
	END AS Evaluacion_Venta_Promedio
FROM Ventas
GROUP BY MONTH(fecha_venta);



-- Bloque de cierre 

-- Todas las ventas registradas se encuentran en marzo 2024
-- Todos los clientes tienene el 20% de los pedidos
-- El producto id 1 tiene el 55,86% del monto facturado
-- El producto id 2 tiene el 50% de las unidades vendidas
