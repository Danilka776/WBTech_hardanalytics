with unsucc_sellers as ( -- создаем две временные вспомогательные таблица
    select
        seller_id,
        date(min(date_reg)) as min_date_reg,  -- ищем дату регистрации как первую регистрацию по продавцу
        max(delivery_days) as max_delivery_days,  -- максимальный срок доставки
        min(delivery_days) as min_delivery_days   -- минимальный срок доставки
    from
        sellers
    group by
        seller_id  -- для каждого продавца
    having
        count(distinct category) > 1 and sum(revenue) <= 50000 -- отбираем неуспешных
)
select
    seller_id,
    floor(date_part('day', now() - min_date_reg) / 30) as month_from_registration, -- разница в месяцах (30 дней) без дробной части
    (select max(max_delivery_days) from unsucc_sellers) - 
    	(select min(min_delivery_days) from unsucc_sellers) as max_delivery_difference -- подзапросы, которые ищут максимальный и минимальный срок доставки 
    	                                                                               -- среди всех выбранных продавцов (неуспешные)
from
    unsucc_sellers
order by
    seller_id
