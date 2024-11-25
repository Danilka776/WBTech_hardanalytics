with data_table as ( -- содаем временную таблицу с подсчетами
    select
        customer_id,
        count(order_id) as count_orders,  -- считаем количество заказов у клиента
        round(avg(extract(day from shipment_date::timestamp - order_date::timestamp)), 2) as avg_delivery_time_days, --среднее кол-во дней ожидания
        sum(order_ammount) as total_sum  -- самма всех заказов у клиента
    from
        orders
    where
    	order_status = 'Approved'  -- рассматриваем только подтвержденные заказы
    group by
        customer_id  -- группируем по каждому клиенту
)
select
    name,
    count_orders,
    avg_delivery_time_days,
    total_sum
from
    data_table t1 
	inner join  -- возьмем по id имя покупателя
		customers as t2 on
			t1.customer_id = t2.customer_id
where
    count_orders = (
        select max(count_orders) from data_table  -- оставляем только клиентов с максимальным кол-вом заказов
    )
order by
    total_sum desc  -- порядок убывания общей суммы заказов


