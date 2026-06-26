select count(*) as total_customers
from customers;

select count(customer_id) from customers;
select sum(amount) as total_revenue from orders;

select c.customer_name,
sum(o.amount) as total_spent
from customers c 
 join orders o
on c.customer_id = o.customer_id
group by c.customer_name;

select c.customer_name ,
avg(o.amount) as avg_order_amount
FROM customers c
 join orders o
 on c.customer_id = o.customer_id
 group by c.customer_name;


 select c.customer_name,
 sum(o.amount) as total_spent
 from customers c
 join orders o
 on c.customer_id = o.customer_id
 group by customer_name
 having sum(o.amount) > 500;


select c.customer_name,
count(distinct p.product_id) as unique_products
from customers c
join orders o
on c.customer_id = o.customer_id
join order_items oi
on o.order_items = oi.order_items
join products p
on oi.product_id = p.product_id
group by c.customer_name;


select c.customer_name,
sum(o.amount) as total_spent
from customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_name
order by total_spent desc

select customer_name,
total_spent,
case
when total_spent > 700 then 'high spender'
when total_spent between 300 and 700 then 'medium spender'
else 'low spender'

from (
c.customer_name,
SUM(o.amount) as total_spent
from  customers c
join orders o
on c.customer_id = o.customer_id
group by c.customer_name
) t;
