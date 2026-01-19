-- revenue_by_show
SELECT s.show_id, s.title, s.author, s.show_date, 
       SUM(o.qty) AS total_tickets,
       ROUND(SUM(o.qty * o.price),2) AS total_revenue
FROM Shows s
JOIN Orders o ON o.show_id = s.show_id
GROUP BY s.show_id, s.title, s.author, s.show_date
ORDER BY total_revenue DESC;

-- top_customers_by_spend
SELECT c.customer_id, c.first_name, c.last_name, c.city, c.province_state, c.country,
       SUM(o.qty) AS total_tickets,
       ROUND(SUM(o.qty * o.price),2) AS total_spend
FROM Customers c
JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city, c.province_state, c.country
ORDER BY total_spend DESC
LIMIT 10;

-- revenue_by_country
SELECT c.country,
       SUM(o.qty) AS total_tickets,
       ROUND(SUM(o.qty * o.price),2) AS total_revenue
FROM Customers c
JOIN Orders o ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_revenue DESC;

-- orders_detail_with_totals
SELECT o.order_id,
       c.first_name || ' ' || c.last_name AS customer_name,
       s.title AS show_title,
       s.show_date,
       o.qty,
       o.price,
       ROUND(o.qty*o.price,2) AS order_total
FROM Orders o
JOIN Customers c ON c.customer_id = o.customer_id
JOIN Shows s ON s.show_id = o.show_id
ORDER BY o.order_id;

