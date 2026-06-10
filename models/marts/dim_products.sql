{{ config(materialized='table') }}

with product_base as (
    select * from {{ ref('stg_products') }}
),

product_costs as (
    select * from {{ ref('int_product_costs') }}
),

product_metrics as (
    select * from {{ ref('int_product_sales_aggregated') }}
)

select
    p.product_id,
    p.product_name,
    p.product_price,
    pc.product_cost,
    (p.product_price - pc.product_cost) as unit_profit_margin,
    
    coalesce(m.total_sold, 0) as total_sold,
    coalesce(m.gross_revenue, 0) as gross_revenue,
    coalesce(m.total_profit, 0) as total_profit

from product_base p
left join product_costs pc
    on p.product_id = pc.product_id
left join product_metrics m
    on p.product_id = m.product_id
order by total_profit desc
