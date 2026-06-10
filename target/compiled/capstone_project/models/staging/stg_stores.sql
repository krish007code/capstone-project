

SELECT
    cast(id as VARCHAR) as store_id,
    cast(name as VARCHAR) as store_name,
    cast(opened_at as TIMESTAMP) as opened_at,
    cast(tax_rate as FLOAT) as tax_rate
FROM "capstone_dev"."main"."raw_stores"