-- Crear base de datos
CREATE DATABASE IF NOT EXISTS SuperStoreUS;

USE SuperStoreUS;

-- Crear tabla Orders
CREATE TABLE IF NOT EXISTS Orders (
	RowID INT PRIMARY KEY,
	OrderPrio VARCHAR(25),
	Disc Decimal(5,2),
	UnitPrice Decimal,
	ShipCost Decimal(5,2),
	CustID INT,
	CustName VARCHAR (60),
	ShipMode VARCHAR(30),
	CustSegment VARCHAR(30),
	ProdCategory VARCHAR(30),
	ProdSubcat VARCHAR(90),
	ProdContainer VARCHAR(30),
	ProdName VARCHAR(100),
	ProdBMargin	DECIMAL,
	Country	VARCHAR(30),
	Region VARCHAR(10),
	State VARCHAR(50),
	City VARCHAR(50),
	PostalCode INT,
	OrderDate date,
	ShipDate date,
	Profit Decimal(10,2),
	QtyOrdered INT,
	Sales Decimal(10,2),
	OrderID	INT,
    FOREIGN KEY (Region) REFERENCES Regions(Region)
);

-- Crea tabla Regions
CREATE TABLE IF NOT EXISTS Regions (
	Region VARCHAR(10) PRIMARY KEY,
	Manager  VARCHAR(20)
);

select * from orders;
-- 1.- ¿Cuántas ordenes fueron de prioridad crítica?
Select count(*) from orders where OrderPrio = "Critical";
-- 2.- ¿Cuáles son los 5 productos más caros?
Select distinct ProdName, UnitPrice from orders order by UnitPrice desc limit 5;
-- 3.- ¿Cuál fue la región con menos órdenes?
Select Region, count(*) as OrdersRegion from orders 
group by Region order by OrdersRegion limit 1;
-- 4.- ¿Quiénes fueron los 3 clientes con más órdenes?
Select CustName, count(*) as OrdersCust from orders 
group by CustName order by OrdersCust desc limit 3;
-- 5.- Cuál fue el método de envío más utilizado?
Select ShipMode, count(*) as OrdersShip from orders 
group by ShipMode order by OrdersShip desc limit 1;
-- 6.- ¿Cuál es el producto con el costo de envío más caro?
Select ProdName, ShipCost from orders
order by ShipCost desc limit 1;
-- 7.- ¿Cuáles clientes se apellidan Simpson?
Select distinct CustName from orders where CustName like '%Simpson';
-- 8.- ¿Cuáles productos son de la marca Belkin?
Select distinct ProdName from orders where ProdName like 'Belkin%';
-- 9.- ¿Cuál es el menor, mayor y promedio de costo de envío?
Select MIN(ShipCost),MAX(ShipCost),AVG(ShipCost) from orders;
-- 10.- ¿Cuántas órdenes generaron pérdidas de la región Sur?
Select count(*) from orders where Profit < 0 AND Region = 'South';
-- 11.- ¿Cuál fue el estado con más ganancias?
Select State, sum(Profit) as StateProfit from orders
group by State order by StateProfit desc limit 1;
-- 12.- ¿Cuales son los 5 pedidos más grandes entre DC y New York?
Select OrderID, QtyOrdered from orders 
where State IN ('New York','District of Columbia') 
order by QtyOrdered desc
limit 5;
-- 13.- ¿Cuál es el nombre del mánager de cada estado? Almacenar como vista
Create View ManagersState AS
Select distinct State, Manager, o.Region 
from Orders o
left join Regions r
on o.Region = r.Region
Order by State asc;
Select * from ManagersState;
-- 14.- ¿Quién es el manager de New York?
Select Region, Manager 
from Regions
Where Region in 
(Select Region from SuperStoreUS.orders 
Where State = 'New York');
-- 15.- ¿Cuántas órdenes hubo de cada Segmento?
Select Sum(Profit) as ProfitFellowes from orders
where ProdName like 'Fellowes%';


