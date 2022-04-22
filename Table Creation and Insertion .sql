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
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

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

-- calling the procedure "remove_objects" to remove the Customer Table 

CALL remove_objects('Customer', 'Table');    
CREATE TABLE Customer(
    Customer_id NUMBER(10) CONSTRAINT Customer_PK PRIMARY KEY,
    Customer_NAME VARCHAR(50) NOT NULL,
    Address VARCHAR(255) NOT NULL,
   Date_of_Birth DATE NOT NULL,
    Contact VARCHAR2(12) NOT NULL,
    Email VARCHAR2(50) NOT NULL,
    policy_number CONSTRAINT Cust_PN_FK REFERENCES INSURANCE_POLICIES(POLICY_NUMBER),
    Premium NUMBER(8) Unique,
    Employee_id NOT NULL CONSTRAINT Cust_EMP_FK REFERENCES entity_employee(Employee_ID),
    card_id CONSTRAINT Cust_card_FK REFERENCES card_details(cid),
    Status Varchar2(5),
    Login_email Varchar2(50) NOT NULL UNIQUE,
    Password Varchar2(50) NOT NULL UNIQUE
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
    POLICY_ID NUMBER(10) UNIQUE CONSTRAINT POLICY_ID_FK REFERENCES insurance_policies(POLICY_NUMBER),
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


INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(1,'Makenzie Richardson','Miss Makenzie Richardson, South 527285300, Salem - 0000, Panama','22-AUG-93','612-334-4325','Makenzie_Richardson2063657414@twipet.com', 1,'Makenzie_Richardson2063657414@twipet.com','Northeastern@21');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(2,	'Peter Addis',	'Mr. Peter Addis, Chamberlain  1869790298, Pittsburgh - 0000, Iraq',	'31-MAY-95',	'478-544-2613',	'Peter_Addis1226906224@grannar.com', 2, 'Peter_Addis1226906224@grannar.com',	'Northeastern@22');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(3,	'Wade Appleton',	'Mr. Wade Appleton, Geary 1004846676, Springfield - 0000, Peru',	'10-APR-91',	'027-766-6064',	'Wade_Appleton2129676548@gompie.com',			3,			'Wade_Appleton2129676548@gompie.com',	'Northeastern@23');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(4,	'Lynn Young	','Ms. Lynn Young, Monroe 1814285366, Zurich - 0000, Oman',	'09-MAR-91',	'313-661-0666',	'Lynn_Young1049801551@guentu.biz',			3,			'Lynn_Young1049801551@guentu.biz',	'Northeastern@24');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(5,	'Lindsay Clark ','	Mrs. Lindsay Clark, Durweston   1556898190, Bakersfield - 0000, Malaysia',	'24-DEC-99',	'682-072-2573',	'Lindsay_Clark1937253766@elnee.tech',			5,			'Lindsay_Clark1937253766@elnee.tech',	'Northeastern@25');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(6,	'Raquel Carpenter ','	Miss Raquel Carpenter, Cedarne  1649246313, Detroit - 0000, United Kingdom',	'19-FEB-89',	'177-408-6173',	'Raquel_Carpenter1337250263@nimogy.biz',			6,			'Raquel_Carpenter1337250263@nimogy.biz',	'Northeastern@26');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(7,	'Moira Denton ','	Ms. Moira Denton, Westcott  570638087, Bucharest - 0000, Croatia',	'18-FEB-06',	'035-486-5082',	'Moira_Denton1621390545@gmail.com',			7,			'Moira_Denton1621390545@gmail.com',	'Northeastern@27');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(8,	'Sebastian Rycroft','	Mr. Sebastian Rycroft, Chambers  2076759759, Innsbruck - 0000, France',	'18-JUL-96',	'425-716-0817',	'Sebastian_Rycroft812483468@brety.org',			8,			'Sebastian_Rycroft812483468@brety.org',	'Northeastern@28');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(9,	'Sebastian Morrison	','Mr. Sebastian Morrison, Canal  444698042, Minneapolis - 0000, Saint Vincent and the Grenadines',	'23-FEB-91',	'021-844-0144',	'Sebastian_Morrison1065165198@bretoux.com',			9,			'Sebastian_Morrison1065165198@bretoux.com',	'Northeastern@29');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(10,	'Rocco Tailor ','	Mr. Rocco Tailor, Besson  2003293710, Saint Paul - 0000, Oman',	'20-APR-04',	'624-800-5275',	'Rocco_Tailor1689568041@bulaffy.com',			10,			'Rocco_Tailor1689568041@bulaffy.com',	'Northeastern@30');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(11,	'Tyson Chappell	','Mr. Tyson Chappell, Norland  2076013518, Charlotte - 0000, Trinidad and Tobago',	'01-FEB-87',	'546-987-6569',	'Tyson_Chappell888199334@jiman.com',			2,			'Tyson_Chappell888199334@jiman.com',	'Northeastern@31');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(12,	'Makena Willis','	Mrs. Makena Willis, Cedarne  1237275124, Oklahoma City - 0000, Belgium',	'01-JUL-03',	'235-564-6564',	'Makena_Willis585382553@gompie.com',			1,			'Makena_Willis585382553@gompie.com',	'Northeastern@32');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(13,	'Mark Richardson ','	Mr. Mark Richardson, Thoresby   252660058, Lyon - 0000, Canada',	'09-SEP-96',	'789-564-2122',	'Mark_Richardson1680930294@irrepsy.com',			5,			'Mark_Richardson1680930294@irrepsy.com',	'Northeastern@33');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(14,	'Angelina Young','	Ms. Angelina Young, Ayres   112154772, Saint Paul - 0000, France',	'05-APR-01',	'457-897-2465',	'Angelina_Young1883813933@cispeto.com',			6,			'Angelina_Young1883813933@cispeto.com',	'Northeastern@34');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(15,	'Cadence Blackburn	','Ms. Cadence Blackburn, Timber   107753506, Escondido - 0000, Turkey',	'12-MAY-02',	'789-987-8521',	'Cadence_Blackburn1943268910@extex.org',		6,			'Cadence_Blackburn1943268910@extex.org',	'Northeastern@35');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(16,	'Rick Bright',' Mr. Rick Bright, East 1566520575, Toledo - 0000, Haiti',	'17-SEP-08',	'487-561-8965',	'Rick_Bright47520000@joiniaa.com',			2,			'Rick_Bright47520000@joiniaa.com',	'Northeastern@36');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(17,	'Domenic Knight ','	Mr. Domenic Knight, Bede  1077989712, Louisville - 0000, Israel',	'04-JAN-95',	'124-897-9860',	'Domenic_Knight2002797611@naiker.biz',			2,			'Domenic_Knight2002797611@naiker.biz',	'Northeastern@37');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(18,	'Amelia Phillips','	Ms. Amelia Phillips, Dutton   1055576511, Escondido - 0000, Switzerland',	'04-MAY-98',	'124-569-8000',	'Amelia_Phillips82892398@vetan.org',			5,			'Amelia_Phillips82892398@vetan.org',	'Northeastern@38');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(19,	'Kirsten Bell ','	Mrs. Kirsten Bell, Kilner   624061709, Santa Ana - 0000, Central African Republic',	'06-MAY-99',	'781-589-9632',	'Kirsten_Bell793718949@brety.org',			4	,		'Kirsten_Bell793718949@brety.org',	'Northeastern@39');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(20,	'Victoria Hood ','	Ms. Victoria Hood, South 862934190, Glendale - 0000, Algeria',	'08-MAR-95',	'123-456-7890',	'Victoria_Hood1734072221@gembat.biz',			4,			'Victoria_Hood1734072221@gembat.biz',	'Northeastern@40');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(21,	'Caleb Shields ','	Mr. Caleb Shields, Hampden  713904839, Charlotte - 0000, Central African Republic',	'02-OCT-98',	'458-965-8521',	'Caleb_Shields401362496@cispeto.com',			2,			'Caleb_Shields401362496@cispeto.com',	'Northeastern@41');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(22,	'Alan Wild','	Mr. Alan Wild, Fieldstone 1795520454, Tallahassee - 0000, East Timor (Timor-Leste)',	'07-SEP-03',	'124-965-8965',	'Alan_Wild780471328@hourpy.biz',			6,			'Alan_Wild780471328@hourpy.biz',	'Northeastern@42');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(23,	'Audrey Cox	',' Miss Audrey Cox, South 471021301, Madison - 0000, San Marino',	'05-JUN-91',	'785-654-9632',	'Audrey_Cox413450124@ubusive.com',			6,			'Audrey_Cox413450124@ubusive.com',	'Northeastern@43');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(24, 'Ada James','	Miss Ada James, Lincoln 1011139759, Rochester - 0000, Congo, Republic of the',	'08-FEB-85',	'784-569-3215',	'Ada_James316668414@bretoux.com',			6,			'Ada_James316668414@bretoux.com',	'Northeastern@44');    
INSERT INTO customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password) 
    VALUES(25,	'Cassandra Benfield','	Ms. Cassandra Benfield, Caroline  1524301778, Houston - 0000, Zambia',	'06-JAN-98',	'125-963-7895',	'Cassandra_Benfield1367201885@sheye.org',			6,			'Cassandra_Benfield1367201885@sheye.org',	'Northeastern@45');    
