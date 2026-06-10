
  
  create view "capstone_dev"."main"."stg_items__dbt_tmp" as (
    

SELECT
    cast(id as VARCHAR) as item_id,
    cast(order_id as VARCHAR) as order_id,
    cast(sku as VARCHAR) as product_id
FROM "capstone_dev"."main"."raw_items"
  );
