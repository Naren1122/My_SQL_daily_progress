select c.customer_name,
sum(o.amount) as total_spent
from customers c
join orders o 
on c.customer_id = o.customer_id
group by c.customer_name;

select avg(total_spent)
from(
select 
customer_id,
sum(amount) AS total_spent
from orders
group by customer_id
) t


select 
product_id
product_name
from products
where product_id in (
select product_id
from order_items
);


SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > (
    SELECT AVG(total_orders)
    FROM (
        SELECT
            customer_id,
            COUNT(*) AS total_orders
        FROM orders
        GROUP BY customer_id
    ) t
);


WITH customer_spending AS (
    SELECT
        c.customer_name,
        SUM(o.amount) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name
)
SELECT
    customer_name,
    total_spent
FROM customer_spending
WHERE total_spent > 500;


WITH product_sales AS (
    SELECT
        p.product_name,
        SUM(oi.quantity) AS total_quantity
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.product_name
)
SELECT
    product_name,
    total_quantity
FROM product_sales
ORDER BY total_quantity DESC
LIMIT 1;


now 

