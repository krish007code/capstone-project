
  
  create view "capstone_dev"."main"."stg_orders__dbt_tmp" as (
    

SELECT
    cast(id as VARCHAR) as order_id,
    cast(customer as VARCHAR) as customer_id,
    cast(ordered_at as TIMESTAMP) as ordered_at,
    cast(store_id as VARCHAR) as store_id,
    cast(subtotal as INTEGER) as subtotal,
    cast(tax_paid as INTEGER) as tax_paid,
    cast(order_total as INTEGER) as order_total
FROM "capstone_dev"."main"."raw_orders"
  );
