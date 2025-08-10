SELECT *
from online_retail;

-- * Standardize the date
-- * Deleting rows with cancelled orders
-- * Standardize CustomerID
-- * Checking for duplicates
-- * Checking for null
-- * Deleting unnecessary column


-- COnverting InvoiceDate to date format
 
select cast(InvoiceDate as date)
from online_retail;

update online_retail
set InvoiceDate = cast(InvoiceDate as date);

alter table online_retail
modify InvoiceDate date;

-- Checking for cancelled orders

select count(*)
from online_retail 
where InvoiceNo like('C%');

-- 4320 orders were cancelled , deleting those rows
delete from online_retail
where InvoiceNo like('C%');


-- Standardize customerId

select CustomerID, left(CustomerID, 5)
from online_retail;

Update online_retail
set CustomerID = left(CustomerID, 5);


-- Checking for null values

select *
from online_retail
where CustomerID is null
or InvoiceNo is null
or StockCode is null
or `Description` is null
or Quantity is null
or InvoiceDate is null
or UnitPrice is null
or Country is null;    -- NO null values found

-- Checking for Duplicate Values

with cte as
(
select *, 
row_number()over(partition by InvoiceNo, StockCode, `Description`, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as rank_num
from online_retail
) select *
from cte where rank_num > 1;



CREATE TABLE `online_retail2` (
  `InvoiceNo` varchar(10) DEFAULT NULL,
  `StockCode` varchar(20) DEFAULT NULL,
  `Description` text,
  `Quantity` int DEFAULT NULL,
  `InvoiceDate` date DEFAULT NULL,
  `UnitPrice` decimal(10,3) DEFAULT NULL,
  `CustomerID` varchar(10) DEFAULT NULL,
  `Country` varchar(50) DEFAULT NULL,
  `rank_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from online_retail2;

insert into online_retail2
select *, 
row_number()over(partition by InvoiceNo, StockCode, `Description`, Quantity, InvoiceDate, UnitPrice, CustomerID, Country) as rank_num
from online_retail;

delete 
from online_retail2
where rank_num >1;

-- Removing unnecessary columns

alter table online_retail2
drop column rank_num;

select `Description`, trim(`Description`)
from online_retail2;

update online_retail2
set `Description` = trim(`Description`);

