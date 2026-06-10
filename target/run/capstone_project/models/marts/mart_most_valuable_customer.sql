
  
    
    

    create  table
      "capstone_dev"."main"."mart_most_valuable_customer__dbt_tmp"
  
    as (
      

with  __dbt__cte__int_customer_order_history as (

with customers as (
    select * from "capstone_dev"."main"."stg_customers"
),
orders as (
    select * from "capstone_dev"."main"."stg_orders"
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
), customer_base as (
    select * from "capstone_dev"."main"."stg_customers"
),
customer_metrics as (
    select * from __dbt__cte__int_customer_order_history
)
select
    c.customer_id,
    c.first_name,
    c.last_name,
    coalesce(m.lifetime_value, 0) as lifetime_value,
    coalesce(m.avg_purchase, 0) as avg_purchase
from customer_base as c
left join customer_metrics as m on c.customer_id = m.customer_id
    );
  
  