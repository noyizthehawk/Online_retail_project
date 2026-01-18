-- Monthly revenue trends
CREATE OR REPLACE VIEW monthly_total_revenue AS
SELECT 
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    ROUND(SUM(Quantity * Price), 2) AS TotalRevenue
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Year, Month;

-- Avg order value per customer per month
CREATE OR REPLACE VIEW monthly_avg_order_value AS
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    ROUND(SUM(Quantity * Price) / COUNT(DISTINCT CustomerID), 2) AS AvgOrderValue_per_customer
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Year, Month;

-- Unique customers per month
CREATE OR REPLACE VIEW monthly_unique_customers AS
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Year, Month;

-- Monthly product revenue
CREATE OR REPLACE VIEW monthly_product_revenue AS
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    Description AS Product,
    ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate), Description
ORDER BY Year, Month, Revenue DESC;

-- High-volume, low-revenue products
CREATE OR REPLACE VIEW monthly_low_revenue_products AS
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    Description AS Product,
    SUM(Quantity) AS TotalUnitsSold,
    ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate), Description
HAVING SUM(Quantity) > 50 AND SUM(Quantity * Price) < 100
ORDER BY Year, Month, TotalUnitsSold DESC;

-- Revenue by country per month
CREATE OR REPLACE VIEW monthly_country_revenue AS
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    Country,
    ROUND(SUM(Quantity * Price), 2) AS Revenue
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate), Country
ORDER BY Year, Month, Revenue DESC;

-- Unique customers by country per month
CREATE OR REPLACE VIEW monthly_country_customers AS
SELECT
    YEAR(InvoiceDate) AS Year,
    MONTH(InvoiceDate) AS Month,
    Country,
    COUNT(DISTINCT CustomerID) AS UniqueCustomers
FROM retail_transactions
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate), Country
ORDER BY Year, Month, UniqueCustomers DESC;