CREATE TABLE LAB_ORDER_LINE(
 LABID NUMBER(10) CONSTRAINT LABID_PK PRIMARY KEY,
 HOSPITAL_ID NUMBER(10) CONSTRAINT HOSPITALID_FK REFERENCES
DEEPAK.HOSPTIAL(HOSPITAL_ID),
 CUSTOMER_ID NUMBER(10) NOT NULL CONSTRAINT CUSTOMERID_FK REFERENCES
ARJUN.customer(CUSTOMER_ID),
 PRE_REQUISITE_TEST_CODE NUMBER(6) NOT NULL CONSTRAINT PREREQ_FK
REFERENCES MUDIT.policy_prerequisites(PREREQUISITE_TEST_CODE),
 PRICE NUMBER(10) NOT NULL
 );


INSERT INTO MUDIT.card_details VALUES('1','Makenzie
Richardson','7123576431937452','12-aug-2022','263');
INSERT INTO MUDIT.card_details VALUES('2','Peter Addis','2582678692687262','4-
nov-2024','260');
INSERT INTO MUDIT.card_details VALUES('3','Wade Appleton','2525487267979379','18-
oct-2023','422');
INSERT INTO MUDIT.card_details VALUES('4','Lynn Young','5798689367998294','2-
jan-2024','499');
INSERT INTO MUDIT.card_details VALUES('5','Lindsay Clark','2687658973857093','12-
feb-2024','366');
INSERT INTO MUDIT.card_details VALUES('6','Raquel Carpenter','5798798173875573','4-
aug-2024','973');
INSERT INTO MUDIT.card_details VALUES('7','Moira Denton','5793897507085093','12-
july-2022','903');
INSERT INTO MUDIT.card_details VALUES('8','Sebastian Rycroft','8927409860820026','4-
nov-2025','143');
INSERT INTO MUDIT.card_details VALUES('9','Sebastian Morrison','6789287687208332','24-
dec-2023','711');
INSERT INTO MUDIT.card_details VALUES('10','Rocco Tailor','2556268783783783','9-
nov-2024','424');
INSERT INTO MUDIT.card_details VALUES('11','Tyson Chappell','5361698471974161','18-
aug-2023','243');
INSERT INTO MUDIT.card_details VALUES('12','Makena Willis','1967366532631651','14-
nov-2025','223');
INSERT INTO MUDIT.card_details VALUES('13','Mark Richardson','1647817508150823','8-
oct-2024','452');
INSERT INTO MUDIT.card_details VALUES('14','Angelina Young','1581750838048048','12-
jan-2023','649');
INSERT INTO MUDIT.card_details VALUES('15','Cadence Blackburn','6591598759874975','2-
feb-2025','246');
INSERT INTO MUDIT.card_details VALUES('16','Rick Bright','5789228084257654','14-
aug-2025','943');
INSERT INTO MUDIT.card_details VALUES('17','Domenic Knight','8197592797297522','8-
july-2023','833');
INSERT INTO MUDIT.card_details VALUES('18','Amelia Phillips','7592759792792793','14-
nov-2024','192');
INSERT INTO MUDIT.card_details VALUES('19','Kirsten Bell','2569826929952692','18-
dec-2025','744');
INSERT INTO MUDIT.card_details VALUES('20','Victoria Hood','6856826592797592','19-
nov-2024','444');
INSERT INTO MUDIT.card_details VALUES('21','Caleb Shields','2965265828386586','22-
may-2024','853');
INSERT INTO MUDIT.card_details VALUES('22','Alan Wild','5625927597297297','1-
oct-2024','456');
INSERT INTO MUDIT.card_details VALUES('23','Audrey Cox','1759739759379379','18-
jan-2025','789');
INSERT INTO MUDIT.card_details VALUES('24','Ada James','1649179719794171','12-
aug-2025','234');
INSERT INTO MUDIT.card_details VALUES('25','Cassandra Benfield','5619765917917511','7-
april-2025','732');
INSERT INTO MUDIT.card_details VALUES('26','Lucas Bradshaw','3875983725698723','4-
july-2026','678');
INSERT INTO MUDIT.card_details VALUES('27','Leanne Davies','1867592759759729','29-
july-2025','433');
INSERT INTO MUDIT.card_details VALUES('28','Michael Knight','6972857785975392','24-
may-2025','199');
INSERT INTO MUDIT.card_details VALUES('29','Susan Rosenbloom','8695619591791563','4-
may-2025','469');
INSERT INTO MUDIT.card_details VALUES('30','Erick Anderson','1786592837037953','19-
may-2024','696');
select * from MUDIT.card_details;
commit;
select * from ARJUN.customer;
INSERT INTO ARJUN.lab_order_line VALUES('11','1','1','31','53');
INSERT INTO ARJUN.lab_order_line VALUES('12','2','2','32','56');
INSERT INTO ARJUN.lab_order_line VALUES('13','3','3','33','89');
INSERT INTO ARJUN.lab_order_line VALUES('14','4','4','34','34');
INSERT INTO ARJUN.lab_order_line VALUES('15','5','5','35','32');
INSERT INTO ARJUN.lab_order_line VALUES('16','6','6','36','78');
INSERT INTO ARJUN.lab_order_line VALUES('17','7','7','37','33');
INSERT INTO ARJUN.lab_order_line VALUES('18','8','8','38','99');
INSERT INTO ARJUN.lab_order_line VALUES('19','9','9','39','69');
INSERT INTO ARJUN.lab_order_line VALUES('20','10','10','40','96');
SELECT * from DEEPAK.insurance_policies;
INSERT INTO MUDIT.policy_prerequisites VALUES('31','1','FEV','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('32','2','KID','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('33','3','CANCER','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('34','4','ACC','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('35','5','LEG','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('36','6','EYE','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('37','7','BRAIN','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('38','8','HAND','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('39','9','HEART','AV');
INSERT INTO MUDIT.policy_prerequisites VALUES('40','10','LUNGS','AV');
SELECT * FROM MUDIT.policy_prerequisites;
SELECT * FROM ARJUN.lab_order_line;
COMMIT;
SELECT * FROM ARJUN.lab_order_line;
SELECT * FROM ARJUN.customer;
SELECT * from DEEPAK.insurance_policies;
select * from MUDIT.card_details;