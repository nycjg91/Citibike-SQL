--!!!MAKE A TEMPORARY VIEW TABLE WITH AS SO THAT YOU CAN HAVE THE DATA CLEAN UP SUCH birth year with null and 1900S!!!!!

----count number of customer and subscriber
--*User Type (Customer = 24-hour pass (day pass) or 3-day pass user; Subscriber = Annual Member)
select count(*) as count, user_type
from citibike_2016
group by user_type;

select count(*) as count, user_type
from citibike_2017
group by user_type;

select count(*) as count, user_type
from citibike_2018
group by user_type;

select count(*) as count, user_type
from citibike_2019
group by user_type;


----count age group
--group by birth year
select birth_year, count(*) as count
from citibike_2016
group by birth_year;

select (birth_year)
from citibike_2019
order by birth_year asc

--group by age
select (DATE_PART('year', start_time) - birth_year) as age, count(*) as count
from citibike_2016
group by age;

---group by age range
select  count(*) as count,
user_type,
case
when DATE_PART('year', start_time) - birth_year between 70 and 85 then '70 and up'
when DATE_PART('year', start_time) - birth_year between 50 and 69 then '50 to 69'
when DATE_PART('year', start_time) - birth_year between 40 and 49 then '40 to 49'
when DATE_PART('year', start_time) - birth_year between 35 and 39 then '35 to 39'
when DATE_PART('year', start_time) - birth_year between 30 and 34 then '30 to 34'
when DATE_PART('year', start_time) - birth_year between 25 and 29 then '25 to 29'
when DATE_PART('year', start_time) - birth_year between 20 and 24 then '20 to 24'
when DATE_PART('year', start_time) - birth_year between 16 and 19 then '16 to 19'
else 'Not Given'
end as Age
from citibike_2016 
group by Age
, user_type
having user_type!='Null';


select  count(*) as count, 
user_type,
case
when DATE_PART('year', start_time) - birth_year between 70 and 85 then '70 and up'
when DATE_PART('year', start_time) - birth_year between 50 and 69 then '50 to 69'
when DATE_PART('year', start_time) - birth_year between 40 and 49 then '40 to 49'
when DATE_PART('year', start_time) - birth_year between 35 and 39 then '35 to 39'
when DATE_PART('year', start_time) - birth_year between 30 and 34 then '30 to 34'
when DATE_PART('year', start_time) - birth_year between 25 and 29 then '25 to 29'
when DATE_PART('year', start_time) - birth_year between 20 and 24 then '20 to 24'
when DATE_PART('year', start_time) - birth_year between 16 and 19 then '16 to 19'
else 'Not Given'
end as Age
from citibike_2017 
group by Age
, user_type



select  count(*) as count,
user_type,
case
when DATE_PART('year', start_time) - birth_year between 70 and 85 then '70 and up'
when DATE_PART('year', start_time) - birth_year between 50 and 69 then '50 to 69'
when DATE_PART('year', start_time) - birth_year between 40 and 49 then '40 to 49'
when DATE_PART('year', start_time) - birth_year between 35 and 39 then '35 to 39'
when DATE_PART('year', start_time) - birth_year between 30 and 34 then '30 to 34'
when DATE_PART('year', start_time) - birth_year between 25 and 29 then '25 to 29'
when DATE_PART('year', start_time) - birth_year between 20 and 24 then '20 to 24'
when DATE_PART('year', start_time) - birth_year between 16 and 19 then '16 to 19'
else 'Not Given'
end as Age
from citibike_2018 
group by Age
, user_type;

select  count(*) as count,
user_type,
case
when DATE_PART('year', start_time) - birth_year between 70 and 85 then '70 and up'
when DATE_PART('year', start_time) - birth_year between 50 and 69 then '50 to 69'
when DATE_PART('year', start_time) - birth_year between 40 and 49 then '40 to 49'
when DATE_PART('year', start_time) - birth_year between 35 and 39 then '35 to 39'
when DATE_PART('year', start_time) - birth_year between 30 and 34 then '30 to 34'
when DATE_PART('year', start_time) - birth_year between 25 and 29 then '25 to 29'
when DATE_PART('year', start_time) - birth_year between 20 and 24 then '20 to 24'
when DATE_PART('year', start_time) - birth_year between 16 and 19 then '16 to 19'
else 'Not Given'
end as Age
from citibike_2019 
group by Age
, user_type;

