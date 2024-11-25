select
    name,
    count(case when order_status = 'Approved' and shipment_date::timestamp > order_date::timestamp + interval '5 days' then 1 end) as delay_deliveries,
     -- подсчет количества подтвержденных заказов у которых срок ожидания был больше 5 дней
    count(case when order_status = 'Cancel' then 1 end) as canceled_orders, -- подсчет количества отмененых заказов 
    sum(order_ammount) as total_sum
from
    orders t1
	inner join  -- возьмем по id имя покупателя
		customers as t2 on
			t1.customer_id = t2.customer_id
group by
    name  -- делаем подсчеты для каждого клиента
order by
    total_sum desc  -- выводим в порядке убывания суммы заказа
