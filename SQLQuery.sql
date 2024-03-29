

/*karam_259063*/
/*KARAM DALI*/
/*CLASS : C2*/
CREATE DATABASE SERVICECARD_DB_SHELL;

USE SERVICECARD_DB_SELL;

CREATE TABLE CAR 
(
	CAR_ID INT IDENTITY(1,1) PRIMARY KEY,
	CAR_NUMBER INT UNIQUE NOT NULL CHECK (CAR_NUMBER BETWEEN 00000 AND 99999),
	ENGINE_NUMBER INT NULL,
	CAR_CATEGORIE VARCHAR(2) NOT NULL CHECK ( CAR_CATEGORIE = 'PR' OR CAR_CATEGORIE = 'PB' OR CAR_CATEGORIE = 'T' OR CAR_CATEGORIE = 'D' OR CAR_CATEGORIE = 'R'),
	CAR_TYPE VARCHAR NULL,
	CAR_COLOR VARCHAR NULL,
	CARD_ID INT NOT NULL,
)

CREATE TABLE STAFF_INFO
(
	STAFF_ID INT IDENTITY(1,1) PRIMARY KEY,
	F_NAME VARCHAR(50),
	L_NAME VARCHAR(50),
	FATHER_NAME VARCHAR NULL,
	DB DATE NULL,
	NATIONAL_ID BIGINT UNIQUE NOT NULL CHECK (NATIONAL_ID BETWEEN 00000000000 AND 99999999999),
	ADR VARCHAR(50) NULL,
)

CREATE TABLE CARD_INFO
(
	CARD_ID INT IDENTITY(1,1) PRIMARY KEY,
	CREATION_DATE DATE NOT NULL,
	CARD_STATUS VARCHAR(20)NOT NULL CHECK (CARD_STATUS='SUPPORTED' OR CARD_STATUS='SUSPENDED' OR CARD_STATUS='NOTSUPPORTED'),
	CUSTUMER_ID INT,
)

CREATE TABLE CUSTUMER
(
	CUSTUMER_ID INT IDENTITY(1,1) PRIMARY KEY,
	F_NAME VARCHAR(50) NOT NULL,
	L_NAME VARCHAR(50) NOT NULL,
	DB DATE NULL,
	NATIONAL_ID BIGINT UNIQUE NOT NULL CHECK (NATIONAL_ID BETWEEN 00000000000 AND 99999999999),
	ADR VARCHAR(50) NULL,
	PHONE INT NULL CHECK (PHONE BETWEEN 0900000000 AND 0999999999),
)

CREATE TABLE SERVICE_MAIN
(
	SERVICE_NUMBER INT IDENTITY(1,1) PRIMARY KEY,
	CARD_ID INT NOT NULL,
	STR_DATE DATE NULL,
	END_DATE DATE NULL,
)

CREATE TABLE SERVICE_INFO
(
	SERVICE_ID INT IDENTITY(1,1) PRIMARY KEY,
	SERVICE_NAME VARCHAR(50) NOT NULL,
	QUANTITY INT NOT NULL,
	SERVICE_PRICE FLOAT NOT NULL,
	TOTAL_PRICE FLOAT NOT NULL,
	SERVICE_NUMBER INT NOT NULL
)

CREATE TABLE CART
(
	CART_ID INT IDENTITY(1,1) PRIMARY KEY,
	SERVICE_NUMBER INT NOT NULL,
	DATE_OF_CART DATE NULL,
	CARD_ID INT NOT NULL,
	TOTAL_PRICE FLOAT NOT NULL,
)

CREATE TABLE BILL
(
	BILL_ID INT IDENTITY(1,1) PRIMARY KEY,
	CART_ID INT NOT NULL,
	BILL_STATUS VARCHAR(10) NOT NULL CHECK (BILL_STATUS='PAID' OR BILL_STATUS='NOT PAID')
)

CREATE TABLE SERVICE_PROVIDER
(
	SERVICE_ID INT NOT NULL,
	STAFF_ID INT NOT NULL,
)

/* CREAT RELATION BETWEEN TABLES*/

