with max_salaries as ( -- создаем вспомогательную таблицу с максимальной зп по отделу 
	select 
         industry,
         max(salary) as max_salary
     from 
         salary 
     group by 
         industry
)
select 
    t1.first_name,
    t1.last_name,
    t1.salary,
    t1.industry,
    t3.first_name as name_ighest_sal  -- имя человека с максимальной зп из 3 таблицы
from 
    salary as t1
	inner join   -- присоединяем наши максимальные зп по отделам
    	max_salaries as t2
			on t1.industry = t2.industry
	inner join   -- ищем человека с максимальный зп в каждом отделе
    	salary as t3
			on t3.industry = t2.industry and t3.salary = t2.max_salary