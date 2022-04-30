-- procedure created with arguments name_of_object & type_of_object (Table or Sequence) to remove the object everytime the script runs
    /*
    @param name_of_object VARCHAR2
    @param type_of_object VARCHAR2
    */
CREATE OR REPLACE PROCEDURE remove_objects (
    name_of_object VARCHAR2,
    type_of_object VARCHAR2
) IS
    cnt NUMBER := 0;
BEGIN
    IF upper(type_of_object) = 'TABLE' THEN
        SELECT
            COUNT(*)
        INTO cnt
        FROM
            user_tables
        WHERE
            upper(table_name) = upper(TRIM(name_of_object));

        IF cnt > 0 THEN
            EXECUTE IMMEDIATE 'drop table ' || name_of_object || ' cascade constraints';
        END IF;
    END IF;

    IF upper(type_of_object) = 'SEQUENCE' THEN
        SELECT
            COUNT(*)
        INTO cnt
        FROM
            user_sequences
        WHERE
            upper(sequence_name) = upper(name_of_object);

        IF cnt > 0 THEN
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || name_of_object;
        END IF;
    END IF;

END;
/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the Admin Table

CALL remove_objects('Admin', 'Table');
CREATE TABLE ADMIN
(
    SYSTEM_ID NUMBER(10) CONSTRAINT SYSTEM_PK PRIMARY KEY, -- primary key column
    NAME VARCHAR(16) NOT NULL UNIQUE,
    USERNAME VARCHAR(45) NOT NULL,
    PASWORD VARCHAR(45) NOT NULL UNIQUE,
    CONTACT NUMBER(10) NOT NULL,
    EMAIL_ID VARCHAR(50) NOT NULL UNIQUE
);

-- calling the procedure "remove_objects" to remove the admin_system_id SEQUENCE

CALL remove_objects('admin_system_id', 'SEQUENCE');
CREATE SEQUENCE admin_system_id START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the ENTITY_EMPLOYEE Table

CALL remove_objects('ENTITY_EMPLOYEE', 'Table');
CREATE TABLE ENTITY_EMPLOYEE
(
    EMPLOYEE_ID NUMBER(10) CONSTRAINT ENTITY_EMPLOYEE_PK PRIMARY KEY, -- primary key column
    NAME VARCHAR(45) NOT NULL,
    CONTACT NUMBER(10) NOT NULL,
    EMAIL_ID VARCHAR(50) NOT NULL UNIQUE,
    SYSTEM_ID NUMBER(10)NOT NULL CONSTRAINT EMP_ADMIN_FK REFERENCES ADMIN(SYSTEM_ID)
);

-- calling the procedure "remove_objects" to remove the ENTITY_EMPLOYEE_ID SEQUENCE

CALL remove_objects('ENTITY_EMPLOYEE_ID', 'SEQUENCE');
CREATE SEQUENCE ENTITY_EMPLOYEE_ID START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the Company Table

CALL remove_objects('Company', 'Table');
CREATE TABLE Company(
    COMPANY_CODE NUMBER(10) CONSTRAINT COMPANY_PK PRIMARY KEY,
    COMPANY_NAME VARCHAR(50) NOT NULL UNIQUE,
    LICENSE_NUMBER VARCHAR(12) NOT NULL UNIQUE,
    CREATED_DATE DATE NOT NULL,
    SYSTEM_ID NUMBER(10) NOT NULL CONSTRAINT CMP_ADMIN_FK REFERENCES ADMIN(SYSTEM_ID)
    );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the INSURANCE_POLICIES Table

-- calling the procedure "remove_objects" to remove the INSURANCE_POLICIES Table

CALL remove_objects('INSURANCE_POLICIES', 'Table');   
CREATE TABLE INSURANCE_POLICIES(
    POLICY_NUMBER NUMBER(10) CONSTRAINT IP_PK PRIMARY KEY,
    POLICY_TYPE VARCHAR(50) NOT NULL,
    PREMIUM NUMBER(8) NOT NULL,
    C_CODE NUMBER(10) NOT NULL CONSTRAINT IP_CMP_FK REFERENCES COMPANY(COMPANY_CODE),
    TIME_PERIOD VARCHAR(5) NOT NULL,
    SUM_ASSUARED NUMBER(8) NOT NULL,
    POLICY_BENEFITS VARCHAR(255) NOT NULL
    );
    
    
     
