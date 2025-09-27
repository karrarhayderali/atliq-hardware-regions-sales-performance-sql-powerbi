use sales;
select * from products;
select * from date;
select count(*) from transactions;

SELECT year, product_code, sa
FROM (
    SELECT 
        d.year,
        t.product_code,
        SUM(t.sales_amount) AS sa,
        ROW_NUMBER() OVER (PARTITION BY d.year ORDER BY SUM(t.sales_amount) DESC) AS rn
    FROM sales.transactions AS t
    JOIN sales.products AS p ON p.product_code = t.product_code
    JOIN sales.date AS d ON d.date = t.order_date
    GROUP BY d.year, t.product_code
) AS ranked
WHERE rn <= 5
ORDER BY year, sa DESC;
