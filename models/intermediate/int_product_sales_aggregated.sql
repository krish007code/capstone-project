{{ config(materialized='ephemeral') }}

with order_items as (
    select * from {{ ref('int_order_items_joined') }}
),

aggregated as (
    select
        product_id,
        count(*) as total_sold,
        sum(item_revenue) as gross_revenue,
        sum(item_revenue - item_cost) as total_profit
    from order_items
    group by product_id
)

select * from aggregated