ALTER TABLE CAR ADD CONSTRAINT FK_CARD_INFO_CARD_ID FOREIGN KEY (CARD_ID) REFERENCES CARD_INFO(CARD_ID) ON DELETE CASCADE;
ALTER TABLE CARD_INFO ADD CONSTRAINT FK_CUSTUMER_CUSTUMER_ID FOREIGN KEY (CUSTUMER_ID) REFERENCES CUSTUMER(CUSTUMER_ID) ON DELETE CASCADE;
ALTER TABLE SERVICE_MAIN ADD CONSTRAINT FK_CARD_INFO_CARD_ID2 FOREIGN KEY (CARD_ID) REFERENCES CARD_INFO(CARD_ID) ON DELETE CASCADE;
ALTER TABLE SERVICE_INFO ADD CONSTRAINT FK_SERVICE_MAIN_SERVICE_NUMBER FOREIGN KEY (SERVICE_NUMBER) REFERENCES SERVICE_MAIN(SERVICE_NUMBER) ON DELETE CASCADE;
ALTER TABLE CART ADD CONSTRAINT FK_SERVICE_MAIN_SERVICE_NUMBER2 FOREIGN KEY (SERVICE_NUMBER) REFERENCES SERVICE_MAIN(SERVICE_NUMBER) ON DELETE CASCADE;
ALTER TABLE CART ADD CONSTRAINT FK_CARD_INFO_CARD_ID3 FOREIGN KEY (CARD_ID) REFERENCES CARD_INFO(CARD_ID);
ALTER TABLE BILL ADD CONSTRAINT FK_CART_CART_ID FOREIGN KEY (CART_ID) REFERENCES CART(CART_ID) ON DELETE CASCADE;
ALTER TABLE SERVICE_PROVIDER ADD CONSTRAINT FK_SERVICE_INFO_SERVICE_ID FOREIGN KEY (SERVICE_ID) REFERENCES SERVICE_INFO(SERVICE_ID) ON DELETE CASCADE;
ALTER TABLE SERVICE_PROVIDER ADD CONSTRAINT FK_STAFF_INFO_STAFF_ID FOREIGN KEY (STAFF_ID) REFERENCES STAFF_INFO(STAFF_ID) ON DELETE CASCADE;

/*INPUT SOME TESTING DATA*/


INSERT INTO  CUSTUMER (F_NAME,L_NAME,NATIONAL_ID)
VALUES
	('MOHAMAD','ALI',42157589475),
	('TAMER','RAED',65257589475),
	('GEORGE','SALLOUM',78545214975),
	('WAEL','KHALIL',54178543675),
	('ISAM','HAJEH',97246854968),
	('JAMIL','JARADAT',24578541248);

INSERT INTO CARD_INFO (CREATION_DATE,CARD_STATUS,CUSTUMER_ID)
VALUES
	('2023-04-15','SUPPORTED',1),
	('2023-01-04','SUPPORTED',2),
	('2022-12-13','SUPPORTED',3),
	('2021-2-07','SUPPORTED',4),
	('2021-1-16','SUPPORTED',5),
	('2020-12-29','SUPPORTED',6),
	('2019-5-16','SUSPENDED',6);

INSERT INTO CAR (CAR_NUMBER,ENGINE_NUMBER,CAR_CATEGORIE,CARD_ID)
VALUES
	(41452,8541459,'PR',1),
	(51572,9875478,'PB',2),
	(61452,9612473,'PR',3),
	(71852,3541687,'D',4),
	(84452,8523697,'T',5),
	(91498,2541695,'PR',6),
	(17852,7412546,'PR',7);

INSERT INTO STAFF_INFO(F_NAME,L_NAME,NATIONAL_ID)
VALUES
	('SALIM','DAWOD',69585421365),
	('SAM','SALEH',78548569821);


/*DATE OF START AND END COLUMNS IN SERVICE_MAIN WILL BE NOT IGNORED TO SIMPLIFY THE EXAMPLE*/
INSERT INTO SERVICE_MAIN(CARD_ID)
VALUES
	(6),
	(5),
	(6),
	(1),
	(3),
	(4),
	(4);

INSERT INTO SERVICE_INFO (SERVICE_NAME,QUANTITY,SERVICE_PRICE,TOTAL_PRICE,SERVICE_NUMBER)
VALUES
	('FUEL',20,10,200,1), /*PR*/
	('FUEL',25,10,250,1),/*PR*/
	('FUEL',30,10,300,2), /* CAR_CATEGORIE = T*/
	('WASH',1,100,100,2),
	('MAINTENANCE',1,200,200,3),
	('FUEL',30,10,300,4),
	('WASH',1,100,100,4),
	('FUEL',45,10,450,5),
	('FUEL',20,10,200,6),
	('FUEL',10,10,100,7),
	('FUEL',20,10,200,7);

/*AGIAN THE DATE OF CART WILL BE IGNOREDAND SET TO NULL TO SIMPLIFY THE EXAMPLE*/
INSERT INTO CART(SERVICE_NUMBER,CARD_ID,TOTAL_PRICE)
VALUES
	(1,6,450),
	(2,5,400),
	(3,6,200),
	(4,1,400),
	(5,3,450),
	(6,4,200),
	(7,4,300);

