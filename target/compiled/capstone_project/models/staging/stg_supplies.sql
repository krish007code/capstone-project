

SELECT
    cast(id as VARCHAR) as supply_id,
    cast(name as VARCHAR) as name,
    cast(cost as INTEGER) as cost,
    cast(perishable as BOOLEAN) as is_perishable,
    cast(sku as VARCHAR) as sku
FROM "capstone_dev"."main"."raw_supplies"