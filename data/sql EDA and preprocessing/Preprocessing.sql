

-- **********************************************


select * from (
select *,
case 
-- convert USD to INR
when t.currency in ('USD','USD\r') then t.sales_amount*75 
else t.sales_amount
end as sales_amount_filtered,
-- END of first preprocesing
-- ********************
-- adding row_num to show duplicates then selecting none duplicants row_num >1

row_number() over(
partition by t.product_code, t.customer_code, t.market_code, t.order_date, t.sales_qty,
t.sales_amount
order by  t.product_code
) as row_num
-- **** end of second preprocessing
from sales.transactions as t
-- ******************
-- selecting only amount > 0, since we have 0 and -1
where t.sales_amount > 0)  as New_Table
where New_Table.row_num = 1
 /*
 now can render it to csv and import it to power bi or save as new table in sql
 or take the to power bi
*/


