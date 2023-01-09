/* ##########################################################################
   <<<<>>>> Scenario 1: Data duplicated based on SOME of the columns <<<<>>>>
   ########################################################################## */

-- Requirement: Delete duplicate data from cars table. Duplicate record is identified based on the model and brand name.

drop table if exists cars;
create table cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40),
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (5, 'Model S', 'Tesla', 'Silver', 2018);
insert into cars values (6, 'Ioniq 5', 'Hyundai', 'Green', 2021);

select * from cars
order by model, brand


-->> SOLUTION 1: Delete using Unique identifier
DELETE FROM cars 
WHERE id IN(
			SELECT  MAX(id)
			FROM cars
			GROUP BY model, brand
			HAVING COUNT(*) >1)


-->> SOLUTION 5: Using backup table.

SELECT 
id,
model,
brand,
color,
make
INTO 
dbo.carbkp
FROM
dbo.cars
WHERE 1=2;
INSERT INTO carbkp
SELECT *
FROM Cars 
WHERE id  IN (
	SELECT min (id)
	FROM Cars
	Group BY MODEL , BRAND)
DROP TABLE Cars;
GO
EXEC sp_rename 'carbkp', 'cars';


-->> SOLUTION 6: Using backup table without dropping the original table.
SELECT 
id,
model,
brand,
color,
make
INTO 
dbo.carbkp
FROM
dbo.cars
WHERE 1=2;
INSERT INTO carbkp
SELECT *
FROM Cars 
WHERE id  IN (
	SELECT min (id)
	FROM Cars
	Group BY MODEL , BRAND);
TRUNCATE TABLE cars;
INSERT INTO cars 
SELECT *FROM carbkp

DROP TABLE carbkp;



/* ##########################################################################
   <<<<>>>> Scenario 2: Data duplicated based on ALL of the columns <<<<>>>>
   ########################################################################## */

-- Requirement: Delete duplicate entry for a car in the CARS table.

drop table if exists cars;
create table cars
(
    id      int,
    model   varchar(50),
    brand   varchar(40), 
    color   varchar(30),
    make    int
);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (2, 'EQS', 'Mercedes-Benz', 'Black', 2022);
insert into cars values (3, 'iX', 'BMW', 'Red', 2022);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);
insert into cars values (1, 'Model S', 'Tesla', 'Blue', 2018);
insert into cars values (4, 'Ioniq 5', 'Hyundai', 'White', 2021);

select *  from cars
ORDER BY model, brand;


-->> SOLUTION 1: Delete using CTID (postgresql)/ ROWID (in Oracle)

delete from cars
where ctid in ( select max(ctid)
                from cars
                group by model, brand
                having count(*) > 1);


-->> SOLUTION 2: Using SELF join
DELETE FROM cars 
WHERE id IN( 
		select c2.id
		from cars c1
		join cars c2 on c1.model = c2.model and c1.brand = c2.brand
		where c1.id < c2.id
)




-->> SOLUTION 3: Using Window function
DELETE FROM cars
WHERE id IN(
		   SELECT id
		   FROM (
			SELECT *
			, ROW_NUMBER() over (PARTITION BY MODEL , BRAND ORDER BY MODEL , BRAND) AS RN
			FROM Cars) F
	WHERE F.RN >1)



-->> SOLUTION 4: Using MIN function. This delete even multiple duplicate records.
	DELETE FROM Cars 
	WHERE id NOT IN (
			SELECT min (id)
			FROM Cars
			Group BY MODEL , BRAND)


