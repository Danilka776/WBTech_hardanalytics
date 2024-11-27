select 
	t1."SHOPNUMBER",
	t2."CITY",
	t2."ADDRESS",
	count(t1."ID_GOOD") as SUM_QTY,  -- считаем количество товаров 
	sum(t3."PRICE") as SUM_QTY_PRICE  -- считаем сумму стоимости товаров
from 
	sales as t1
		inner join shop as t2   -- соединяемся с таблицей чтоб получить город и адрес
			on t1."SHOPNUMBER" = t2."SHOPNUMBER" 
		inner join goods as t3   -- чтоб получить стоимость товаров
			on t1."ID_GOOD" = t3."ID_GOOD"
where 
	"DATE" = '02.01.2016'  -- отбираем только за 2 января покупки
group by
	t1."SHOPNUMBER",  -- эти все столбцы однозначно идентифицируют друг друга
	t2."CITY",
	t2."ADDRESS" 