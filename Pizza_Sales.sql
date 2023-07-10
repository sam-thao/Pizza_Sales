A KPI

-- Total Revenue

SELECT SUM(total_price)  AS Total_Revenue
FROM pizza_sales

-- Average Order Value

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales

-- Total Pizza Sold

SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales

-- Total Orders

SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales

-- Average Pizzas Per Order

SELECT CAST(CAST(SUM(quantity) AS decimal(10,2)) /
CAST(COUNT(DISTINCT order_id) AS decimal(10,2)) AS decimal(10,2)) AS Avg_Pizza_Per_Order
FROM pizza_sales

-- Daily Trend for Total Orders

SELECT DATENAME(DW, order_date) AS order_day, COUNT(distinct order_id) as Total_Orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Hourly Trend For Orders
-- 9am to 11pm

SELECT DATEPART(HOUR, order_time) as order_hours, COUNT(DISTINCT order_id) as Total_Orders
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

-- Percent Sales by Pizza Category

SELECT pizza_category, SUM(total_price) AS  Total_Sales, SUM(total_price) * 100  / (SELECT sum(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category


SELECT pizza_category, SUM(total_price) AS  Total_Sales, SUM(total_price) * 100  / (SELECT sum(total_price) FROM pizza_sales 
WHERE MONTH(order_date) = 1 ) AS PCT -- add where clause here also
FROM pizza_sales
WHERE MONTH(order_date) = 1 --January
GROUP BY pizza_category

-- Percent Sales by Pizza Size

SELECT pizza_size, 
CAST(SUM(total_price)  AS decimal(10,2)) AS  Total_Sales,
CAST(SUM(total_price) * 100  / (SELECT sum(total_price) FROM pizza_sales) AS decimal(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC

SELECT pizza_size, 
CAST(SUM(total_price)  AS decimal(10,2)) AS  Total_Sales,
CAST(SUM(total_price) * 100  / (SELECT sum(total_price) FROM pizza_sales WHERE DATEPART(QUARTER, order_date) = 1) AS decimal(10,2)) AS PCT
FROM pizza_sales
WHERE DATEPART(QUARTER, order_date) = 1 -- For 1st Quarter
GROUP BY pizza_size
ORDER BY PCT DESC

-- Total Pizzas Sold by Pizza Category

SELECT pizza_category, sum(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_category

-- Top 5 Best Sellers By Total Pizzas Sold

SELECT TOP 5 pizza_name, sum(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold DESC

-- Bottom 5 Worst Pizza Sold

SELECT TOP 5 pizza_name, sum(quantity) as total_pizzas_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_pizzas_sold 

SELECT TOP 5 pizza_name, sum(quantity) as total_pizzas_sold
FROM pizza_sales
WHERE MONTH(order_date) = 1 -- January
GROUP BY pizza_name
ORDER BY total_pizzas_sold 