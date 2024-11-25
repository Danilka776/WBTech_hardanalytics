with min_salaries as ( -- создаем вспомогательную таблицу с минимальной зп по отделу 
	select 
         industry,
         min(salary) as min_salary
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
    t3.first_name as name_ighest_sal  -- имя человека с минимальной зп из 3 таблицы
from 
    salary as t1
	inner join   -- присоединяем наши минимальные зп по отделам
    	min_salaries as t2
			on t1.industry = t2.industry
	inner join   -- ищем человека с минимальной зп в каждом отделе
    	salary as t3
			on t3.industry = t2.industry and t3.salary = t2.min_salary