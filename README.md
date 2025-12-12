# Retail Sales Analytics Project (SQL + dbt + PostgreSQL)

This project demonstrates a complete end-to-end analytics workflow using **PostgreSQL**, **dbt**, and **SQL** to transform raw retail sales data into actionable insights.  
It is designed as a portfolio project to showcase real-world data analysis, data modeling, and business decision-making.

---

## Project Overview

The goal of this project is to analyze retail sales performance across regions, product categories, customer behavior, and discounting practices. Using SQL and dbt, I built a clean transformation pipeline and conducted exploratory data analysis (EDA) to uncover insights about profitability, customer retention, and operational strategy.

---

## Technologies Used

- **PostgreSQL** — Database to store and query data  
- **dbt (data build tool)** — For data modeling and transformations  
- **psql** — Command-line SQL interface  
- **VS Code** — Development environment  
- **Git & GitHub** — Version control and project hosting  

---

## Data Pipeline Structure

Raw CSV → PostgreSQL (raw schema)
- dbt staging models (stg_orders)
- dbt fact model (fct_sales_monthly)
- SQL EDA queries
- Business insights & recommendations

---

## Key Findings
- **Seasonality:** Sales peak every November–December due to holiday demand.  
- **Category Performance:** Technology and Office Supplies drive the highest profit.  
- **Discounting Issue:** Furniture receives the highest discounts but yields the lowest profit.  
- **Customer Retention:** Most customers purchase across 4–8 months, showing strong mid-tier retention.

---

## Business Recommendations
(Full details in `business_recommendations.md`)

- Reduce Furniture discounting to improve margins.  
- Prioritize Technology & Office Supplies in marketing strategy.  
- Prepare inventory and staffing for Q4 seasonal spikes.  
- Introduce a loyalty program targeting 4–6 month active customers.  

---

## How to Run
### 1. Load raw data:
```sql
\copy raw.orders FROM 'Sample - Superstore.csv' CSV HEADER;
```
### 2. Run dbt models
```bash
dbt run
dbt test
```
### 3. EDA
sql/eda_queries.sql

## Contact

Feel free to reach out with questions about the project!
Email: jlin673@gatech.edu

