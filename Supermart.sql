--group the time into time periods
WITH TE(Id, [Time], Time_interval) AS(
	SELECT [Invoice ID], [Time], 
		CASE 
			WHEN [Time] BETWEEN '10:00:00' AND '12:00:00' THEN '10-12pm'
			WHEN [Time] BETWEEN '12:00:00' AND '14:00:00' THEN '12-2pm'
			WHEN [Time] BETWEEN '14:00:00' AND '16:00:00' THEN '2-4pm'
			WHEN [Time] BETWEEN '16:00:00' AND '18:00:00' THEN '4-6pm'
			WHEN [Time] BETWEEN '18:00:00' AND '21:00:00' THEN '6-9pm'
			ELSE 'Invalid Time'
		END AS Time_interval
	FROM supermarket
	)
SELECT Time_interval, COUNT(Id) AS Number_of_customers
FROM TE
GROUP BY Time_interval;

--find the total sales by city, customer type and Gender
SELECT City, Gender, [Customer type], SUM(Quantity) AS Quantity_sold, SUM([gross income]) AS Profit,
		AVG(Rating) AS Rating
FROM supermarket
GROUP BY City, Gender, [Customer type];

--find the sales , income and profit by product line
SELECT [Product line], SUM(Quantity) AS Total_sales, SUM(Total) AS income, SUM([gross income]) AS Profit
FROM supermarket
GROUP BY [Product line];

--find the percentage of people that used the different product types 
WITH TE(Payment_type, Sales) AS(
	SELECT Payment, SUM(Quantity)
	FROM supermarket
	GROUP BY Payment
	)
SELECT Payment_type, Sales, (Sales * 100 /(SELECT SUM(Sales) FROM TE)) AS Percent_Sales
FROM TE
GROUP BY Payment_type, Sales;

--Calculate the total income per month  
SELECT MONTH([Date]) AS Month_date, SUM([gross income]) AS Profit
FROM supermarket
GROUP BY MONTH([Date]);


