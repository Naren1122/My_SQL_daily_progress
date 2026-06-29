SELECT
    c.customer_name,
    SUM(o.amount) AS total_amount
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) >
(
    SELECT AVG(customer_total)
    FROM
    (
        SELECT SUM(amount) AS customer_total
        FROM orders
        GROUP BY customer_id
    ) t
);




WITH customer_totals AS
(
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT
    c.customer_name,
    COALESCE(ct.total_spent, 0) AS total_spent
FROM customers c
LEFT JOIN customer_totals ct
ON c.customer_id = ct.customer_id;



SELECT
    o1.order_id,
    o1.customer_id,
    o1.amount
FROM orders o1
WHERE o1.amount >
(
    SELECT AVG(o2.amount)
    FROM orders o2
    WHERE o2.customer_id = o1.customer_id
);




WITH customer_totals AS
(
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
)

SELECT
    c.customer_name,
    ct.total_spent
FROM customer_totals ct
JOIN customers c
ON ct.customer_id = c.customer_id
WHERE ct.total_spent =
(
    SELECT MAX(total_spent)
    FROM customer_totals
);




SELECT
    c.customer_name
FROM customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
);





WITH product_sales AS
(
    SELECT
        product_id,
        SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY product_id
),

max_sales AS
(
    SELECT MAX(total_quantity) AS highest_quantity
    FROM product_sales
)

SELECT
    p.product_name,
    ps.total_quantity
FROM product_sales ps
JOIN products p
ON ps.product_id = p.product_id
JOIN max_sales ms
ON ps.total_quantity = ms.highest_quantity;





WITH customer_spending AS
(
    SELECT
        customer_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
),

customer_items AS
(
    SELECT
        o.customer_id,
        SUM(oi.quantity) AS total_items
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)

SELECT
    c.customer_name,
    COALESCE(cs.total_spent, 0) AS total_spent,
    COALESCE(ci.total_items, 0) AS total_items
FROM customers c
LEFT JOIN customer_spending cs
ON c.customer_id = cs.customer_id
LEFT JOIN customer_items ci
ON c.customer_id = ci.customer_id;




WITH customer_quantities AS
(
    SELECT
        o.customer_id,
        SUM(oi.quantity) AS total_quantity
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY o.customer_id
)

SELECT
    c.customer_name,
    cq.total_quantity
FROM customer_quantities cq
JOIN customers c
ON cq.customer_id = c.customer_id
WHERE cq.total_quantity =
(
    SELECT MAX(total_quantity)
    FROM customer_quantities
);



