{{ config(materialized='table') }}

with stores as (
    select * from {{ ref('stg_stores') }}
),
store_financials as (
    select * from {{ ref('int_store_costs_aggregated') }}
),
final as (
    select
        stores.store_id,
        stores.store_name,
        coalesce(store_financials.total_revenue, 0) as total_revenue,
        coalesce(store_financials.total_cost, 0) as total_cost,
        coalesce(store_financials.total_profit, 0) as total_profit,
        
        case 
            when store_financials.total_revenue > 0 
            then round((store_financials.total_profit / store_financials.total_revenue) * 100, 2)
            else 0 
        end as profit_margin_pct

    from stores
    left join store_financials
        on stores.store_id = store_financials.store_id
)
select * from final