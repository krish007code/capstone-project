{{ config(materialized='ephemeral') }}

with items as (
    select * from {{ ref('stg_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

product_costs as (
    select * from {{ ref('int_product_costs') }}
),

joined as (
    select
        items.item_id,
        items.order_id,
        items.product_id,
        orders.customer_id,
        orders.store_id,
        orders.ordered_at,
        products.product_price as item_revenue,
        product_costs.product_cost as item_cost
    from items 
    left join orders 
        on items.order_id = orders.order_id 
    left join products 
        on items.product_id = products.product_id
    left join product_costs
        on items.product_id = product_costs.product_id
)

select * from joined
