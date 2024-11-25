select
    name,
    max(wait_time) as max_wait_time  -- выбираем максимальное время ожидания по каждому покупателю
from ( -- подзапрос, который находит время ожидания по каждому заказу
    select
      	customer_id,
        order_id,
        shipment_date::timestamp - order_date::timestamp as wait_time
    from
        orders
    where
    	order_status = 'Approved'  -- заказ должен быть подтвержден
) as t1 
inner join  -- возьмем по id имя покупателя
	customers as t2 on
		t1.customer_id = t2.customer_id
group by -- можно оставить оба, тк у них взаимооднозначное отображение
    t2.name,
    t1.customer_id
order by
    max_wait_time desc, -- сортируем по убыванию времени ожидания
    t1.customer_id   -- если таких несколько выберем с наименьшим id
limit 1;  -- берем одного с наибольшим временем ожидания
