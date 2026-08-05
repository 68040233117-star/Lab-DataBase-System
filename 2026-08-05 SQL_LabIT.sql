--ข้อ 1.ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ที่อยู่ในเมือง London
select
	TitleOfCourtesy,
	FirstName,
	LastName,
	City
from employees
where City = 'London'
order by FirstName

--ข้อ 2.ข้อมูล รหัสสินค้า ชื่อสินค้า ราคา จำนวน ของสินค้าที่มีจำนวนน้อยกว่า 30
select 
	ProductID,
	ProductName,
	UnitPrice,
	UnitsInStock
from Products
where UnitsInStock < 30
order by UnitsInStock

--ข้อ 3.รหัสลูกค้า ชื่อบริษัท เบอร์โทรศัพท์ ของลูกค้าที่อยู่ในประเทศ Sweden, Germany, France, Spain, UK
select
	CustomerID,
	CompanyName,
	Phone,
	Country
from Customers
where Country in ('Sweden', 'Germany', 'France', 'Spain', 'UK');

--ข้อ 4.ข้อมูลลูกค้าที่ไม่มีหมายเลขโทรสาร
select * from Customers
where Fax is null

--ข้อ 5.ข้อมูลสินค้าที่มีจำนวนสินค้าน้อยกว่าจุดสั่งซื้อ และ มีจำนวนที่สั่งซื้อแล้ว
select * from Products
where UnitsInStock < ReorderLevel and UnitsOnOrder > 0

--ข้อ 6. ชื่อ นามสกุล พนักงานที่เข้าทำงานในปี 1993
select
	FirstName,
	LastName
from Employees
where year (HireDate) = 1993

--ข้อ 7.ต้องการข้อมูลจำนวนสินค้าที่มีราคาตั้งแต่ 50-100
select * from Products
where UnitPrice between 50 and 100

--ข้อ 8.ต้องการข้อมูลลูกค้าที่มีชื่อบริษัทขึ้นต้นด้วย M
select * from Customers
where CompanyName like 'M%'

--ข้อ 9.ข้อมูลลูกค้าที่มีตำแหน่งของผู้ที่ประสานงานเป็น Manager
select * from Customers
where ContactTitle like '%Manager%'











-- เปลี่ยนไปใช้ Minimart --
--ต้องการจำนวนสินค้า, ราคาเฉลี่ย, ราคาสูงสุด, ราคาต่ำสุด, จำนวนสินค้ารวมทั้งหมด
select Count(*) as จำนวน,
	AVG(UnitPrice) as ราคาเฉลี่ย,
	Max(UnitPrice) as ราคาสูงสุด,
	Min(UnitPrice) as ราคาต่ำสุด,
	Sum(UnitsInStock) as จำนวนสินค้าทั้งหมด
from Products
where CategoryID = 1

select * from Products
-------------------------------------------------
--สินค้าแต่ละหมวดหมู่มีจำนวนกี่ชนิด
SELECT
    CategoryID,
    COUNT(*) AS ProductCount
FROM dbo.Products
GROUP BY CategoryID;

--ใบเสร็จแต่ละใบมียอดเงินรวมเท่าใด
SELECT
    ReceiptID,
    SUM(UnitPrice * Quantity) AS ReceiptTotal
FROM dbo.Details
GROUP BY ReceiptID;

--สินค้าแต่ละหมวดหมู่มีจำนวนกี่ชิ้น ต้องการเฉพาะหมวดหมู่ที่มีมากกว่า 2 ชนิดสินค้า
select 
	CategoryID,count(*) as จำนวน 
from Products
group by CategoryID
having count(*) > 2

--ใบเสร็จแต่ละใบ มียอดเงินรวมเท่าใด ต้องการเฉพาะยอดเงินในใบเสร็จ ต่ำกว่า 100
SELECT
    ReceiptID,
    SUM(UnitPrice * Quantity) AS ReceiptTotal
FROM dbo.Details
GROUP BY ReceiptID
having SUM(UnitPrice * Quantity) < 100





--โจทย์ทดลอง Group by และ Having ใน Northwind
--แสดงชื่อประเทศของลูกค้า และจำนวนลูกค้าในแต่ละประเทศ แสดงเฉพาะประเทศที่มีจำนวนลูกค้า มากกว่า 3 ราย
select * from Customers

select
	Country,
	count(*) as จำนวนลูกค้า
from Customers
group by Country
having count(*) > 3
order by count(*) desc

--แสดงเลขที่ใบเสร็จ และจำนวนรายการที่ขายในแต่ละใบเสร็จ แสดงเฉพาะใบเสร็จที่มี 1 รายการขาย(order details)
select top 5
	OrderID,
	count(*) as จำนวนรายการ
from [Order Details]
group by OrderID
having count(*) = 1
order by count(*) desc

--รหัสหมวดหมู่สินค้า ราคาเฉลี่ย ราคาสูงสุด ราคาต่ำสุด เฉพาะสินค้าที่มีผู้จำหน่ายรหัส 1-10
--แสดงเฉพาะสินค้าที่มีราคาเฉลี่ยต่ำกว่า 20
select
	CategoryID,
	avg(UnitPrice) as ราคาเฉลี่ย,
	Max(UnitPrice) as ราคาสูงสุด,
	Min(UnitPrice) as ราคาต่ำสุด
from Products
where SupplierID < 10
group by CategoryID
having avg(UnitPrice) < 20

--จากตาราง Orders ต้องการรหัสพนักงาน และ จำนวนใบเสร็จที่รับผิดชอบ เฉพาะรายการที่เกิดขึ้นในปี 1997
--เลือกมาเฉพาะรายการที่ส่งสินค้าไปประเทศ USA
--ให้เลือกเฉพาะหนังงานที่ขายได้ตั้งแต่ 10 รายการขึ้นไป
select * from Orders

select 
	EmployeeID,
	count(*) as จำนวนใบเสร็จ
from Orders
where year (OrderDate) = 1997 and ShipCountry = 'USA'
group by EmployeeID
having count(*) >= 10