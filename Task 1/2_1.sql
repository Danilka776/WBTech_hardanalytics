select
    seller_id,
    count(distinct category) as total_categ,  -- считаем различные категории
    round(avg(rating), 2) as avg_rating,  -- среднее значение рейтигна по категориям округленное до второго знака
    sum(revenue) as total_revenue, -- сумарный доход 
    case
        when count(distinct category) > 1 and sum(revenue) > 50000 then 'rich'
        when count(distinct category) > 1 then 'poor'
        else 'other' -- сюда попадут продавцы с 1 категорией
    end as seller_type  -- разбиение на категории
from
    sellers
where 
	category not ilike 'bedding'
group by
    seller_id  -- группируем по каждому продавцу
order by
    seller_id -- сортируем в порядке возрастания 
