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


-->> SOLUTION 2: By creating a temporary unique id column (any RDBMS)

ALTER TABLE cars ADD COLUMN row_num int GENERATED ALWAYS AS identity;


delete from cars
where ctid in ( select max(ctid)
                from cars
                group by model, brand
                having count(*) > 1);

ALTER TABLE cars DROP COLUMN row_num;

-->> SOLUTION 3: By creating a backup table.



SELECT DISTINCT *
INTO 
dbo.carbkp
FROM
dbo.cars;
SELECT * FROM carbkp
DROP TABLE cars;
GO
EXEC sp_rename 'carbkp', 'cars';

-->> SOLUTION 4: By creating a backup table without dropping the original table.

SELECT DISTINCT *
INTO 
dbo.carbkp
FROM
dbo.cars;

SELECT * FROM carbkp;

TRUNCATE TABLE cars;

INSERT INTO cars 
SELECT DISTINCT * FROM carbkp
DROP TABLE carbkp;


