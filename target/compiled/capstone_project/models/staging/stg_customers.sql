
SELECT
    cast(id as VARCHAR) as customer_id,
    cast(split_part(name, ' ', 1) as varchar) as first_name,
    cast(split_part(name, ' ', 2) as varchar) as last_name
FROM "capstone_dev"."main"."raw_customers"