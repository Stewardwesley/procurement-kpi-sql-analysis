CREATE DATABASE procurement_db;

DROP TABLE IF EXISTS procurement_data;

RENAME TABLE `procurement kpi analysis dataset` TO procurement_data;
SELECT COUNT(*) FROM procurement_data;
SELECT * FROM procurement_data LIMIT 5;

-- KPI 1: Total Spend

SELECT 
  SUM(Quantity * Unit_Price) AS Total_Original_Spend,
  SUM(Quantity * Negotiated_Price) AS Total_Negotiated_Spend,
  ROUND(SUM(Quantity * Unit_Price) - SUM(Quantity * Negotiated_Price), 2) AS Total_Cost_Savings
FROM procurement_data;

-- KPI 2: Defect Rate

SELECT 
  Supplier,
  SUM(Defective_Units) AS Total_Defective_Units,
  SUM(Quantity) AS Total_Units_Ordered,
  ROUND(SUM(Defective_Units) * 100.0 / SUM(Quantity), 2) AS Defect_Rate_Percentage
FROM procurement_data
GROUP BY Supplier; 

-- KPI 3: On-Time Delivery Rate

SELECT 
  Supplier,
  COUNT(*) AS Total_Orders,
  SUM(DATEDIFF(Delivery_Date, Order_Date) <= 7) AS On_Time_Deliveries,
  SUM(DATEDIFF(Delivery_Date, Order_Date) > 7) AS Late_Deliveries,
  ROUND(SUM(DATEDIFF(Delivery_Date, Order_Date) <= 7) * 100.0 / COUNT(*), 2) AS On_Time_Delivery_Rate
FROM procurement_data
WHERE Delivery_Date IS NOT NULL
GROUP BY Supplier
ORDER BY On_Time_Delivery_Rate DESC;

-- KPI 4: Compliance Rate

SELECT 
  Supplier,
  COUNT(*) AS Total_Orders,
  SUM(CASE WHEN Compliance = 'Yes' THEN 1 ELSE 0 END) AS Compliant_Orders,
  ROUND(SUM(CASE WHEN Compliance = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Compliance_Rate
FROM procurement_data
GROUP BY Supplier;

-- KPI 6: Average Delivery Time (in days)

SELECT 
  Supplier,
  ROUND(AVG(DATEDIFF(Delivery_Date, Order_Date)), 2) AS Avg_Delivery_Time
FROM procurement_data
WHERE Delivery_Date IS NOT NULL
GROUP BY Supplier;

-- KPI 7: Price Inflation Trend by Item Category
SELECT 
  Item_Category,
  YEAR(Order_Date) AS Year,
  ROUND(AVG(Unit_Price), 2) AS Avg_Unit_Price
FROM procurement_data
GROUP BY Item_Category, YEAR(Order_Date)
ORDER BY Item_Category, Year;

-- KPI 8: Cost Savings through Negotiation

SELECT 
  Supplier,
  ROUND(SUM((Unit_Price - Negotiated_Price) * Quantity), 2) AS Total_Savings
FROM procurement_data
WHERE Negotiated_Price < Unit_Price
GROUP BY Supplier
ORDER BY Total_Savings DESC;

-- KPI 9: Supplier Risk Score (Composite)
SELECT 
  Supplier,
  ROUND(SUM((Unit_Price - Negotiated_Price) * Quantity), 2) AS Cost_Savings,
  ROUND(SUM(Defective_Units) * 100.0 / SUM(Quantity), 2) AS Defect_Rate,
  ROUND(SUM(DATEDIFF(Delivery_Date, Order_Date) <= 7) * 100.0 / COUNT(*), 2) AS OnTime_Delivery_Rate,
  ROUND(
    (1 - (SUM((Unit_Price - Negotiated_Price) * Quantity) / NULLIF(SUM(Unit_Price * Quantity), 0))) * 0.4 +
    (SUM(Defective_Units) * 1.0 / NULLIF(SUM(Quantity), 0)) * 0.3 +
    ((100 - SUM(DATEDIFF(Delivery_Date, Order_Date) <= 7) * 100.0 / COUNT(*)) * 0.3), 2
  ) AS Risk_Score
FROM procurement_data
WHERE Quantity > 0 AND Delivery_Date IS NOT NULL
GROUP BY Supplier
ORDER BY Risk_Score DESC;
