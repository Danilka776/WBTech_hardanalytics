select -- общая сумма продаж для каждой категории
    product_category,
    sum(order_ammount) as total_sum   -- считаем сумарную выручку
from
    orders_2 t1
		inner join 
    		products_2  t2 on 
    			t1.product_id = t2.product_id
group by
    product_category
