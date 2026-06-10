{{ config(materialized='ephemeral') }}
with customers as (
    select * from {{ ref('stg_customers') }}
),
orders as (
    select * from {{ ref('stg_orders') }}
),
joined as (
    select 
        customers.customer_id, 
        coalesce(sum(orders.subtotal), 0) as lifetime_value,
        coalesce(avg(orders.subtotal), 0) as avg_purchase
    from customers 
    left join orders 
        on customers.customer_id = orders.customer_id
    group by customers.customer_id
)
select * from joined