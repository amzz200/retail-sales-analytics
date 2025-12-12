/* EDA 1: Monthly Sales Trends
   Query: Order month vs monthly sales
   Insight Summary: 
   - Sales increase sharply during Q4 each year (Nov–Dec).
   - 2017 shows the strongest holiday spike (Nov > 118k).
   - Monthly sales fluctuate, but long-term trend is upward.
   - Strong seasonality suggests holiday-driven revenue cycles.
*/

SELECT 
    order_month,
    SUM(total_sales) AS monthly_sales 
FROM analytics.fct_sales_monthly
GROUP BY order_month
ORDER BY order_month;

/*
Sample results 

 order_month | monthly_sales     
-------------+-------------
 2014-01-01  |   14236.895
 2014-02-01  |    4519.892
 2014-03-01  |   55691.009
 2014-04-01  |   28295.345
 2014-05-01  |   23648.287
 2014-06-01  |  34595.1276
 2014-07-01  |   33946.393
 2014-08-01  |  27909.4685
 2014-09-01  |  81777.3508
 2014-10-01  |   31453.393
 2014-11-01  |  78628.7167    <--- holiday spike
 2014-12-01  |  69545.6205
 2015-01-01  |  18174.0756
 2015-02-01  |   11951.411

 ...                          


 2017-09-01  |   87866.652
 2017-10-01  |  77776.9232    <--- recurring holiday spike
 2017-11-01  | 118447.8250
 2017-12-01  |  83829.3188

*/


/*
EDA 2: Region x Category Profitability

- The goal of this comparison is to identify which combinations
of region + category drive the highest and lowest profitability.

Insight Summary:
- West × Office Supplies has the highest profit (~52.6K).
- East × Technology and West × Technology also contribute heavily to profit (~47K and ~44K).
- Central × Furniture is the only segment consistently losing money (-2.8K), indicating pricing or cost issues.
- Furniture underperforms across all regions compared to Technology and Office Supplies.

Business Interpretation:
- Technology and Office Supplies are core revenue engines.
- Furniture is a margin risk category, especially in Central.
*/

SELECT 
    region, 
    category,
    SUM(total_sales) AS sales,
    SUM(total_profit) AS profit
FROM analytics.fct_sales_monthly
GROUP BY region, category
ORDER BY profit DESC;

/* 
Results

region  |    category     |    sales    |   profit   
---------+-----------------+-------------+------------
 West    | Office Supplies |  220853.249 | 52609.8490
 East    | Technology      |  264973.981 | 47462.0351
 West    | Technology      |  251991.832 | 44303.6496
 East    | Office Supplies |  205516.055 | 41014.5791
 Central | Technology      |  170416.312 | 33697.4320
 South   | Technology      |  148771.908 | 19991.8314
 South   | Office Supplies |  125651.313 | 19986.3928
 West    | Furniture       | 252612.7435 | 11504.9503
 Central | Office Supplies |  167026.415 |  8879.9799
 South   | Furniture       | 117298.6840 |  6771.2061
 East    | Furniture       |  208291.204 |  3046.1658
 Central | Furniture       | 163797.1638 | -2871.0494

 */


/* 
EDA 3: Category Discounts vs. Profitability

- The goal of this query is to understand whether discounts are affecting profit by item category.

Insight Summary:
- Furniture has the highest average discount (0.17) but produces the lowest total profit (~18.4k).
- Office Supplies also shows moderate discounts (0.16) but generates a much stronger profit (~122k) compared to Furniture.
- Technology has the lowest discount rate (0.13) and the highest total profit (~145k).

Buiness Interpretations:
- Higher discounts in Furniture correlate with weaker profits.
- Technology benefits from low discounts and strong margins.
- Furniture should likely reduce its discount policy.
*/


SELECT 
    category,
    ROUND(AVG(discount),2) AS avg_discount,
    ROUND(SUM(profit), 2) AS total_profit
FROM analytics.stg_orders
GROUP BY category
ORDER BY avg_discount DESC;

/*
Result:

 category        | avg_discount | total_profit
-----------------+--------------+--------------
 Furniture       | 0.17         | 18,451.27
 Office Supplies | 0.16         | 122,490.80
 Technology      | 0.13         | 145,454.95
*/

/*
EDA 4: Customer Retention (Active Months Analysis)

- The goal of this query is to understand how frequently customers return by counting how many distinct months each customer made a purchase.
- It aims to answer the question: Are most buyers one-time customers, occasional purchasers, or long-term loyal customers?

Insight Summary:
- A small group of customers purchased in only 1–3 months (118 total).
- The majority of customers purchased across 4–8 different months (over 580 customers), which indicates strong mid-tier retention.
- A smaller but meaningful segment (about 95 customers) purchased across 9–12 months -> loyalty customer segment.

Business Interpretation:
- The majority of customers are not one-time buyers. They return consistently across multiple months.
- One reccomendation is introducing a loyalty or reward program could strengthen customer retention even more.
- Long term customers (9+ months active) should be targeted for premium offers or early access campaigns.

*/

WITH customer_activity AS (
    SELECT 
        customer_id,
        COUNT(DISTINCT order_month) AS active_months
    FROM analytics.stg_orders
    GROUP BY customer_id
)
SELECT 
    active_months,
    COUNT(*) AS customer_count
FROM customer_activity
GROUP BY active_months
ORDER BY active_months;

/* 
 active_months | customer_count 
---------------+----------------
             1 |             14
             2 |             37
             3 |             67
             4 |            104
             5 |            156
             6 |            114
             7 |            119
             8 |             87
             9 |             53
            10 |             24
            11 |             12
            12 |              6

*/