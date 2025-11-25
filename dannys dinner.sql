create schema dannys_diner;
set search_path = dannys_diner;

CREATE TABLE sales (
    `customer_id` VARCHAR(1),
    `order_date` DATE,
    `product_id` INTEGER
);


INSERT INTO sales
  (customer_id, order_date, product_id)
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
  
  create table menu (
  `product_id` integer,
  `product_name` varchar(5),
  `prices` integer
  );
  
  insert into menu
  (`product_id`,`product_name`,`prices`)
  values
  (1,'sushi',10),
  (2,'curry',15),
  (3,'ramen',12);
  
  create table members (
  `customer_id` varchar (1),
  `Join_date` date
  );
  
  insert into members
  (`customer_id`,`Join_date`)
VALUES
  ('A', '2021-01-07'),
  ('B', '2021-01-09');
  
  # What is the total amount each customer spent at the restaurant?
select
customer_id,sum(prices) amount_spent
from sales
left join menu
on sales.product_id = menu.product_id
group by customer_id;

# 2. How many days has each customer visited the restaurant?
select 
customer_id,count(distinct(order_date)) no_of_visits
from sales
group by customer_id;

# 3.What was the first item from the menu purchased by each customer?
SELECT customer_id, product_name, order_date
FROM sales
LEFT JOIN menu 
  ON sales.product_id = menu.product_id
WHERE order_date = '2021-01-01' 
GROUP BY customer_id,product_name,order_date;

# 4.What is the most purchased item on the menu and how many times was it purchased by all customers?
select
product_name, count(product_name) times_purchased
from sales
left join menu
on sales.product_id = menu.product_id
group by product_name
order by times_purchased desc
limit 1;

# 5.Which item was the most popular for each customer?
select customer_id,product_name,count(product_name) times_purchased
from sales
left join menu
on sales.product_id = menu.product_id
group by customer_id, product_name
order by times_purchased desc;

# 6.Which item was purchased first by the customer after they became a member?
-- Customer A
select customer_id,order_date,product_name
from sales
left join menu
on sales.product_id = menu.product_id
where customer_id = 'A' and order_date > '2021-01-07'-- date after membership
order by order_date
limit 1;

-- Customer B
select customer_id,order_date,product_name
from sales
left join menu
on sales.product_id = menu.product_id
where customer_id = 'B' and order_date > '2021-01-09'-- date after membership
order by order_date
limit 1;

# 7. Which item was purchased just before the customer became a member?
-- Customer A
SELECT 
    customer_id, order_date, product_name
FROM
    sales
        LEFT JOIN
    menu ON sales.product_id = menu.product_id
WHERE
    customer_id = 'A'
        AND order_date < '2021-01-07'
ORDER BY order_date DESC;

-- Customer B
select customer_id,order_date,product_name
from sales
left join menu
on sales.product_id = menu.product_id
where customer_id  = 'B' and order_date < '2021-01-09'
order by order_date desc;

# 8.What is the total items and amount spent for each member before they became a member?
-- Customer A
select customer_id, order_date, count(product_name) total_items, sum(prices) amount_spent
from sales
left join menu
on sales.product_id = menu.product_id
where customer_id = 'A' and order_date < '2021-01-07'
group by customer_id ,order_date
order by order_date;

-- Customer B
select customer_id, order_date, count(product_name) total_items, sum(prices) amount_spent
from sales
left join menu
on sales.product_id = menu.product_id
where customer_id = 'B' and order_date < '2021-01-09'
group by customer_id ,order_date
order by order_date;

# 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
select customer_id,
sum(case
when product_name = 'sushi' then 20 * prices
else 10 * prices
end) total_points
from sales
left join menu
on sales.product_id = menu.product_id
group by customer_id;

# 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT
  m.customer_id,
  SUM(
    CASE
      -- If the sale is in the first week (including join date)
      WHEN s.order_date BETWEEN m.join_date AND DATE_ADD(m.join_date, INTERVAL 6 DAY)
      THEN 2 * (mn.prices * 10)  -- double points: normal points = price*10
      ELSE (mn.prices * 10)      -- normal points
    END
  ) AS total_points
FROM members m
JOIN sales s
  ON s.customer_id = m.customer_id
JOIN menu mn
  ON s.product_id = mn.product_id
WHERE s.order_date BETWEEN '2021-01-01' AND '2021-01-31'
  AND m.customer_id IN ('A', 'B')
GROUP BY m.customer_id;
