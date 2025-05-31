# procurement-kpi-sql-analysis
“SQL-based analysis of procurement KPIs from real-world purchase order data. Includes supplier risk scoring, defect rates, cost savings, and compliance metrics using MySQL Workbench.”

# Procurement KPI Analysis

This project focuses on analyzing a procurement dataset containing 700 anonymized purchase orders from 2022–2023. The goal is to extract meaningful business insights, measure supplier performance, and identify optimization opportunities using SQL in MySQL Workbench.

## 📊 Dataset Overview

* **Rows**: 700 purchase orders
* **Fields**: PO ID, Supplier, Order Date, Delivery Date, Item Category, Order Status, Quantity, Unit Price, Negotiated Price, Defective Units, Compliance
* **Source**: Real-world procurement data, anonymized
* **Challenges**: Missing values, delivery delays, defective units, price fluctuations

## 🧩 KPIs Analyzed

### 1. 💸 Total Spend per Supplier

* **Objective**: Identify top suppliers based on procurement cost.
* **Query**: Calculates total spend as `Quantity * Unit_Price` per supplier.

### 2. 🧪 Defect Rate

* **Objective**: Identify suppliers with high quality issues.
* **Query**: Calculates the percentage of defective units over total quantity.

### 3. ⏱️ On-Time Delivery Rate

* **Objective**: Assess supplier reliability in timely deliveries.
* **Query**: Measures percentage of deliveries made within 7 days from order.

### 4. 📈 Price Trend by Item Category

* **Objective**: Understand inflation impact across categories.
* **Query**: Shows average unit price trend year-over-year by category.

### 5. ✅ Compliance Rate

* **Objective**: Monitor policy adherence.
* **Query**: Calculates the percentage of orders marked as compliant.

### 6. 💰 Cost Savings from Negotiation

* **Objective**: Quantify savings due to negotiated pricing.
* **Query**: Computes total savings as `Unit_Price - Negotiated_Price` times quantity.

### 7. ⚠️ Supplier Risk Score (Composite)

* **Objective**: Rank suppliers by overall risk.
* **Query**: Composite score from cost savings, defect rate, and delivery performance.

## 🛠 Tools Used

* **Database**: MySQL Workbench
* **Language**: SQL
* **Environment**: Local machine

## 📂 Project Files

* SQL file with all 7 KPI queries
* Screenshots/exports of SQL outputs

## 🔗 How to Reproduce

1. Load dataset into MySQL table `procurement_data`
2. Use provided SQL queries
3. Export results or integrate into BI tools

---

Feel free to fork this repository and adapt the queries for your own use cases. Contributions and suggestions welcome!
