

SELECT
    cast(sku as VARCHAR) as product_id,
    cast(name as VARCHAR) as product_name,
    cast(type as VARCHAR) as product_type,
    cast(price as INTEGER) as product_price,
    cast(description as VARCHAR) as description
FROM "capstone_dev"."main"."raw_products"