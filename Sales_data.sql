show databases;
use superstore;
show tables;
desc retail_sales;
	select count(*) from retail_sales;
	select * from retail_sales limit 10;
#total sales per region 
	select region ,sum(sales) as total_sales
	from retail_sales
	group by region
	order by total_sales desc;

use superstore;
ALTER TABLE retail_sales 
CHANGE `Product Name` product_name VARCHAR(255);

#1 top 5 best selling products
	SELECT product_name, SUM(sales) AS total_sales
	FROM retail_sales
	GROUP BY product_name
	ORDER BY total_sales DESC
	LIMIT 5;

ALTER TABLE retail_sales 
	CHANGE `Order Date` order_date TEXT;
	UPDATE retail_sales
	SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y')
	WHERE order_date IS NOT NULL;


# 2 Monthly Revenue
SELECT 
    DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%Y'), '%Y-%m') AS month,
    SUM(sales) AS total_monthly_sales
	FROM retail_sales
	GROUP BY month
	ORDER BY month;

#alter column name
ALTER TABLE retail_sales
CHANGE `Customer ID` customer_id VARCHAR(255);
ALTER TABLE retail_sales
CHANGE `Customer Name` customer_name VARCHAR(255);

#4 Identify repeat customers
	select customer_id ,customer_name ,count(*) As total_orders
	from retail_sales
	group by customer_id, customer_name 
	having count(*) >1
	order by total_orders desc;

use superstore;

#5 Average order value per region
	SELECT region,
		   AVG(sales) AS avg_order_value
	FROM retail_sales
	GROUP BY region;

#6 Peak sales hour
 select * from  retail_Sales;
	 select hour(order_date) As hour,
	 sum(sales) as total_Sales
	 from retail_Sales
	 group by hour
	 order by total_Sales desc;
 
 # 7 peak sales day 
	 SELECT order_date, SUM(sales) AS total_sales
	FROM retail_sales
	GROUP BY order_date
	ORDER BY total_sales DESC;

#6 Rank products by sales within each category

SELECT 
    category,
    product_name,
    SUM(sales) AS total_sales,
    RANK() OVER (PARTITION BY category ORDER BY SUM(sales) DESC) AS product_rank
	FROM retail_sales
	GROUP BY category, product_name; 




