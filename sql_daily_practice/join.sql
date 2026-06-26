-- using inner join

select c.customer_id, c.customer_name,o.order_id,o.order_date 
from customers c
inner join orders o
on c.customer_id = o.customer_id;

-- using left join

select c.customer_name, o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id


-- multi-table join

SELECT
    c.customer_name,
    p.product_name,
    oi.quantity
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
INNER JOIN products p
    ON oi.product_id = p.product_id;

-- join + aggregation
SELECT
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


-- self_join
SELECT
    e.employee_name,
    m.employee_name AS manager_name
FROM employees e
INNER JOIN employees m
    ON e.manager_id = m.employee_id;


	
	