select * from Employees
select * from Categories
select * from Products
select * from Receipts
select * from Details
--คำสั่งตรวจชื่อตารางในฐานข้อมูลที่ใช้อยู่
select * from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'BASE TABLE';
--คำสั่งตรวจตาราง products
exec sp_help 'dbo.products'
--ใช้  Distinct สำหรับลดการแสดงข้อมูลที่สำคัญ
Select Distinct position from Employees
-----------------------
select
	ProductID,
	ProductName,
	UnitPrice
From Products;
--ตั้งชื่อเล่นคอลัมน์ Alias Name
select
	ProductName AS ชื่อสินค้า,
	UnitPrice AS ราคา
from Products;
--Top(5) ใช้สำหรับเลือกข้อมูล 5 รายการแรก
select top (5)
	ProductID,
	ProductName,
	UnitPrice
from Products;
--Update การแก้ไขข้อมูลในตารางให้สินค้า
Update Products
set UnitPrice = 12
where ProductID = 1
-------------------
Update Products
set UnitPrice = 15
where ProductName = 'ดินสอ'
--ปรับปรุงราคายางลบให้มีราคา 10 บาท และมีจำนวนคงเหลือ 250
Update Products
Set
	UnitPrice = 10,
	UnitsInStock = 250
where ProductName = 'ยางลบ'
--ปรับปรุงจำนวนคงเหลือของดินเพิ่มขึ้น 100 ชิ้น
Update Products
set UnitsInStock = UnitsInStock+100
where ProductName = 'ดินสอ'
--ขึ้นราคาสินค้า 5% ทุกรายการ
Update Products
set UnitPrice = UnitPrice * 0.05
--
select * from Products
--ต้องการลบสินค้ารหัส 3
Delete from Products where ProductID = 3
--select (การใช้ where)
Select
	ProductID,
	ProductName,
	UnitPrice
from Products
where UnitPrice < 20;
--ต้องการ ชื่อ นามสกุล พนักงานที่เป็น Sale Menager
select firstname, lastname from Employees
where position = 'Sale manager'
--ต้องการ รหัสสินค้า ของ ชาเขียว
select ProductID
from Products
where ProductName = 'ชาเขียว'
--ข้อมูลสินค้าที่มีจำนวนในสต๊อก ต่ำกว่า 400
Select * from Products
where UnitsInStock < 400;
--ข้อมูลสินค้าที่รหัสหมวดหมู่ 1 และราคาไม่เกิน 20
select * from Products
where CategoryID = 1 and UnitPrice <= 20
--ข้อมูลสินค้าที่รหัสหมวดหมู่ 1 หรือ ราคาไม่เกิน 20
select * from Products
where CategoryID = 1 or UnitPrice <= 20
----------------------------------
SELECT * FROM Products
WHERE NOT Discontinued = 1;
----------------------------------
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
WHERE UnitPrice BETWEEN 10 AND 20;
----------------------------------
SELECT
    ProductID,
    ProductName,
    CategoryID
FROM dbo.Products
WHERE CategoryID IN (1, 2, 4);
--ข้อมูลสินค้าที่มีชื่อขึ้นต้นด้วยคำว่า น้ำ
SELECT
    ProductID,
    ProductName
FROM dbo.Products
WHERE ProductName LIKE N'น้ำ%';
--ชื่อ นามสกุลพนักงานที่มีนามสกุลลงท้ายด้วย "คำ"
SELECT firstname, lastname from Employees
WHERE LastName like '%คำ'
--ชื่อสินค้า ราคา สินค้าที่มีคำว่า ส้ม
select ProductName, UnitPrice from Products
where ProductName like '%ส้ม%'
--wildcard คืออะไร??

--เตรียมข้อมูลที่มีค่า Null
Insert into Employees(FirstName, LastName, UserName, Password)
values ('กาณฑ์', '', 'Karn', '1234')
select * from Employees
--ต้องการข้อมูลชองพนักงานที่ยังไม่ทราบนามสกุล
select * from Employees
where LastName is null or LastName = ''
--ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ทุกคน และอยู่ในช่องเดียวกัน
select Title + firstName + ' ' + LastName AS ชื่อนามสกุลพนักงาน from Employees
--------------------------------
select firstName + ' ' + LastName AS ชื่อนามสกุลพนักงาน from Employees
--------------------------------
--กรณีเป็นวันที่
select * from Receipts
where Receiptdate = '2013/02/10' --ตรงตามวันที่ระบุ

select * from Receipts
where Receiptdate < '2013-02-10' --ก่อนวันที่ระบุ

select * from Receipts
where Receiptdate >= '20130210' --ตั้งแต่วันที่ระบุ

select * from Receipts
where ReceiptDate between '2013-02-01' and '2013-02-07'
--ใช้ Function Year(), Month() มาช่วยในเงื่อนไข
select * from Receipts
where year(ReceiptDate) = 2013 -- ปี 2013 ทั้งหมด

select * from Receipts
where year(ReceiptDate) = 2013 and month(ReceiptDate) = 2 -- ปี 2013 ทั้งหมด

--Asscending(ASC) น้อยไปมาก
--Descending(DESC) มากไปน้อย

--Order by ใช้สำหรับเรียง จะใส่ต่อท้ายสุดของคำสั่ง SQL
--รหัสสินค้า ชื่อสินค้า ราคา จำนวนคงเหลือ เรียงตาม ....
Select ProductID, ProductName, UnitPrice, UnitsInStock 
from Products
order by UnitPrice desc

Select ProductID, ProductName, UnitPrice, UnitsInStock 
from Products
order by ProductName asc

select * from Products
order by CategoryID, UnitPrice

select top (3) * from Products
order by UnitsInStock desc

