
    
    

select
    id as unique_field,
    count(*) as n_records

from "capstone_dev"."main"."stg_orders"
where id is not null
group by id
having count(*) > 1


