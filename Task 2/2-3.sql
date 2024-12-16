with category_sales as ( -- общая сумма продаж для каждой категории
    select
        product_category,
        sum(order_ammount) as total_sum   -- считаем сумарную выручку
    from
        orders_2 t1
    		inner join 
        		products_2  t2 on 
        			t1.product_id = t2.product_id
    group by
        product_category
),
max_category as ( -- категория с наибольшей общей суммой продаж
    select
        product_category
    from
        category_sales
    where
        total_sum = (select max(total_sum) from category_sales) -- ищем категорию с наибольшей суммарной выручкой
),
product_max_sales as ( -- ищем продукт с максимальной суммой продаж по каждой категории
    select
        product_category,
        product_name,
        max(order_ammount) as max_sales
    from
        orders_2 t1
    		inner join 
        		products_2  t2 on 
        			t1.product_id = t2.product_id
    group by
        product_category, product_name
), 
product_max as (  -- отбираем нужные продукты в категории
	select
		product_category,
	    max(max_sales) as max_sales
	from
	    product_max_sales t2
	group by 
		product_category
)
select
    t1.product_category,
    t1.total_sum,
    t2.product_name as top_product,
    t2.max_sales
from
    category_sales t1
		inner join
    		product_max_sales t2 on 
    			t1.product_category = t2.product_category
    	inner join
    		product_max t3 on    -- из общей таблицы оставляем только продукты с максимальной суммарной стоимостью
    			t2.product_category = t3.product_category
    			and t2.max_sales = t3.max_sales

    			

