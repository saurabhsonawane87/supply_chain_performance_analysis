# Supply Chain Performance Analysis 📦

## Project Overview

This project is an end-to-end supply chain analytics project focused on analyzing sales performance, profitability, inventory levels, warehouse replenishment risk, supplier contribution and regional performance.

The project uses Python for data cleaning and exploratory data analysis, MySQL for structured business analysis, and Power BI for interactive dashboard development.

The objective is to convert supply chain data into meaningful business insights and practical recommendations that can support better business decision-making.

---

## Business Problem

Supply chain businesses need to balance sales performance, inventory availability, supplier efficiency and profitability.

This project focuses on answering the following business questions:

- How much revenue and gross profit were generated?
- Which SKUs contributed the most revenue and profit?
- How does revenue change across months and regions?
- Which warehouses have higher replenishment risk?
- Which suppliers contribute the most revenue?
- Does higher revenue always result in higher profitability?

---

## Dataset Overview

The cleaned dataset contains supply chain transaction and operational information used for sales, profitability, inventory, supplier, warehouse and regional analysis.

### Dataset Details

- **Total Records:** 91,250
- **Time Period:** January 1, 2024 to December 30, 2024
- **Products:** 50 SKUs
- **Warehouses:** 5
- **Suppliers:** 10
- **Regions:** 4
- **Original/Input Columns:** 15
- **Derived/Analysis Columns:** 15
- **Total Columns in Cleaned Dataset:** 30

The cleaned dataset contains 15 original business columns and 15 derived analytical columns created during data preparation.

---

## Dataset Columns

The dataset contains the following columns:

| Column | Description |
|---|---|
| `date` | Transaction date |
| `sku_id` | Product or SKU identifier |
| `warehouse_id` | Warehouse identifier |
| `supplier_id` | Supplier identifier |
| `region` | Sales region |
| `units_sold` | Number of units sold |
| `inventory_level` | Available inventory level |
| `supplier_lead_time_days` | Supplier lead time in days |
| `reorder_point` | Inventory level at which replenishment may be required |
| `order_quantity` | Quantity ordered for replenishment |
| `unit_cost` | Cost per unit |
| `unit_price` | Selling price per unit |
| `promotion_flag` | Indicates whether a promotion was active |
| `stockout_flag` | Indicates whether a stockout occurred |
| `demand_forecast` | Forecasted demand value available in the dataset |

### Derived Analytical Columns

| Column | Description |
|---|---|
| `revenue` | Revenue generated from units sold and unit price |
| `cost` | Total cost calculated using units sold and unit cost |
| `gross_profit` | Revenue minus cost |
| `forecast_error` | Difference between actual units sold and demand forecast |
| `absolute_forecast_error` | Absolute value of forecast error |
| `gross_margin_pct` | Gross profit as a percentage of revenue |
| `forecast_accuracy_pct` | Forecast accuracy percentage |
| `inventory_gap` | Difference between inventory level and reorder point |
| `replenishment_risk` | Indicates replenishment risk based on inventory conditions |
| `inventory_coverage_days` | Estimated number of days current inventory can cover |
| `year` | Year extracted from the date |
| `month` | Month number extracted from the date |
| `month_name` | Month name extracted from the date |
| `day_of_week` | Day name extracted from the date |
| `day_of_week_num` | Day number extracted from the date |

---

## Tools and Technologies

- **Python:** Data cleaning, preprocessing and exploratory data analysis
- **Pandas and NumPy:** Data manipulation and numerical analysis
- **Matplotlib and Seaborn:** Data visualization
- **MySQL:** Business analysis using SQL queries
- **Power BI:** Interactive dashboard development and reporting

---

## Project Workflow

```text
Supply Chain Dataset
        ↓
Data Cleaning Using Python
        ↓
Exploratory Data Analysis
        ↓
SQL Analysis Using MySQL
        ↓
Power BI Dashboard Development
        ↓
Business Insights and Recommendations
```
---

## Data Cleaning and Preparation

The dataset was prepared using Python and Pandas before SQL and Power BI analysis.

Main steps included:

- Loading and reviewing the dataset
- Checking missing values and duplicates
- Standardizing column names
- Converting the date column into datetime format
- Validating numerical and categorical fields
- Creating derived analytical columns
- Exporting the cleaned dataset

---

## Exploratory Data Analysis

The analysis focused on:

- Revenue and gross profit distribution
- Monthly revenue trends
- SKU-level sales and profitability
- Inventory levels and replenishment risk
- Supplier and regional performance
- Relationship between revenue and gross profit

---

## SQL Analysis

The cleaned dataset was imported into MySQL for structured business analysis.

Key analyses included:

- Overall revenue and profitability
- Monthly revenue trends
- SKU-level revenue and gross profit
- Inventory and replenishment risk
- Supplier and warehouse performance
- Regional revenue contribution
- Promotion-related performance

---

## Power BI Dashboard

The interactive Power BI dashboard includes:

- Revenue, units sold, gross profit and gross margin KPIs
- Monthly revenue trend
- Top 10 SKUs by revenue
- Top 10 SKUs by gross profit
- Revenue versus gross profit scatter plot
- Regional revenue donut chart
- Warehouse replenishment risk table
- Supplier revenue treemap
- Month and region slicers

---

## Key Insights

- Total revenue was approximately **33.43M**.
- Total units sold were approximately **1.83M**.
- Total gross profit was approximately **11.09M**.
- Overall gross margin was **33.17%**.
- Monthly revenue showed variation across the year.
- A small group of SKUs contributed significantly to revenue and gross profit.
- Higher revenue did not always guarantee higher profitability.
- Regional revenue contribution was relatively balanced.
- Replenishment risk was present across all five warehouses.
- Supplier revenue contribution varied across suppliers.

---

## Business Recommendations

1. Monitor revenue, gross profit and gross margin together.
2. Prioritize high-revenue and high-profit SKUs.
3. Review high-revenue products with comparatively lower profit.
4. Monitor warehouse replenishment risk regularly.
5. Use inventory and replenishment metrics for purchasing decisions.
6. Review supplier contribution and operational performance.
7. Monitor monthly revenue trends for sales planning.

---

## Project Files

- `dashboard/` – Power BI dashboard file and dashboard screenshot
- `dataset/` – Cleaned supply chain dataset
- `notebooks/` – Python data cleaning and exploratory analysis notebook
- `SQL/` – MySQL analysis queries
- `story/` – Supply chain analytics storytelling document
- `README.md` – Project documentation

---

## Project Scope

The dataset includes a `demand_forecast` field, which was used for forecast-related comparisons where applicable.

This project does not develop a machine learning forecasting model. Its main focus is supply chain performance analysis, revenue, profitability, inventory, replenishment risk, supplier contribution and business reporting.

---

## Conclusion

This project transformed supply chain data into meaningful business insights using Python, MySQL and Power BI.

Python was used for data cleaning and exploratory analysis. MySQL was used to answer structured business questions, while Power BI was used to create an interactive dashboard.

The project demonstrates an end-to-end analytics workflow and shows how data can support revenue monitoring, product prioritization, inventory planning, supplier evaluation and operational decision-making.

---

## Author

**Saurabh Sonawane**

### Skills Demonstrated

- Python
- Pandas
- NumPy
- SQL
- MySQL
- Power BI
- Data Cleaning
- Exploratory Data Analysis
- Business Analysis
- Data Visualization
- Dashboard Development