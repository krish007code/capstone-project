{{ config(materialized='view') }}

SELECT
    cast(id as VARCHAR) as item_id,
    cast(order_id as VARCHAR) as order_id,
    cast(sku as VARCHAR) as product_id
FROM {{ ref('raw_items') }}
