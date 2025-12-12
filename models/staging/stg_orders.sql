with source as (
	select * from {{ source('raw', 'orders') }}
)

select
    row_id,
    order_id,
    customer_id,
    customer_name,
    segment,
    country,
    city,
    state,
    region,
    category,
    sub_category,
    product_name,
    cast(order_date as date) as order_date,
    cast(ship_date as date) as ship_date,
    sales::numeric as sales,
    profit::numeric as profit,
    quantity::integer as quantity,
    discount::numeric as discount,
    date_trunc('month', cast(order_date as date))::date as order_month
from source
