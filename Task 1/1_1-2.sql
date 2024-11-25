select
    city,
    case  -- в зависимости от возраста разделяем на категории
        when age between 0 and 20 then 'young'
        when age between 21 and 49 then 'adult'
        when age >= 50 then 'old'
    end as category,
    count(*) as count
from
    users
group by
    city,
    category
order by
    count desc;  -- сортируем по убыванию