INSERT INTO BILL(CART_ID,BILL_STATUS)
VALUES
	(1,'PAID'),/*THE BILL RELATED TO THE CART NUMBER 1 IS PAID*/
	(2,'NOT PAID'),
	(3,'PAID'),
	(4,'PAID'),
	(5,'PAID'),
	(6,'NOT PAID'),
	(7,'PAID');

INSERT INTO SERVICE_PROVIDER(SERVICE_ID,STAFF_ID)
VALUES
	(1,1),/*THE SERVICE THAT HOLD THE ID 1 FROM SERVICE_INFO TABLE HAS BEEN DONE BY THE STAFF WHO HOLD THE ID 1*/
	(2,1),
	(3,2),
	(4,2),
	(5,2),
	(6,1),
	(7,2),
	(8,1),
	(9,1),
	(10,1),
	(11,1);

/*VIEW THE NAME OF THE CUSTUMER ALONG SIDE HIS CARD, CAR NUMBER AND TYPE*/
SELECT CUSTUMER.F_NAME,L_NAME,CARD_INFO.CARD_ID, CAR.CAR_NUMBER,CAR.CAR_CATEGORIE
FROM CUSTUMER
INNER JOIN CARD_INFO
ON CUSTUMER.CUSTUMER_ID = CARD_INFO.CUSTUMER_ID
INNER JOIN CAR
ON CARD_INFO.CARD_ID = CAR.CARD_ID;

/*VIEW THE NAME OF THE CUSTUMER ALONG SIDE HIS CARD, CAR AND ENGINE NUMBER IF THE CARD IS SUPPORTED*/
SELECT CUSTUMER.F_NAME,L_NAME,CARD_INFO.CARD_ID, CAR.CAR_NUMBER, CAR.ENGINE_NUMBER
FROM CUSTUMER
INNER JOIN CARD_INFO
ON CUSTUMER.CUSTUMER_ID = CARD_INFO.CUSTUMER_ID
INNER JOIN CAR
ON CARD_INFO.CARD_ID = CAR.CARD_ID
WHERE CARD_INFO.CARD_STATUS = 'SUPPORTED';

/*VIEW THE TOTAL FUEL SELLED BY CARS CATEGORIE*/
SELECT SUM(QUANTITY) AS 'TOTAL FUEL BY CAR CATEGORIE', CAR.CAR_CATEGORIE
FROM SERVICE_INFO
INNER JOIN SERVICE_MAIN
ON SERVICE_MAIN.SERVICE_NUMBER = SERVICE_INFO.SERVICE_NUMBER
INNER JOIN CARD_INFO
ON CARD_INFO.CARD_ID = SERVICE_MAIN.CARD_ID
INNER JOIN CAR
ON CAR.CARD_ID = CARD_INFO.CARD_ID
WHERE SERVICE_INFO.SERVICE_NAME = 'FUEL'
GROUP BY (CAR.CAR_CATEGORIE);

/* CREATE ServiceCardView */

CREATE VIEW ServiceCardView
AS
SELECT CUSTUMER.F_NAME,L_NAME,CARD_INFO.CARD_STATUS
FROM
CUSTUMER
INNER JOIN CARD_INFO
ON CARD_INFO.CUSTUMER_ID = CUSTUMER.CUSTUMER_ID
 
 SELECT * FROM ServiceCardView

 /*COUNT THE NUMBER OF SERVICES DONE BY EACH STAFF MEMBER*/

 CREATE VIEW STAFF_PERFORMANCE
 AS
 SELECT COUNT(SERVICE_ID) AS 'NUMBER_OF_SERVICES',SERVICE_PROVIDER.STAFF_ID,STAFF_INFO.F_NAME, STAFF_INFO.L_NAME
 FROM SERVICE_PROVIDER
 INNER JOIN STAFF_INFO
 ON SERVICE_PROVIDER.STAFF_ID = STAFF_INFO.STAFF_ID
 GROUP BY SERVICE_PROVIDER.STAFF_ID,STAFF_INFO.F_NAME, STAFF_INFO.L_NAME ;
 
 SELECT * FROM STAFF_PERFORMANCE;

 /* VIEW THE SERVICE INFORMATION OF FUEL QUANTITY BIGGER THAN 20 LITER*/

 SELECT SUM(QUANTITY),SERVICE_NUMBER FROM SERVICE_INFO 
 WHERE SERVICE_NAME = 'FUEL'
 GROUP BY SERVICE_NUMBER
 HAVING SUM (QUANTITY)>20;

