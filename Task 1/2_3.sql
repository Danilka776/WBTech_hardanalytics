with seller_data as ( -- создаем две временные вспомогательные таблицы
    select
        seller_id,
       	date(min(date_reg)) as min_date_reg, -- ищем дату регистрации как первую регистрацию по продавцу
        category,
        sum(revenue) as total_revenue  -- суммарная выручка (если для одной категории несколько полей)
    from
        sellers
    group by
        seller_id, category
),
filtered_sellers as (   -- отбираем нужный продавцов
    select
        seller_id,
        string_agg(category, ' - ' order by category) as category_pair,  -- доединяем категории через "-" в отсортированном виде
        sum(total_revenue) as total_revenue  -- суммарная выручка
    from
        seller_data
    where
    	date_part('year', min_date_reg) = 2022
    group by
        seller_id
    having
        count(distinct category) = 2
        and sum(total_revenue) > 75000
)
select
    seller_id,
    category_pair
from
    filtered_sellers