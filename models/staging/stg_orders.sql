select 
    -- generate a surrogate key
        {{ dbt_utils.generate_surrogate_key(['o.orderid', 'c.customerid', 'p.productid']) }} as sk_orders,
    -- from raw orders
        o.orderid, 
        o.orderdate, 
        o.shipdate, 
        o.shipmode,
        o.ordersellingprice,
        o.ordercostprice, 
        o.ordersellingprice - o.ordercostprice as orderprofit,
    -- from raw customer
        c.customerid,
        c.customername, 
        c.segment, 
        c.country,
    -- from raw product
        p.productid,
        p.category,
        p.productname,
        p.subcategory,
    -- calling the markup file which is created in macros by adding arguments
        {{ markup('ordersellingprice', 'ordercostprice') }} as markup,
    -- from delivery team
        d.delivery_team
from {{ ref('raw_orders') }} as o
    left join {{ ref('raw_customer') }} as c
        on o.customerid = c.customerid
    left join {{ ref('raw_product') }} as p
        on o.productid = p.productid
    left join {{ ref('delivery_team') }} as d
        on o.shipmode = d.shipmode
-- calling the macro at the end, because it is a where statement
{{limit_data_in_dev('orderdate')}}