----* you may want to make line graph to show changes in number of age group each year by where the x-axis are year and y-axis are number, age group are series
----*but you will need to join with 17 18 and 19.

--'25 to 29' age: (2016, 332), (2017,4322), (2018, 7474), (2019,102)
--'20 to 24' age: (2016, 1223), (2017,234), (2018, 1094), (2019,4233)
--'16 to 19' age
---do something age bracket  then year

---gender count
--Gender (Zero=unknown; 1=male; 2=female)

select count(*), gender
from citibike_2016
group by gender;

select count(*), gender
from citibike_2017
group by gender;

select count(*), gender
from citibike_2018
group by gender;

select count(*), gender
from citibike_2019
group by gender;

----time duration
--finding mode count
with durat as( 
select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2016

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2017

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2018

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2019
order by dur desc)
SELECT dur, COUNT(dur) as freq
FROM durat
GROUP BY dur
order by freq desc;


---AVERAGE------
--finding avg (overall)

with durat as( 
select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2016

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2017

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2018

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2019
order by dur desc)
SELECT avg(dur)
FROM durat
--average is 745.63 seconds


--finding average with overextended time (30 min)
with durat as( 
select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2016

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2017

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2018

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2019
order by dur desc)
SELECT avg(dur)
FROM durat
where dur<1800;
---avg is 443.23 second


---finding average for subscriber with overextended
with durat as( 
select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2016
where user_type ilike '%subscriber%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2017
where user_type ilike '%subscriber%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2018
where user_type ilike '%subscriber%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2019
where user_type ilike '%subscriber%'

order by dur desc)
SELECT avg(dur)
FROM durat
where dur<2700;
---avg is 452.88 second


---finding average for customer with overextended
with durat as( 
select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2016
where user_type ilike '%customer%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2017
where user_type ilike '%customer%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2018
where user_type ilike '%customer%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2019
where user_type ilike '%customer%'

order by dur desc)
SELECT avg(dur)
FROM durat
where dur<1800;
--avg is 837.61 sec


 
 
 
 
 
 
---dur by grouping with subscribner

with durat as( 
select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2016
where user_type ilike '%subscriber%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2017
where user_type ilike '%subscriber%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2018
where user_type ilike '%subscriber%'

UNION 

select start_time, stop_time, extract(EPOCH from(stop_time-start_time)) as dur
from citibike_2019
where user_type ilike '%subscriber%'

order by dur desc)

SELECT *,
case
when dur<=600 then '10 min and under'
when dur<=1200 and dur>=601 then '11 min to 20 min'
when dur<=1800 and dur>=1201 then '21 min to 30 min'
when dur<=2400 and dur>=1801 then '31 min to 40 min'
when dur<=3000 and dur>=2401 then '41 min to 50 min'
when dur<=3600 and dur>=3001 then '61 min to 70 min'
when dur<=4200 and dur>=3601 then '71 min to 80 min'
when dur<=4800 and dur>=4201 then '81 min to 90 min'
when dur<=5400 and dur>=4801 then '91 min to 100 min'
when dur<=6000 and dur>=5401 then '101 min to 110 min'
when dur<=6600 and dur>=6001 then '111 min to 120 min'
else '121 min and over'
end as duration_group
FROM durat;











---time duration by group
select extract(EPOCH from(stop_time-start_time)) as dur, count (*)
from citibike_2016
group by dur

----joining citibike16 and station
select c16.*, cs.id, cs.latitude, cs.longitude, cs.name
from citibike_2016 c16  join citibike_stations cs on c16.end_station_id=cs.id
where c16.birth_year is not null
order by date(c16.start_time)


---FIND OUT WHICH STATION IS NEAR HOSP0ITAL OR UNIVERSITY
---for each year, look at top 5 max location (hotspot) (use end station) 





---who are the subsctriber



--patterns by observing historical record




----who are the riders that chose to pay indiviaual (or single rides), may need to do age group and gen der








