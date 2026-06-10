{{ config(materialized='ephemeral') }}

with supplies as (
    select * from {{ ref('stg_supplies') }}
),

product_costs as (
    select
        sku as product_id,
        sum(cost) as product_cost
    from supplies
    group by sku
)

select * from product_costs
