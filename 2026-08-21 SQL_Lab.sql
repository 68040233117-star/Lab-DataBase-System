--ต้องการข้อมูล เลขที่ใบสั่งซื้อ และยอดเงินจำหน่ายสินค้าในใบสั่งซื้อนั้น
select * from [Order Details]

select
	OrderID,
	ProductID,
	UnitPrice,
	Quantity,
	Discount,
	UnitPrice * Quantity*(1-Discount) as TotalPrice
from [Order Details]
order by TotalPrice
--ต้องการ รหัส ชื่อเต็มพนักงาน(คำนำหน้า ชื่อ นามสกุล) ตำแหน่ง เบอร์โทร ของพนักงาน
select * from Employees

select
	EmployeeID,
	TitleOfCourtesy + FirstName + space(2) + LastName as EmpName,
	Title,
	HomePhone
from Employees
--ต้องการ รหัสสินค้า ราคา จำนวนที่ขายได้ ยอดเงินที่ขายได้ เรียงตามลำดับรหัสสินค้า
select * from [Order Details]

select
	ProductID,
	sum(Quantity) as จำนวนที่ขายได้,
	cast(sum(UnitPrice * Quantity*(1-Discount)) as numeric(10,2)) as ยอดเงินที่ขายได้
from [Order Details]
group by ProductID
order by sum(UnitPrice * Quantity*(1-Discount))

--CAST(5634.6334 as numeric(10,2))

--ต้องการชื่อพนักงาน และ ปีที่เข้าทำงาน
select
	TitleOfCourtesy + FirstName + space(2) + LastName as EmpName,
	year(hiredate) + 543 [ปี พ.ศ. ที่เข้าทำงาน]
from Employees

--แสดงรหัสสินค้า ชื่อสินค้า ราคา และช่วงราคา(สูง ปานกลาง ต่ำ)
Select
	ProductID,
	ProductName,
	UnitPrice,
	case
		when UnitPrice >= 75 then 'High'
		when UnitPrice >= 35 then 'Medium'
		else 'Low'
	end as PriceLevel
from Products
order by UnitPrice

--การ Join ตารางที่มีความสำพันธ์กัน
--Join 2 ตาราง
--ต้องการชื่อสินค้าทั้งหมด และชื่อหมวดหมู่ของสินค้า
select
	Products.ProductName,
	Categories.CategoryName
from Products join Categories
on Products.CategoryID = Categories.CategoryID
--แบบย่อ
select
	ProductName,
	CategoryName,
	c.CategoryID
from Products as p join Categories as c
on p.CategoryID = c.CategoryID

--
select
	ProductName,
	CompanyName as Supplier
from Products as p join Suppliers as s
on p.SupplierID = s.SupplierID
--Order แต่ละรายการเป็นของลูกค้ารายใด
select
    OrderID,
    Convert(varchar,OrderDate,3) as [order date],
    c.CompanyName
from Orders as o join Customers as c
on o.CustomerID = c.CustomerID
order by CompanyName
--convert(varchar, getdate(), 3)

--1.ต้องการชื่อบริษัทขนส่ง และ จำนวนใบสั่งซื้อที่เกี่ยวข้อง
select
	s.CompanyName as ShiperName,
	count(o.OrderID) as TotalOrders
from Orders as o join Shippers as s
on o.ShipVia = s.ShipperID
group by
	s.CompanyName
--2.1.ต้องการชื่อเต็มพนักงาน และจำนวนใบสั่งซื้อที่เกี่ยวข้อง
select
	e.EmployeeID,
	e.TitleOfCourtesy + e.FirstName + space(2) + e.LastName as empName,
	count(o.OrderID) as จำนวนใบสั่งซื้อ
from Employees as e join Orders as o
on e.EmployeeID = o.EmployeeID
group by 
	e.EmployeeID,
	e.TitleOfCourtesy,
	e.FirstName,
	e.LastName
order by
	count(o.OrderID)
--2.2.ชื่อบริษัทลูกค้า ประเทศลูกค้า และจำนวนใบสั่งซื้อที่เกี่ยวข้อง
select
	CompanyName,
	Country,
	count(OrderID) as OrderCount
from Customers as c join Orders o
on c.CustomerID = o.CustomerID
group by
    c.CompanyName, 
    c.Country
order by
	OrderCount
--3.1.
select
	o.OrderID,
	s.CompanyName as Shipper
from Orders as o join Shippers as s
on  o.ShipVia = s.ShipperID
--3.2.
select
	p.ProductID as รหัสสินค้า,
	p.ProductName as ชื่อสินค้า,
	s.CompanyName as ชื่อบริษัท
from Products as p join Shippers as s
on p.SupplierID = s.ShipperID
--4.
select
	c.CategoryID as รหัสหมวดหมู่,
	c.CategoryName as ชื่อหมวดหมู่,
	count(p.ProductID) as จำนวนสินค้า
from Categories as c join Products as p
on c.CategoryID = p.CategoryID
group by
	c.CategoryID,
	c.CategoryName

--Join 3 ตาราง
--ต้องการหมายเลขใบสั่งซื้อ วันที่สั่งซื้อ บริษัทลูกค้า ชื่อสกุลพนักงงานผู้ขาย
select
	orderID,
	Convert(varchar,OrderDate,3) as [order date],
	c.CompanyName,
	e.FirstName + space (2) + e.LastName as EmpName
from Orders as o
			inner join Customers as c on o.CustomerID = c.CustomerID
			inner join Employees as e on o.EmployeeID = e.EmployeeID

--ต้องการรหัสสินค้า ชื่อสินค้า ราคาต่อหน่วย ชื่อหมวดหมู่ ชื่อบริษัทผู้จำหน่าย
select
	ProductID,
	ProductName,
	UnitPrice,
	CategoryName,
	CompanyName
from Products as p
		inner join Categories as c on p.CategoryID = c.CategoryID
		inner join Suppliers as s  on p.SupplierID = s.SupplierID

--ต้องการ รหัสหมวดหมู่ ชื่อหมวดหมู่ ยอดขายทั้งหมดในหมวดหมู่ แสดงเฉพาะยอดขายสูงสุด 3 อันดับ
select top 3
	c.CategoryID,
	c.CategoryName,
	cast(sum(od.UnitPrice * Quantity*(1-Discount)) as numeric(10,2)) as TotalPrice
from Categories as c
		join Products as p			on c.CategoryID = p.CategoryID
		join [Order Details] as od  on p.ProductID  = od.ProductID
group by
	c.CategoryID,
	c.CategoryName
order by
	sum(od.UnitPrice * Quantity*(1-Discount)) desc

--Join 4 ตาราง ในแต่ละรายการสินค้า มีบริษัทลูกค้าใดซื้อสินค้า ซื้ออะไร จำนวน และมียอดขายเท่าใด
select
	o.OrderID,
	c.CompanyName,
	p.ProductName,
	od.Quantity,
	od.UnitPrice * Quantity * (1-Discount) as TotalSale
from Orders as o
		join Customers as c			on o.CustomerID = c.CustomerID
		join [Order Details] as od  on o.OrderID = od.OrderID
		join Products as p			on p.ProductID = od.ProductID

--ลูกค้าบริษัทใด มีการซื้อสินค้าที่มาจากประเทศ USA บ้าง
select
	c.CompanyName
from Customers c
		join Orders o			on c.CustomerID = o.CustomerID
		join [Order Details] od on o.OrderID = od.OrderID
		join Products p			on p.ProductID = od.ProductID
		join Suppliers s		on p.SupplierID = s.SupplierID
where s.Country = 'USA'
group by
	c.CompanyName

select * from Suppliers

select * from Customers
