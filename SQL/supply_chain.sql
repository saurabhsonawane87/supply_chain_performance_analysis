USE supply_chain;

-- Data source: supply_chain_cleaned.csv
-- Table: sc_data
-- Rows: 91,250

-- Data Import:
-- The cleaned CSV file is provided separately in the data folder.
-- Import the CSV into the sc_data table before running these queries.

-- ============================================================
-- SECTION 1: OVERALL BUSINESS PERFORMANCE
-- ============================================================

-- Q1: Overall Business Performance

SELECT 
      SUM(units_sold) AS total_units_sold,
      ROUND(SUM(cost),2) AS total_cost,
      ROUND(SUM(revenue),2) AS total_revenue,
      ROUND(SUM(gross_profit),2) AS gross_profit 
FROM sc_data;
-- Insight:
-- The business generated approximately ₹3.34M in revenue and ₹1.11M
-- in gross profit, with an overall gross margin of about 33%.

-- ============================================================
-- SECTION 2: TIME & PRODUCT PERFORMANCE
-- ============================================================

-- Q2: Monthly Business Performance

WITH monthly_data AS (
    SELECT
        MONTH(date) AS month_num,
        MONTHNAME(date) AS month_name,
        SUM(units_sold) AS total_units_sold,
        ROUND(SUM(revenue), 2) AS total_revenue,
        ROUND(SUM(gross_profit), 2) AS total_gross_profit
    FROM sc_data
    GROUP BY MONTH(date), MONTHNAME(date)
),

monthly_change AS (
    SELECT
        month_num,
        month_name,
        total_units_sold,
        total_revenue,
        total_gross_profit,
        LAG(total_revenue) OVER (ORDER BY month_num) AS previous_month_revenue
    FROM monthly_data
)

SELECT
    month_name,
    total_units_sold,
    total_revenue,
    total_gross_profit,
    ROUND(
        (total_revenue - previous_month_revenue)
        / previous_month_revenue * 100,
        2
    ) AS revenue_change_pct
FROM monthly_change
ORDER BY month_num;
-- Insight:
-- Monthly revenue shows substantial variation, with March recording
-- the highest revenue and September recording the lowest.

-- Q3: SKU Profitability Performance

WITH sku_performance AS (
    SELECT
        sku_id,
        SUM(units_sold) AS total_units_sold,
        ROUND(SUM(revenue), 2) AS total_revenue,
        ROUND(SUM(gross_profit), 2) AS total_gross_profit,
        ROUND(
            SUM(gross_profit) / SUM(revenue) * 100,
            2
        ) AS gross_margin_pct
    FROM sc_data
    GROUP BY sku_id
),

overall_performance AS (
    SELECT
        SUM(gross_profit) / SUM(revenue) * 100 AS overall_margin_pct
    FROM sc_data
)

SELECT
    s.sku_id,
    s.total_units_sold,
    s.total_revenue,
    s.total_gross_profit,
    s.gross_margin_pct,
    ROUND(o.overall_margin_pct, 2) AS overall_margin_pct
FROM sku_performance s
CROSS JOIN overall_performance o
WHERE s.gross_margin_pct < o.overall_margin_pct
ORDER BY s.total_revenue DESC
LIMIT 10;
-- Insight:
-- Several high-revenue SKUs have margins below the overall business
-- margin, highlighting products that may require pricing or cost review.

-- ============================================================
-- SECTION 3: INVENTORY & REPLENISHMENT
-- ============================================================

-- Q4: SKU–Warehouse Replenishment Risk

SELECT 
     sku_id,
     warehouse_id,
     SUM(CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END) AS risk_days,
     ROUND(SUM(revenue),2) AS total_revenue,
     ROUND(SUM(gross_profit),2) AS total_gross_profit 
FROM sc_data 
GROUP BY sku_id,warehouse_id
HAVING risk_days > 0 
ORDER BY risk_days DESC,total_revenue DESC 
LIMIT 10;
-- Insight:
-- Several SKU–warehouse combinations experience repeated replenishment
-- risk while contributing meaningful revenue, making them important
-- inventory management priorities.

-- ============================================================
-- SECTION 4: FORECASTING & COMMERCIAL PERFORMANCE
-- ============================================================

-- Q5: SKU Forecast Performance

SELECT 
      sku_id,
      ROUND(AVG(forecast_error),2) AS avg_forecast_error,
      ROUND(AVG(absolute_forecast_error),2) AS avg_absolute_error,
      ROUND(AVG(forecast_accuracy_pct),2) AS forecast_accuracy_pct 
