

with  __dbt__cte__int_product_costs as (


with supplies as (
    select * from "capstone_dev"."main"."stg_supplies"
),

product_costs as (
    select
        sku as product_id,
        sum(cost) as product_cost
    from supplies
    group by sku
)

select * from product_costs
),  __dbt__cte__int_order_items_joined as (


with items as (
    select * from "capstone_dev"."main"."stg_items"
),

orders as (
    select * from "capstone_dev"."main"."stg_orders"
),

products as (
    select * from "capstone_dev"."main"."stg_products"
),

product_costs as (
    select * from __dbt__cte__int_product_costs
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
), order_items as (
    select * from __dbt__cte__int_order_items_joined
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