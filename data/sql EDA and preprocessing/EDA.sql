use sales;

select * ,
row_number() over (partition by t.product_code , t.customer_code, t.market_code,t.order_date , t.sales_qty,t.sales_amount) as row_num
from sales.transactions as t
order by t.product_code
------------
-- counting of duplicates
with dup as (

select * ,
row_number() over (partition by t.product_code , 
t.customer_code, t.market_code,t.order_date , 
t.sales_qty,t.sales_amount
order by t.product_code
) as row_num
from sales.transactions as t
)
select count(row_num) from dup
where row_num  >1
----------
-- 281 duplicated records
-------
-- showing distinct currency 
select distinct (t.currency) from sales.transactions as t;


select count(*) from sales.transactions as t
where t.currency =  'INR' ;
-- 279
select count(*) from sales.transactions as t
where t.currency =  'USD' ;
-- 2 
-- ** these are the duplicated values
-- ********************
-- 'INR' the duplicated values 
-- 'INR\r' none duplicants
---------------
-- count of distict values
select count(*) from sales.transactions 
where transactions.currency  in ('INR\r', 'USD\r');
-----------------

select min(t.sales_amount) from sales.transactions as t ;

select t.sales_amount from sales.transactions as t 
order by t.sales_amount asc
limit 5;
-- sales_amount column has negative and zero, so they must be eliminated

-- date TABLE
use sales;
select * from date 
where date.date is null