CALL remove_objects('Customer', 'Table');    
CREATE TABLE Customer(
    Customer_id NUMBER(10) CONSTRAINT Customer_PK PRIMARY KEY,
    Customer_NAME VARCHAR(50) NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Contact VARCHAR2(12) NOT NULL,
    policy_number CONSTRAINT Cust_PN_FK REFERENCES INSURANCE_POLICIES(POLICY_NUMBER),
    Premium NUMBER(8) Unique,
    Employee_id NOT NULL CONSTRAINT Cust_EMP_FK REFERENCES entity_employee(Employee_ID),
    card_id number(10) NOT NULL UNIQUE ,
    Status Varchar2(5),
    Login_email Varchar2(50) NOT NULL UNIQUE,
    Password Varchar2(50) NOT NULL UNIQUE,
    Gender Varchar(20),
    City Varchar(20),
    Street Varchar(20),
    State Varchar(20),
    Zipcode Number(20)
    );
-- calling the procedure "remove_objects" to remove the Card_Details Table 

CALL remove_objects('Card_Details', 'Table');
    Create Table Card_Details(
  CID Number(10) Not Null  CONSTRAINT CID_PK PRIMARY KEY,
  CARD_NAME VARCHAR2(50) Not Null Unique,
  CARD_NUMBER VARCHAR2(16) Not Null,
  EXPIRY_DATE Date Not Null,
  CVV Number(10) Not Null

); 
 



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the policy_prerequisites Table

CALL remove_objects('policy_prerequisites', 'Table');
create table policy_prerequisites(
Policy_prerequisite_test_code NUMBER(10) CONSTRAINT PREREQ_PK PRIMARY KEY,
Policy_number NOT NULL CONSTRAINT Prereq_policy_FK REFERENCES insurance_policies(POLICY_NUMBER),
Prerequisite_disease VARCHAR2(100) Not NULL,
Prerequisite_test_name Varchar2(100) Not Null,
Status Varchar2(5));

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the HOSPITAL Table

CALL remove_objects('HOSPITAL', 'Table');
CREATE table HOSPITAL(
    HOSPITAL_ID NUMBER(10) CONSTRAINT HOSPITAL_PK PRIMARY KEY,
    H_NAME VARCHAR(55) NOT NULL UNIQUE,
    ADDRESS VARCHAR(255) NOT NULL UNIQUE,
    IS_NETWORK CHAR(1) check(IS_NETWORK in('Y','N'))
    );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the LAB_ORDER_LINE Table
    
CALL remove_objects('LAB_ORDER_LINE', 'Table');      
CREATE TABLE LAB_ORDER_LINE(
    LABID NUMBER(10) CONSTRAINT LABID_PK PRIMARY KEY,
    HOSPITAL_ID NUMBER(10)CONSTRAINT HOSPITALID_FK REFERENCES hospital(HOSPITAL_ID),
    CUSTOMER_ID NUMBER(10)  CONSTRAINT CUSTOMERID_FK REFERENCES customer(CUSTOMER_ID),
    PRE_REQUISITE_TEST_CODE NUMBER(6) NOT NULL CONSTRAINT PREREQ_FK REFERENCES policy_prerequisites(Policy_prerequisite_test_code),
    PRICE NUMBER(10) NOT NULL 
    );


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the ENTITY_BILLING Table

