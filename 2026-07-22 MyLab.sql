select * from Categories
select * from Employees
select * from Products
select * from Receipts
select * from Details
------------------------
CREATE TABLE Customers (
    CustomerID VARCHAR(13) PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE
)
------------------------
Insert into Customers
    (CustomerID, CustomerName, PhoneNumber)
values
    ('1749700140222', 'เตวิช แสนโบราณ', '0809455824')
------------------------
Insert into Customers
    (CustomerID, CustomerName, PhoneNumber)
values
    ('1749700140999', 'กาณฑ์', '0909992894')
------------------------
select * from Customers
------------------------
drop table Customers