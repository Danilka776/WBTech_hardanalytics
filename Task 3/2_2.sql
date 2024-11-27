select 
    t1."DATE",
    t2."CITY",
    sum(t3."PRICE") / sum(sum(t3."PRICE")) over (partition by t1."DATE") as sum_SALES_REL
    -- sum(t3."PRICE") - суммарная стоимость товаров для каждого города в определенную дату
    -- sum(sum(t3."PRICE")) over (partition by t1."DATE")- вычисляем суммарные продажи по всем городам для каждой даты
from 
	sales as t1
		inner join shop as t2   -- соединяемся с таблицей чтоб получить город и адрес
			on t1."SHOPNUMBER" = t2."SHOPNUMBER" 
		inner join goods as t3   -- чтоб получить стоимость товаров
			on t1."ID_GOOD" = t3."ID_GOOD"
where 
	t3."CATEGORY" = 'ЧИСТОТА'   -- отбираем товары категории чистота
group by
	t1."DATE",
	t2."CITY"