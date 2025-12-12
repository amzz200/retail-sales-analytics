{{ config(materialized='table') }}

with o as (
      select * from {{ ref('stg_orders') }}
)

select
  order_month,
  region,
  category,
  customer_id,
  sum(sales) as total_sales,
  sum(profit) as total_profit,
  sum(quantity) as total_quantity,
ROUND(
  CASE
     when SUM(sales)=0 THEN NULL
     ELSE SUM(profit)/SUM(sales) END, 2
) as profit_margin
from o
group by 1,2,3,4
