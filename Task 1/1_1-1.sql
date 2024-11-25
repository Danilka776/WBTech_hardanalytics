select
    city,
    age,
    count(*) as count
from
    users
group by
    city,
    age
order by
    count desc;