FROM sc_data 
GROUP BY sku_id 
ORDER BY avg_absolute_error DESC
LIMIT 10; 
-- Insight:
-- The weakest-performing SKUs show higher average forecast errors
-- and lower forecast accuracy, indicating opportunities to improve
-- demand planning.

-- Q6: Promotion Effectiveness

SELECT 
     promotion_flag,
     SUM(units_sold) AS total_units_sold,
     ROUND(SUM(revenue),2) AS total_revenue,
     ROUND(SUM(gross_profit),2) AS total_gross_profit,
     ROUND(SUM(gross_profit)/NULLIF(SUM(revenue),0)*100,2) AS gross_margin_pct 
FROM sc_data 
GROUP BY promotion_flag 
ORDER BY promotion_flag;
-- Insight:
-- Promoted records generate higher sales volume, while gross margins
-- remain broadly similar to non-promoted records.

-- Q7: Regional Forecast Performance

SELECT 
	region,
    ROUND(AVG(forecast_error),2) AS avg_forecast_error,
	ROUND(AVG(absolute_forecast_error),2) AS avg_absolute_error,
	ROUND(AVG(forecast_accuracy_pct),2) AS forecast_accuracy_pct 
FROM sc_data 
GROUP BY region 
ORDER BY avg_absolute_error DESC;
-- Insight:
-- Forecast performance is relatively similar across regions, with
-- all regions showing a slight tendency toward over-forecasting. 

-- ============================================================
-- SECTION 5: SUPPLIER, WAREHOUSE & MANAGEMENT PRIORITIES
-- ============================================================

-- Q8: Supplier Lead Time & Risk

SELECT
    supplier_id,
    ROUND(AVG(supplier_lead_time_days), 2) AS avg_lead_time_days,
    SUM(CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END) AS risk_days,
    COUNT(*) AS total_days,
    ROUND(SUM( CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END) / COUNT(*)*100,2) AS replenishment_risk_rate_pct,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sc_data
GROUP BY supplier_id
ORDER BY avg_lead_time_days DESC;
-- Insight:
-- Supplier lead times vary across suppliers, while replenishment-risk
-- rates remain relatively close.
 
-- Q9: Warehouse Inventory Efficiency

SELECT
    warehouse_id,
    ROUND(SUM(inventory_level), 2) AS total_inventory,
    SUM(units_sold) AS total_units_sold,
    ROUND(SUM(inventory_level) / NULLIF(SUM(units_sold), 0),2) AS inventory_coverage_days,
    SUM(CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END) AS risk_days,
    ROUND(SUM(CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END ) / COUNT(*) * 100,2) AS replenishment_risk_rate_pct
FROM sc_data
GROUP BY warehouse_id
ORDER BY inventory_coverage_days DESC;    
-- Insight:
-- Inventory coverage varies across warehouses, indicating differences
-- in inventory efficiency and opportunities to optimize stock levels.  

-- Q10: Management Priority Analysis

WITH sku_warehouse AS (
SELECT
	sku_id,
    warehouse_id,
	SUM(units_sold) AS total_units_sold,
	ROUND(SUM(revenue), 2) AS total_revenue,
	ROUND(SUM(gross_profit), 2) AS total_gross_profit,
    SUM(CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END) AS risk_days,
    ROUND(SUM(CASE WHEN replenishment_risk = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS risk_rate_pct,
    ROUND(AVG(absolute_forecast_error), 2) AS avg_absolute_error,
    ROUND(AVG(forecast_accuracy_pct), 2) AS forecast_accuracy_pct
FROM sc_data
GROUP BY sku_id, warehouse_id
),

ranked_data AS (
SELECT
	*,
	NTILE(4) OVER (ORDER BY risk_rate_pct DESC) AS risk_quartile,
    NTILE(4) OVER (ORDER BY total_revenue DESC) AS revenue_quartile,
	NTILE(4) OVER (ORDER BY avg_absolute_error DESC) AS forecast_error_quartile,
    NTILE(4) OVER (ORDER BY forecast_accuracy_pct ASC) AS accuracy_quartile
FROM sku_warehouse
WHERE risk_days > 0
)

SELECT
    sku_id,
    warehouse_id,
    total_units_sold,
    total_revenue,
    total_gross_profit,
    risk_days,
    risk_rate_pct,
    avg_absolute_error,
    forecast_accuracy_pct,
    (
        (5 - risk_quartile)
        + (5 - revenue_quartile)
        + (5 - forecast_error_quartile)
        + (5 - accuracy_quartile)
    ) AS priority_score

FROM ranked_data
ORDER BY priority_score DESC,
         total_revenue DESC
LIMIT 10;
-- Insight:
-- The priority analysis identifies SKU–warehouse combinations where
-- inventory risk, revenue exposure, and forecast performance require
-- greater management attention.
