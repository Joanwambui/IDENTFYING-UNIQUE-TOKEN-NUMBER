-- Solution 1:
select token_num
from (select distinct * from tokens) t
group by token_num
having count(token_num) = 1
order by token_num 
limit 1



-- Solution 2:
select min(token_num) as token_num
from (
	select token_num
	from (
		select token_num, customer
		from tokens group by token_num, customer
		order by token_num) x 
	group by token_num	
	having count(1) = 1) y;



-- Solution 3:
select token_num
from (
	select token_num, customer
	from tokens group by token_num, customer
	order by token_num) x 
group by token_num	
having count(1) = 1
order by token_num 
limit 1;


-- Solution 4:
WITH cte AS (
    SELECT token_num, COUNT(DISTINCT(customer)) AS Count
    FROM tokens
    GROUP BY token_num
)

SELECT MIN(token_num) AS token_num
FROM cte
WHERE Count = 1;