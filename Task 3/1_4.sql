select distinct
    first_name,
    last_name,
    salary,
    industry,
    -- используем оконную функцию для поиска минимальной зп в отделе и добавляем имя в итоговую таблицу
    first_value(first_name) over (partition by industry order by salary asc rows between unbounded preceding and unbounded following) as name_ighest_sal
from
    salary s 