CALL remove_objects('ENTITY_BILLING', 'Table');
CREATE TABLE ENTITY_BILLING(

    BILL_ID  NUMBER(10) CONSTRAINT BILL_PK PRIMARY KEY,
    TRANSACTION_ID NUMBER(10) NOT NULL UNIQUE,
    BILL_AMMOUNT FLOAT(20) NOT NULL,
    TIME_STAMP DATE NOT NULL,
    CUSTOMER_ID NUMBER(10) UNIQUE CONSTRAINT CUSTOMER_ID_FK REFERENCES Customer(Customer_id),
    POLICY_ID NUMBER(10)  CONSTRAINT POLICY_ID_FK REFERENCES insurance_policies(POLICY_NUMBER),
    LAB_ID NUMBER(10) CONSTRAINT LAB_ID_FK REFERENCES lab_order_line(LABID)
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- calling the procedure "remove_objects" to remove the TRANSACTION_ENTITY Table
CALL remove_objects('TRANSACTION_ENTITY', 'Table');
CREATE TABLE TRANSACTION_ENTITY(

    TRANSACTION_ID  NUMBER(10) CONSTRAINT TRANSACTION_PK PRIMARY KEY,
    TRANSACTION_TYPE VARCHAR(30) NOT NULL UNIQUE,
    TIME_STAMP DATE NOT NULL,
    STATUS CHAR(1) check(STATUS in('Y','N')),
    CUSTOMER_ID NUMBER(10) UNIQUE NOT NULL CONSTRAINT CUSTOMER_ID_FK_TRANSACTION REFERENCES ENTITY_BILLING(CUSTOMER_ID) ,
    ISSUED_AMOUNT NUMBER(20) NOT NULL 
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Logan Asher','Logan','Q1On6wiQdyvUNITJ2hjfV3RrK66u8ejjKR4I22LQvrteq',1083651275,'Logan_Asher5776@womeona.net');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Kieth Booth','Kieth','yR9OLJ5OKQAVSunJxB4rIv6wGi1ogiVZLb7ZuPfGTjyur',1685963309,'Kieth_Booth3439@gembat.biz');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Mary Dyson','Mary','Qsl4lJ1xOYhfyYj6LE80SpTw003t3EiH2xD1M0G80vvyO',7052831405,'Mary_Dyson3994@hourpy.biz');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Raquel Lee','Raquel','I3J0anAUrtV8A9g4eh0G9lx4a7FwccXvVss2l7yVtiaXy',8146700381,'Raquel_Lee989@eirey.tech');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Peter Pearson','Peter','O2PVknRRnSgteXbLZGRxRSviFhrcLwWhUxfqLBOg1f0XX',2935586850,'Peter_Pearson1180@nimogy.biz');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Bart Callan','Bart','yF169Yr2uAY2v5vbXLgyao0GNYpgjievLkDa9bXKBZDUS',4449590156,'Bart_Callan2441@bauros.biz');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Blake Maxwell','Blake','LSMgnrK2Vc6xWwBkfx7A5BFz8B6F2KOrwb0G1ypjN1JBx',2371945914,'Blake_Maxwell2171@gmail.com');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Andrea Alexander','Andrea','FAKNOB465srIXxE2DCRpflRbR5Koq2eREyH08yiqcfi2B',6223834316,'Andrea_Alexander7229@brety.org');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Dani Cavanagh','Dani','QPCNZEipN4OdkM9CZadhW5ZsKBHjoHP2PzLPgoltzJfX5',3668999739,'Dani_Cavanagh8542@bretoux.com');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Molly Jarrett','Molly','9BFpWOvBuguyusNaBxSWYUNy6adU0YNlNw0HZsjm3se4j',9214641544,'Molly_Jarrett8088@twipet.com');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Carter Dale','Carter','bKWTIk72FATNqdq0SPbsaC6jr1LOMTI9n2biHla3uLM3f',7146962651,'Carter_Dale2192@naiker.biz');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Anabel Andrews','Anabel','tqv2UkyBIsqyh7P0CDYxmXYxFrahCUU9JeBfaAKsQgsEy',5508187482,'Anabel_Andrews2781@infotech44.tech');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Adina Jordan','Adina','Q8yYrpC6uaC2qgFoU917LceJkwpspNcNhjAh4pHirSUHI',3764398151,'Adina_Jordan4845@muall.tech');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Daniel Owen','Daniel','UQg8yUHghto1TP2IXBtQrB7RdS1lMDQ1MiWByITgYaI8S',2826479010,'Daniel_Owen3103@eirey.tech');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Clint Rixon','Clint','gTedxpu30UOrN1Q299Wqbhh7nxiPDsinxC2Gofeb0gNV1',2542126877,'Clint_Rixon7772@womeona.net');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Kieth Wright','Kieth','f0Ivk3K9KOee5z4TMFr6wOmYSf7B3UHofUVqFjRCqw1Mz',8056519433,'Kieth_Wright2219@brety.org');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Roger Brooks','Roger','JGzGz8kdNOnyoQ9WajfS74NvqfbAEcVGLGgqBGAxmg3b6',9194417045,'Roger_Brooks8751@dionrab.com');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Janice Norburn','Janice','jYu2gmitTUTisqbAwyEBoqKpLJZIRy7qrQCHIiaA5EAjd',5462383723,'Janice_Norburn2318@deons.tech');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Tara Jenkins','Tara','ZbfXn1bnT2NYEGkplLj4TmCsrVZYJ3C1DwgmfL0uxcNW1',5204953390,'Tara_Jenkins4089@naiker.biz');
INSERT INTO ADMIN VALUES(admin_system_id.NEXTVAL,'Jayden Bradshaw','Jayden','DeazWURj8KZUzH1Zq0zEOG5QItl3tMsejSu7wgfgAlTCN',3276373820,'Jayden_Bradshaw5621@nanoff.biz');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Logan Asher', 1083651275, 'Logan_Asher5776@womeona.net',1);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Kieth Booth',1685963309,'Kieth_Booth3439@gembat.biz',2);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Mary Dyson',7052831405,'Mary_Dyson3994@hourpy.biz',3);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Raquel Lee',8146700381,'Raquel_Lee989@eirey.tech',4);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Peter Pearson',2935586850,'Peter_Pearson1180@nimogy.biz',5);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Bart Callan',4449590156,'Bart_Callan2441@bauros.biz',6);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Blake Maxwell',2371945914,'Blake_Maxwell2171@gmail.com',7);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Andrea Alexander',6223834316,'Andrea_Alexander7229@brety.org',8);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Dani Cavanagh',3668999739,'Dani_Cavanagh8542@bretoux.com',9);
INSERT INTO ENTITY_EMPLOYEE VALUES(ENTITY_EMPLOYEE_ID.NEXTVAL,'Molly Jarrett',9214641544,'Molly_Jarrett8088@twipet.com',10);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO Company VALUES('1', 'AECOM',	'3496b865-dfd',	'11-MAY-08',	'11');    
INSERT INTO Company VALUES('2',	'Telekom',	'd96c046c-b4b',	'03-AUG-09',	'12');
INSERT INTO Company VALUES('3',	'Comcast',	'02580bd2-afe',	'01-JAN-19',	'13');
INSERT INTO Company VALUES('4',	'Vodafone',	'dcfdbca0-60f',	'06-DEC-18',	'14');
INSERT INTO Company VALUES('5',	'Mars',	'108ae5e2-8a',	'20-AUG-06',	'15');
INSERT INTO Company VALUES('6',	'Biolife Grup',	'45b3c506-94b',	'11-APR-17',	'16');
INSERT INTO Company VALUES('7',	'Demaco',	'c08ab180-92a',	'10-NOV-07',	'17');
INSERT INTO Company VALUES('8',	'Zepter',	'35fe0d76-917',	'30-SEP-03',	'18');
INSERT INTO Company VALUES('9',	'UPC',	'be340542-1b',	'09-NOV-15',	'19');
INSERT INTO Company VALUES('10',	'Carrefour',	'ea47d3df-79d',	'07-OCT-17',	'20');

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO Insurance_policies VALUES(1,'Private',500,1,'1y',50000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(2,'Public',300,1,'2y',40000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(3,'Government',100,1,'3y',30000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(4,'Private',500,2,'1y',45000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(5,'Public',300,2,'1y',35000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(6,'Government',70,2,'1y',25000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(7,'Private',450,3,'1y',40000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(8,'Public',250,3,'2y',32000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(9,'Government',150,3,'2y',30000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(10,'Private',550,4,'2y',60000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(11,'Public',340,4,'1y',30000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(12,'Government',120,4,'1y',10000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(13,'Private',440,5,'1y',50000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(14,'Public',240,5,'1y',30000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(15,'Government',140,5,'1y',10000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(16,'Private',540,6,'3y',65000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(17,'Public',340,6,'2y',45000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(18,'Government',140,6,'1y',35000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(19,'Private',500,7,'1y',45000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(20,'Public',300,7,'1y',36000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(21,'Government',100,7,'1y',16000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(22,'Private',600,8,'3y',66000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(23,'Public',400,8,'2y',36000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(24,'Government',200,8,'1y',15000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(25,'Private',430,9,'1y',56000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(26,'Public',230,9,'1y',26000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(27,'Government',130,9,'1y',10000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(28,'Private',730,10,'3y',76000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(29,'Public',530,10,'3y',56000,'Health insurance protects you from unexpected, high medical costs.' );
INSERT INTO Insurance_policies VALUES(30,'Government',330,10,'3y',36000,'Health insurance protects you from unexpected, high medical costs.' );

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO card_details VALUES('1','Makenzie Richardson','7123576431937452','12-aug-2022','263');
INSERT INTO card_details VALUES('2','Peter Addis','2582678692687262','4-nov-2024','260');
INSERT INTO card_details VALUES('3','Wade Appleton','2525487267979379','18-oct-2023','422');
INSERT INTO card_details VALUES('4','Lynn Young','5798689367998294','2-jan-2024','499');
INSERT INTO card_details VALUES('5','Lindsay Clark','2687658973857093','12-feb-2024','366');
INSERT INTO card_details VALUES('6','Raquel Carpenter','5798798173875573','4-aug-2024','973');
INSERT INTO card_details VALUES('7','Moira Denton','5793897507085093','12-july-2022','903');
INSERT INTO card_details VALUES('8','Sebastian Rycroft','8927409860820026','4-nov-2025','143');
INSERT INTO card_details VALUES('9','Sebastian Morrison','6789287687208332','24-dec-2023','711');
INSERT INTO card_details VALUES('10','Rocco Tailor','2556268783783783','9-nov-2024','424');
INSERT INTO card_details VALUES('11','Tyson Chappell','5361698471974161','18-aug-2023','243');
INSERT INTO card_details VALUES('12','Makena Willis','1967366532631651','14-nov-2025','223');
INSERT INTO card_details VALUES('13','Mark Richardson','1647817508150823','8-oct-2024','452');
INSERT INTO card_details VALUES('14','Angelina Young','1581750838048048','12-jan-2023','649');
INSERT INTO card_details VALUES('15','Cadence Blackburn','6591598759874975','2-feb-2025','246');
INSERT INTO card_details VALUES('16','Rick Bright','5789228084257654','14-aug-2025','943');
INSERT INTO card_details VALUES('17','Domenic Knight','8197592797297522','8-july-2023','833');
INSERT INTO card_details VALUES('18','Amelia Phillips','7592759792792793','14-nov-2024','192');
INSERT INTO card_details VALUES('19','Kirsten Bell','2569826929952692','18-dec-2025','744');
INSERT INTO card_details VALUES('20','Victoria Hood','6856826592797592','19-nov-2024','444');
INSERT INTO card_details VALUES('21','Caleb Shields','2965265828386586','22-may-2024','853');
INSERT INTO card_details VALUES('22','Alan Wild','5625927597297297','1-oct-2024','456');
INSERT INTO card_details VALUES('23','Audrey Cox','1759739759379379','18-jan-2025','789');
INSERT INTO card_details VALUES('24','Ada James','1649179719794171','12-aug-2025','234');
INSERT INTO card_details VALUES('25','Cassandra Benfield','5619765917917511','7-april-2025','732');
INSERT INTO card_details VALUES('26','Lucas Bradshaw','3875983725698723','4-july-2026','678');
INSERT INTO card_details VALUES('27','Leanne Davies','1867592759759729','29-july-2025','433');
INSERT INTO card_details VALUES('28','Michael Knight','6972857785975392','24-may-2025','199');
INSERT INTO card_details VALUES('29','Susan Rosenbloom','8695619591791563','4-may-2025','469');
INSERT INTO card_details VALUES('30','Erick Anderson','1786592837037953','19-may-2024','696');


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(1,'Makenzie Richardson','22-AUG-93','612-334-4325', 1,1,'Makenzie_Richardson2063657414@twipet.com','Northeastern@21', 'M',	'New York',	'12 Smith Street',	'NY',	'02314');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(2, 'Peter Addis', '31-MAY-95', '478-544-2613', 2,2, 'Peter_Addis1226906224@grannar.com',	'Northeastern@22', 'M',	'New Jersy', '23 Warner Street',	'NJ',	'01124');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(3,	'Wade Appleton',	'10-APR-91',	'027-766-6064',			3,3,			'Wade_Appleton2129676548@gompie.com',	'Northeastern@23', 'M',	'San Diego',	'37 Stephan Street',	'CA',	'01244');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(4,	'Lynn Young	',	'09-MAR-91',	'313-661-0666',				3,	4,		'Lynn_Young1049801551@guentu.biz',	'Northeastern@24', 'M',	'Boston', '58 QA Street',	'MA',	'02215');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(5,	'Lindsay Clark ',	'24-DEC-99',	'682-072-2573',				5,	5,		'Lindsay_Clark1937253766@elnee.tech',	'Northeastern@25', 'F',	'Atlanta',	'15 Heisenberg Street',	'GA',	'01456');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(6,	'Raquel Carpenter ', '19-FEB-89',	'177-408-6173', 6,6,			'Raquel_Carpenter1337250263@nimogy.biz',	'Northeastern@26', 'F',	'Worchester',	'45 RM Street',	'MA',	'01145');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(7,	'Moira Denton ',	'18-FEB-06',	'035-486-5082',				7,	7,		'Moira_Denton1621390545@gmail.com',	'Northeastern@27', 'F',	'Boston',	'Park Drive',	'MA',	'01425');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(8,	'Sebastian Rycroft',	'18-JUL-96',	'425-716-0817',				8,	8	,	'Sebastian_Rycroft812483468@brety.org',	'Northeastern@28', 'M',	'Lowell',	'13 Stark Street',	'MA',	'01225');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(9,	'Sebastian Morrison	',	'23-FEB-91',	'021-844-0144',			9,9,			'Sebastian_Morrison1065165198@bretoux.com',	'Northeastern@29', 'M',	'Dallas',	'JA Park',	'TX',	'14562');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(10,	'Rocco Tailor ', '20-APR-04',	'624-800-5275',			10,		10,	'Rocco_Tailor1689568041@bulaffy.com',	'Northeastern@30', 'M',	'Austin',	'OT Street',	'TX',	'01245');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(11,	'Tyson Chappell	', '01-FEB-87',	'546-987-6569',				2,11,			'Tyson_Chappell888199334@jiman.com',	'Northeastern@31', 'M',	'Chicago',	'NW Street',	'IL',	'01451');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(12,	'Makena Willis',	'01-JUL-03',	'235-564-6564'	,			1,12,			'Makena_Willis585382553@gompie.com',	'Northeastern@32', 'F',	'Seattle',	'JFK Street',	'WA',	'01052');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(13,	'Mark Richardson ',	'09-SEP-96',	'789-564-2122',				5,		13,	'Mark_Richardson1680930294@irrepsy.com',	'Northeastern@33', 'M',	'San Jose',	'SJSU Street',	'CA',	'02312');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(14,	'Angelina Young',	'05-APR-01',	'457-897-2465',			6,14,			'Angelina_Young1883813933@cispeto.com',	'Northeastern@34', 'F',	'Las Vegas',	'LV Street',	'NV',	'01455');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(15,	'Cadence Blackburn	',	'12-MAY-02',	'789-987-8521',			6,15,			'Cadence_Blackburn1943268910@extex.org',	'Northeastern@35', 'F',	'Penuelas',	'PR Street',	'PR',	'01245');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(16,	'Rick Bright',	'17-SEP-08',	'487-561-8965',				2,	16,		'Rick_Bright47520000@joiniaa.com',	'Northeastern@36', 'M',	'Sharon',	'SP Street',	'MA',	'04521');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(17,	'Domenic Knight ',	'04-JAN-95',	'124-897-9860',			2,	17,		'Domenic_Knight2002797611@naiker.biz',	'Northeastern@37', 'M',	'Troy',	'TD Street',	'NH',	'01451');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(18,	'Amelia Phillips',	'04-MAY-98',	'124-569-8000',				5,	18,		'Amelia_Phillips82892398@vetan.org',	'Northeastern@38', 'F',	'Lisbon',	'LT Street',	'NH',	'15463');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(19,	'Kirsten Bell ',	'06-MAY-99',	'781-589-9632',				4	,	19,	'Kirsten_Bell793718949@brety.org',	'Northeastern@39', 'F',	'Blaine',	'BG Street',	'ME',	'01452');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(20,	'Victoria Hood ',	'08-MAR-95',	'123-456-7890',				4,20,			'Victoria_Hood1734072221@gembat.biz',	'Northeastern@40', 'F',	'Fairfax',	'VT Street',	'VT',	'04512');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(21,	'Caleb Shields ',	'02-OCT-98',	'458-965-8521',			2,	21,		'Caleb_Shields401362496@cispeto.com',	'Northeastern@41', 'M',	'Red Bank',	'RB Street',	'NJ',	'01478');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(22,	'Alan Wild',	'07-SEP-03',	'124-965-8965',			6,	22,		'Alan_Wild780471328@hourpy.biz',	'Northeastern@42', 'M',	'Brooklyn',	'Watt Street',	'NY',	'01452');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(23,	'Audrey Cox	',	'05-JUN-91',	'785-654-9632',			6,	23,		'Audrey_Cox413450124@ubusive.com',	'Northeastern@43', 'F',	'Holmes',	'Roxbury',	'NY',	'01452');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(24, 'Ada James',	'08-FEB-85',	'784-569-3215',				6,	24,		'Ada_James316668414@bretoux.com',	'Northeastern@44', 'F',	'Robinson',	'TS Street',	'PA',	'07896');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, DATE_OF_BIRTH, CONTACT,EMPLOYEE_ID,card_id,login_email,Password, Gender, City, Street, State, Zipcode)
    VALUES(25,	'Cassandra Benfield',	'06-JAN-98',	'125-963-7895',			6,25,			'Cassandra_Benfield1367201885@sheye.org',	'Northeastern@45', 'F',	'Butler',	'BCG Street',	'PA',	'04213');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME,  DATE_OF_BIRTH, CONTACT,policy_number,premium ,EMPLOYEE_ID,card_id,status,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (26,'Lucas Bradshaw', '17-AUG-87','458-963-4521',14,240,4,26,'Wait','Lucas_Bradshaw418027303@bauros.biz','Northeastern@46', 'M',	'Reston',	'LA Street',	'VA',	'04451');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME,  DATE_OF_BIRTH, CONTACT,policy_number,premium ,EMPLOYEE_ID,card_id,status,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (27,'Leanne Davies', '11-NOV-05','564-986-3215',10,550,2,27,'Done','Leanne_Davies1656102163@acrit.org','Northeastern@51', 'M',	'Laurel',	'MG Street',	'MD',	'21453');  
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME,  DATE_OF_BIRTH, CONTACT,policy_number,premium ,EMPLOYEE_ID,card_id,status,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (28,'Michael Knight', '01-FEB-89','456-963-7115',28,730,7,28,'Done','Michael_Knight865421450@brety.org','Northeastern@47', 'F',	'Lanexa',	'RG Street',	'VA',	'78512');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME,  DATE_OF_BIRTH, CONTACT,policy_number,premium ,EMPLOYEE_ID,card_id,status,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (29,'Susan Rosenbloom','13-APR-98','458-963-8513',9,150,7,29,'Wait','Susan_Rosenbloom537515968@dionrab.com','Northeastern@48', 'M',	'Susan',	'NM Street',	'VA',	'03695');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME,  DATE_OF_BIRTH, CONTACT,policy_number,premium ,EMPLOYEE_ID,card_id,status,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (30,'Erick Anderson','17-JAN-01','789-653-4521',1,500,1,30,'Done','Erick_Anderson1959329508@ovock.tech','Northeastern@50', 'F',	'Dowell',	'Beacon Street',	'MD',	'01452');



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


insert into policy_prerequisites values( 1, 1, 'Blood', 'Leucocyte Count','AV');


insert into policy_prerequisites values( 4, 2, 'Lung','spirometry' ,'AV');


insert into policy_prerequisites values( 7, 3, 'Blood', 'Leucocyte Count','AV');

insert into policy_prerequisites values( 9, 5, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 10, 7, 'Blood', 'Leucocyte Count','AV');

insert into policy_prerequisites values( 12, 10, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 13, 14, 'Lung','spirometry','AV');

insert into policy_prerequisites values( 15, 21, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 16, 16, 'Blood', 'Leucocyte Count','AV');

insert into policy_prerequisites values( 18, 24, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 19, 3, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 20, 14, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 21, 20, 'Blood', 'Leucocyte Count','AV');  

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


INSERT INTO HOSPITAL VALUES('1',	'Tylenol',	'Mr. Eduardo Collins, King 44233137, Jacksonville - 0000, Myanmar',	'Y');    
INSERT INTO HOSPITAL VALUES('2','City',	'Ms. Beatrice Darcy, Westcott  353751533, Stockton - 0000, India, Myanmar',	'Y');    
INSERT INTO HOSPITAL VALUES('3','Miralax',	'Mr. Peter Knight, Bacton   1315134742, Zurich - 0000, Syria, Myanmar',	'N');    
INSERT INTO HOSPITAL VALUES('4','Magne B6'	,'Mr. Liam Dwyer, Blackheath  707082971, Portland - 0000, Central African Republic, Myanmar',	'Y');    
INSERT INTO HOSPITAL VALUES('5','Vaqta'	,	'Mr. Manuel Swift, Durham 1140972097, Sacramento - 0000, Peru',	'N');    
INSERT INTO HOSPITAL VALUES('6','Ibalgin'	,	'Mr. Kieth Amstead, Central  143309062, Memphis - 0000, Eritrea',	'Y');    
INSERT INTO HOSPITAL VALUES('7','Emend'	,	'Mrs. Allison Knight, Longman   413702774, Kansas City - 0000, Samoa',	'Y');    
INSERT INTO HOSPITAL VALUES('8','Capital'	,	'Ms. Sylvia Holt, Geffrye   1356821637, Indianapolis - 0000, Albania',	'N');    
INSERT INTO HOSPITAL VALUES('9','Novolin'	,	'Mrs. Angelique Foxley, Rail 398813426, Baltimore - 0000, Ireland',	'Y');    
INSERT INTO HOSPITAL VALUES('10','Advil'	,	'Miss Harmony Wilcox, Collins  2071095077, San Diego - 0000, Switzerland',	'N'); 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


insert  into lab_order_line (labid, Hospital_id,customer_id, PRE_REQUISITE_TEST_CODE, price)  values(1,1,26,13,30);
insert  into lab_order_line (labid, Hospital_id,customer_id, PRE_REQUISITE_TEST_CODE, price) values(3,1,26,21,15);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Insert into entity_billing(bill_id, transaction_id,bill_ammount, time_stamp,customer_id,policy_id,lab_id)
values(1,5,295,Sysdate , 26,14,1);
Insert into entity_billing(bill_id, transaction_id,bill_ammount, time_stamp,customer_id,policy_id)
values(2,6,550,Sysdate , 27,10);
Insert into entity_billing(bill_id, transaction_id,bill_ammount, time_stamp,customer_id,policy_id)
values(3,7,500,Sysdate , 30,1);
Insert into entity_billing(bill_id, transaction_id,bill_ammount, time_stamp,customer_id,policy_id)
values(4,8,240,Sysdate , 28,28);


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Insert into TRANSACTION_ENTITY (TRANSACTION_ID,TRANSACTION_TYPE,TIME_STAMP,STATUS,CUSTOMER_ID,ISSUED_AMOUNT) values (5,'Online',to_date('20-APR-22','DD-MON-RR'),'Y',26,295);
Insert into TRANSACTION_ENTITY (TRANSACTION_ID,TRANSACTION_TYPE,TIME_STAMP,STATUS,CUSTOMER_ID,ISSUED_AMOUNT) values (6,'Cash',to_date('20-APR-22','DD-MON-RR'),'N',27,550);
Insert into TRANSACTION_ENTITY (TRANSACTION_ID,TRANSACTION_TYPE,TIME_STAMP,STATUS,CUSTOMER_ID,ISSUED_AMOUNT) values (7,'Card',to_date('20-APR-22','DD-MON-RR'),'Y',30,500);
Insert into TRANSACTION_ENTITY (TRANSACTION_ID,TRANSACTION_TYPE,TIME_STAMP,STATUS,CUSTOMER_ID,ISSUED_AMOUNT) values (8,'APPLE PAY',to_date('20-APR-22','DD-MON-RR'),'Y',28,240);
