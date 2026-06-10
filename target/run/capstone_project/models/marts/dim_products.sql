
  
    
    

    create  table
      "capstone_dev"."main"."dim_products__dbt_tmp"
  
    as (
      

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
),  __dbt__cte__int_product_sales_aggregated as (


with order_items as (
    select * from __dbt__cte__int_order_items_joined
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
), product_base as (
    select * from "capstone_dev"."main"."stg_products"
),

product_costs as (
    select * from __dbt__cte__int_product_costs
),

product_metrics as (
    select * from __dbt__cte__int_product_sales_aggregated
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
    );
  
  