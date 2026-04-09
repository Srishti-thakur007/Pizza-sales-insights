create database pizza_db;
use pizza_db;

select*from pizza_sales;

#1. Get total money earned from all Pizza sales:
CREATE VIEW TOTAL_REVENUE_FROM_PIZZA AS
SELECT SUM(TOTAL_PRICE) AS TOTAL_REVENUE
FROM PIZZA_SALES;

SELECT *FROM TOTAL_REVENUE_FROM_PIZZA;

#2.Get how many unique orders were placed:
CREATE VIEW TOTAL_ORDER AS
SELECT COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDER
FROM PIZZA_SALES;

SELECT*FROM TOTAL_ORDER;

#3.Get total number of pizza sold:
CREATE VIEW TOTAL_PIZZAS_SOLD AS
SELECT SUM(QUANTITY) AS TOTAL_PIZZAS_SOLD
FROM PIZZA_SALES;

SELECT*FROM TOTAL_PIZZAS_SOLD;

#4.Get how many orders were placed each day:
CREATE VIEW ORDERS_PLACED_EACH_DAY AS
SELECT ORDER_DATE, COUNT(DISTINCT ORDER_ID) AS ORDERS_PLACED_EACH_DAY
FROM PIZZA_SALES
GROUP BY ORDER_DATE
ORDER BY ORDER_DATE;

SELECT*FROM ORDERS_PLACED_EACH_DAY;

#5.Get top 5 pizzas based on highest quantity sold:
CREATE VIEW HIGHEST_QUANTITY AS
SELECT PIZZA_NAME, SUM(QUANTITY)AS HIGHEST_QUANTITY
FROM PIZZA_SALES
GROUP BY PIZZA_NAME
ORDER BY HIGHEST_QUANTITY DESC
LIMIT 5;

SELECT*FROM HIGHEST_QUANTITY;

#6. Get total revenue for each pizza category:
CREATE VIEW REVENUE_FROM_EACH_PIZZA AS
SELECT PIZZA_CATEGORY, SUM(TOTAL_PRICE) AS REVENUE_FROM_EACH_PIZZA
FROM PIZZA_SALES
GROUP BY PIZZA_CATEGORY;

SELECT*FROM REVENUE_FROM_EACH_PIZZA;

#7. Get average money spent per order
create view avg_order_value as
select sum(total_price) / count(distinct order_id) as avg_order_value
from pizza_sales;

select*from avg_order_value;

#8.Get which hour has highest number of orders
CREATE VIEW TOTAL_ORDERS_VIEW AS
SELECT EXTRACT(HOUR FROM ORDER_TIME) AS HOUR,
COUNT(DISTINCT ORDER_ID) AS TOTAL_ORDERS_VIEW
FROM PIZZA_SALES
GROUP BY hour
ORDER BY TOTAL_ORDERS_VIEW DESC;

SELECT*FROM TOTAL_ORDERS_VIEW;

#9.Get orders where customers bought 5 or more items:
CREATE VIEW TOTAL_ITEMS AS
SELECT ORDER_ID, COUNT(*) AS TOTAL_ITEMS
FROM PIZZA_SALES
GROUP BY ORDER_ID
HAVING COUNT(*) >= 5;

SELECT*FROM TOTAL_ITEMS;

#10.Get how revenue changes day by day 
CREATE VIEW REVENUE_TREND AS
SELECT ORDER_DATE, SUM(TOTAL_PRICE) AS REVENUE_TREND
FROM PIZZA_SALES
GROUP BY ORDER_DATE
ORDER BY ORDER_DATE;

SELECT*FROM REVENUE_TREND;

#11. Get percentage contribution of each pizza category of each sales:
create view category_sales_percentage as
select pizza_category,
sum(total_price) as category_revenue,
round(
( sum(total_price) / (select sum(total_price)from pizza_sales)) * 100,
2
)AS percentage_sales
from pizza_sales
group by pizza_category;

select*from category_sales_percentage;

#12.Get percentage contribution of each pizza size in total sales:
create view pizza_size_percentage as
select pizza_size,
sum(total_price) AS size_revenue,
ROUND(
( sum(total_price) / (select sum(total_price)from pizza_sales)) *100,
2
) AS percentage_sales
from pizza_sales
group by pizza_size;

select*from pizza_size_percentage;

#13.get bottom 5 worst selling pizzas:
create view bottom_5_pizzas as
select pizza_name,
sum(quantity) as lowest_quantity
from pizza_sales
group by pizza_name
order by lowest_quantity asc
limit 5;

select*from bottom_5_pizzas;