Insert into CUSTOMER (CUSTOMER_ID,CUSTOMER_NAME,ADDRESS,DATE_OF_BIRTH,CONTACT,EMAIL,POLICY_NUMBER,PREMIUM,EMPLOYEE_ID,CARD_ID,STATUS,LOGIN_EMAIL,PASSWORD) values (26,'Lucas Bradshaw','Mr. Lucas Bradshaw, Andrews 1996108851, Escondido - 0000, Saudi Arabia',to_date('17-AUG-87','DD-MON-RR'),'458-963-4521','Lucas_Bradshaw418027303@bauros.biz',14,240,4,26,'Wait','Lucas_Bradshaw418027303@bauros.biz','Northeastern@46');
Insert into CUSTOMER (CUSTOMER_ID,CUSTOMER_NAME,ADDRESS,DATE_OF_BIRTH,CONTACT,EMAIL,POLICY_NUMBER,PREMIUM,EMPLOYEE_ID,CARD_ID,STATUS,LOGIN_EMAIL,PASSWORD) values (28,'Michael Knight','Mr. Michael Knight, Yoakley 2010364703, Murfreesboro - 0000, Grenada',to_date('01-FEB-89','DD-MON-RR'),'456-963-7115','Michael_Knight865421450@brety.org',28,730,7,28,'Done','Michael_Knight865421450@brety.org','Northeastern@47');
Insert into CUSTOMER (CUSTOMER_ID,CUSTOMER_NAME,ADDRESS,DATE_OF_BIRTH,CONTACT,EMAIL,POLICY_NUMBER,PREMIUM,EMPLOYEE_ID,CARD_ID,STATUS,LOGIN_EMAIL,PASSWORD) values (29,'Susan Rosenbloom','Ms. Susan Rosenbloom, Blake 724518212, Lakewood - 0000, United Kingdom',to_date('13-APR-98','DD-MON-RR'),'458-963-8513','Susan_Rosenbloom537515968@dionrab.com',9,150,7,29,'Wait','Susan_Rosenbloom537515968@dionrab.com','Northeastern@48');
Insert into CUSTOMER (CUSTOMER_ID,CUSTOMER_NAME,ADDRESS,DATE_OF_BIRTH,CONTACT,EMAIL,POLICY_NUMBER,PREMIUM,EMPLOYEE_ID,CARD_ID,STATUS,LOGIN_EMAIL,PASSWORD) values (30,'Erick Anderson','Mr. Erick Anderson, Oxford 610904444, Escondido - 0000, Kosovo',to_date('17-JAN-01','DD-MON-RR'),'789-653-4521','Erick_Anderson1959329508@ovock.tech',1,500,1,30,'Done','Erick_Anderson1959329508@ovock.tech','Northeastern@50');
Insert into CUSTOMER (CUSTOMER_ID,CUSTOMER_NAME,ADDRESS,DATE_OF_BIRTH,CONTACT,EMAIL,POLICY_NUMBER,PREMIUM,EMPLOYEE_ID,CARD_ID,STATUS,LOGIN_EMAIL,PASSWORD) values (27,'Leanne Davies','Mrs. Leanne Davies, Marischal 1971766684, Denver - 0000, Vatican City',to_date('11-NOV-05','DD-MON-RR'),'564-986-3215','Leanne_Davies1656102163@acrit.org',10,550,2,27,'Done','Leanne_Davies1656102163@acrit.org','Northeastern@51');  



----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


insert into policy_prerequisites values( 1, 1, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 2, 1, 'Diabties','Insulin_resistance', 'AV');
insert into policy_prerequisites values( 3, 1, 'Lung','spirometry' ,'AV');
insert into policy_prerequisites values( 4, 2, 'Lung','spirometry' ,'AV');
insert into policy_prerequisites values( 5, 2, 'Diabties','Insulin_resistance', 'AV');
insert into policy_prerequisites values( 6, 2, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 7, 3, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 8, 3, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 9, 5, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 10, 7, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 11, 7, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 12, 10, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 13, 14, 'Lung','spirometry','AV');
insert into policy_prerequisites values( 14, 14, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 15, 21, 'Diabties','Insulin_resistance','AV');
insert into policy_prerequisites values( 16, 16, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 17, 21, 'Blood', 'Leucocyte Count','AV');
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