{{ config(materialized='ephemeral') }}

with order_items as (
    select * from {{ ref('int_order_items_joined') }}
),

store_aggregates as (
    select
        store_id,
        sum(item_revenue) as total_revenue,
        sum(item_cost) as total_cost,
        sum(item_revenue) - sum(item_cost) as total_profit
    from order_items
    group by store_id
)

select * from store_aggregates