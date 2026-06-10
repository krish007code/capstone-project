{{ config(materialized='table') }}

with order_items as (
    select * from {{ ref('int_order_items_joined') }}
),

order_aggregations as (
    select
        order_id,
        customer_id,
        store_id,
        ordered_at,
        
        -- Calculate total metrics per individual order
        sum(item_revenue) as total_revenue,
        sum(item_cost) as total_cost,
        sum(item_revenue) - sum(item_cost) as total_profit
        
    from order_items
    group by 
        order_id,
        customer_id,
        store_id,
        ordered_at
)

select * from order_aggregations