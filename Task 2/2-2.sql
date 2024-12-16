with category_sales as ( -- общая сумма продаж для каждой категории
    select
        product_category,
        sum(order_ammount) as total_sum   -- считаем суммарную выручку
    from
        orders_2 t1
    		inner join 
        		products_2  t2 on 
        			t1.product_id = t2.product_id
    group by
        product_category
)
select
    product_category
from
    category_sales
where
    total_sum = (select max(total_sum) from category_sales)  -- ищем категорию с наибольшей суммарной выручкой
