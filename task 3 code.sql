-- 1.Database Creation

CREATE TABLE sales_sample (
    Product_Id INTEGER,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount NUMERIC(10, 2)
);

-- 2.Data Creation

INSERT INTO sales_sample (Product_Id, Region, Date, Sales_Amount) VALUES
(01, 'East', '2025-11-14', 550.00),
(01, 'West', '2025-10-11', 350.50),
(02, 'East', '2025-10-12', 550.00),
(02, 'West', '2025-10-02', 650.25),
(03, 'East', '2025-10-03', 400.00),
(03, 'West', '2025-11-03', 250.00),
(01, 'East', '2025-10-17', 700.00),
(02, 'West', '2025-10-01', 150.00),
(03, 'East', '2025-11-22', 950.00),
(01, 'West', '2025-11-02', 850.75);

SELECT * FROM sales_sample;

-- 3.Perform OLAP operations
-- a)Drill Down-Analyze sales data at a more detailed level. Write a query to perform drill down from region to product level to understand sales performance.

SELECT
    Region,
    Product_Id,
    SUM(Sales_Amount) AS Total_Sales
FROM
    sales_sample
GROUP BY
    Region,
    Product_Id -- Grouping by both region and product provides the detailed view
ORDER BY
    Region,
    Product_Id;
    
-- b)Rollup- To summarize sales data at different levels of granularity. Write a query to perform roll up from product to region level to view total sales by region.

SELECT 
    COALESCE(Region, 'Grand Total') AS Region,
    COALESCE(CAST(Product_Id AS VARCHAR), 'Region Total') AS Product_Id_Detail,
    SUM(Sales_Amount) AS Total_Sales
FROM 
    sales_sample
GROUP BY 
    ROLLUP(Region, Product_Id)
ORDER BY 
    GROUPING(Region), 
    Region, 
    GROUPING(Product_Id), 
    Product_Id;

-- c)Cube - To analyze sales data from multiple dimensions simultaneously. Write a query to Explore sales data from different perspectives, such as product, region, and date

SELECT
    COALESCE(Region, 'All Regions') AS Region,
    COALESCE(CAST(Product_Id AS VARCHAR), 'All Products') AS Product_Id,
    COALESCE(CAST(EXTRACT(YEAR FROM Date) AS VARCHAR), 'All Years') AS Sales_Year, 
    SUM(Sales_Amount) AS Total_Sales
FROM
    sales_sample
GROUP BY
    CUBE(Region, Product_Id, EXTRACT(YEAR FROM Date)) 
ORDER BY
    Region,
    Product_Id,
    Sales_Year;

-- d)Slice- To extract a subset of data based on specific criteria. Write a query to slice the data to view sales for a particular region or date range.
SELECT 
    Product_Id,
    Region,
    Date,
    Sales_Amount
FROM 
    sales_sample
WHERE 
    Date >= '2025-10-01' AND Date <= '2025-10-31'
ORDER BY
    Date;

-- e)Dice - To extract data based on multiple criteria. Write a query to view sales for specific combinations of product, region, and date

SELECT 
    Product_Id,
    Region,
    Date,
    Sales_Amount
FROM 
    sales_sample
WHERE 
    Region = 'West'
    AND Product_Id IN (1, 2)
    AND Date >= '2025-10-01' 
    AND Date <= '2025-10-31'
ORDER BY
    Date,
    Product_Id;

