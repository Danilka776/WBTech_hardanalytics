select
    category,
    ROUND(AVG(price), 2) as avg_price  -- берем среднее значение и округляем его до 2 знака
from
    products
where
    name ilike '%hair%' or name ilike '%home%'  -- отбираем только названия где есть hair и home (без учета регистра)
group by
    category
