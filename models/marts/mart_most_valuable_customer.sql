{{ config(materialized='table') }}

with customer_base as (
    select * from {{ ref('stg_customers') }}
),
customer_metrics as (
    select * from {{ ref('int_customer_order_history') }}
)
select
    c.customer_id,
    c.first_name,
    c.last_name,
    coalesce(m.lifetime_value, 0) as lifetime_value,
    coalesce(m.avg_purchase, 0) as avg_purchase
from customer_base as c
left join customer_metrics as m on c.customer_id = m.customer_id