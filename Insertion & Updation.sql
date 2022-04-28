select * from customer;
update customer set gender = 'M', city='New York',street= '12 Smith Street',state = 'NY' , zipcode='02314' where customer_id= 1;
update customer set gender = 'M', city='New Jersy',street= '23 Warner Street',state = 'NJ' , zipcode='01124' where customer_id= 2;
update customer set gender = 'M', city='San Diego',street= '37 Stephan Street',state = 'CA' , zipcode='01244' where customer_id= 3;
update customer set gender = 'M', city='Boston',street= '58 QA Street',state = 'MA' , zipcode='02215' where customer_id= 4;
update customer set gender = 'F', city='Atlanta',street= '15 Heisenberg Street',state = 'GA' , zipcode='01456' where customer_id= 5;
update customer set gender = 'F', city='Worchester',street= '45 RM Street',state = 'MA' , zipcode='01145' where customer_id= 6;
update customer set gender = 'F', city='Boston',street= 'Park Drive',state = 'MA' , zipcode='01425' where customer_id= 7;
update customer set gender = 'M', city='Lowell',street= '13 Stark Street',state = 'MA' , zipcode='01225' where customer_id= 8;
update customer set gender = 'M', city='Dallas',street= 'JA Park',state = 'TX' , zipcode='14562' where customer_id= 9;
update customer set gender = 'M', city='Austin',street= 'OT Street',state = 'TX' , zipcode='01245' where customer_id= 10;
update customer set gender = 'M', city='Chicago',street= 'NW Street',state = 'IL' , zipcode='01451' where customer_id= 11;
update customer set gender = 'F', city='Seattle',street= 'JFK Street',state = 'WA' , zipcode='01052' where customer_id= 12;
update customer set gender = 'M', city='San Jose',street= 'SJSU Street',state = 'CA' , zipcode='02312' where customer_id= 13;
update customer set gender = 'F', city='Las Vegas',street= 'LV Street',state = 'NV' , zipcode='01455' where customer_id= 14;
update customer set gender = 'F', city='Penuelas',street= 'PR Street',state = 'PR' , zipcode='01245' where customer_id= 15;
update customer set gender = 'M', city='Sharon',street= 'SP Street',state = 'MA' , zipcode='04521' where customer_id= 16;
update customer set gender = 'M', city='Troy',street= 'TD Street',state = 'NH' , zipcode='01451' where customer_id= 17;
update customer set gender = 'F', city='Lisbon',street= 'LT Street',state = 'NH' , zipcode='15463' where customer_id= 18;
update customer set gender = 'F', city='Blaine',street= 'BG Street',state = 'ME' , zipcode='01452' where customer_id= 19;
update customer set gender = 'F', city='Fairfax',street= 'VT Street',state = 'VT' , zipcode='04512' where customer_id= 20;
update customer set gender = 'M', city='Red Bank',street= 'RB Street',state = 'NJ' , zipcode='01478' where customer_id= 21;
update customer set gender = 'M', city='Brooklyn',street= 'Watt Street',state = 'NY' , zipcode='01452' where customer_id= 22;
update customer set gender = 'F', city='Holmes',street= 'Roxbury',state = 'NY' , zipcode='01452' where customer_id= 23;
update customer set gender = 'F', city='Robinson',street= 'TS Street',state = 'PA' , zipcode='07896' where customer_id= 24;
update customer set gender = 'F', city='Butler',street= 'BCG Street',state = 'PA' , zipcode='04213' where customer_id= 25;
update customer set gender = 'M', city='Reston',street= 'LA Street',state = 'VA' , zipcode='04451' where customer_id= 26;
update customer set gender = 'F', city='Dowell',street= 'Beacon Street',state = 'MD' , zipcode='01452' where customer_id= 27;
update customer set gender = 'M', city='Laurel',street= 'MG Street',state = 'MD' , zipcode='21453' where customer_id= 28;
update customer set gender = 'F', city='Lanexa',street= 'RG Street',state = 'VA' , zipcode='78512' where customer_id= 29;
update customer set gender = 'M', city='Susan',street= 'NM Street',state = 'VA' , zipcode='03695' where customer_id= 30;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

update customer set card_id = '1' where customer_id= 1;
update customer set card_id = '2' where customer_id= 2;
update customer set card_id = '3' where customer_id= 3;
update customer set card_id = '4' where customer_id= 4;
update customer set card_id = '5' where customer_id= 5;
update customer set card_id = '6' where customer_id= 6;
update customer set card_id = '7' where customer_id= 7;
update customer set card_id = '8' where customer_id= 8;
update customer set card_id = '9' where customer_id= 9;
update customer set card_id = '10' where customer_id= 10;
update customer set card_id = '11' where customer_id= 11;
update customer set card_id = '12' where customer_id= 12;
update customer set card_id = '13' where customer_id= 13;
update customer set card_id = '14' where customer_id= 14;
update customer set card_id = '15' where customer_id= 15;
update customer set card_id = '16' where customer_id= 16;
update customer set card_id = '17' where customer_id= 17;
update customer set card_id = '18' where customer_id= 18;
update customer set card_id = '19' where customer_id= 19;
update customer set card_id = '20' where customer_id= 20;
update customer set card_id = '21' where customer_id= 21;
update customer set card_id = '22' where customer_id= 22;
update customer set card_id = '23' where customer_id= 23;
update customer set card_id = '24' where customer_id= 24;
update customer set card_id = '25' where customer_id= 25;
update customer set card_id = '26' where customer_id= 26;
update customer set card_id = '27' where customer_id= 27;
update customer set card_id = '28' where customer_id= 28;
update customer set card_id = '29' where customer_id= 29;
update customer set card_id = '30' where customer_id= 30;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(1,'Makenzie Richardson','Miss Makenzie Richardson, South 527285300, Salem - 0000, Panama','22-AUG-93','612-334-4325','Makenzie_Richardson2063657414@twipet.com', 1,'Makenzie_Richardson2063657414@twipet.com','Northeastern@21', 'M',	'New York',	'12 Smith Street'	'NY'	'02314');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(2,	'Peter Addis',	'Mr. Peter Addis, Chamberlain  1869790298, Pittsburgh - 0000, Iraq',	'31-MAY-95',	'478-544-2613',	'Peter_Addis1226906224@grannar.com', 2, 'Peter_Addis1226906224@grannar.com',	'Northeastern@22', 'M',	'New Jersy',	'23', 'Warner Street',	'NJ',	'01124');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(3,	'Wade Appleton',	'Mr. Wade Appleton, Geary 1004846676, Springfield - 0000, Peru',	'10-APR-91',	'027-766-6064',	'Wade_Appleton2129676548@gompie.com',			3,			'Wade_Appleton2129676548@gompie.com',	'Northeastern@23', 'M',	'San Diego',	'37 Stephan Street',	'CA',	'01244');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(4,	'Lynn Young	','Ms. Lynn Young, Monroe 1814285366, Zurich - 0000, Oman',	'09-MAR-91',	'313-661-0666',	'Lynn_Young1049801551@guentu.biz',			3,			'Lynn_Young1049801551@guentu.biz',	'Northeastern@24', 'M',	'Boston', '58 QA Street',	'MA',	'02215');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(5,	'Lindsay Clark ','	Mrs. Lindsay Clark, Durweston   1556898190, Bakersfield - 0000, Malaysia',	'24-DEC-99',	'682-072-2573',	'Lindsay_Clark1937253766@elnee.tech',			5,			'Lindsay_Clark1937253766@elnee.tech',	'Northeastern@25', 'F',	'Atlanta',	'15 Heisenberg Street',	'GA',	'01456');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(6,	'Raquel Carpenter ','	Miss Raquel Carpenter, Cedarne  1649246313, Detroit - 0000, United Kingdom',	'19-FEB-89',	'177-408-6173',	'Raquel_Carpenter1337250263@nimogy.biz',			6,			'Raquel_Carpenter1337250263@nimogy.biz',	'Northeastern@26', 'F',	'Worchester	45 RM Street',	'MA',	'01145');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(7,	'Moira Denton ','	Ms. Moira Denton, Westcott  570638087, Bucharest - 0000, Croatia',	'18-FEB-06',	'035-486-5082',	'Moira_Denton1621390545@gmail.com',			7,			'Moira_Denton1621390545@gmail.com',	'Northeastern@27', 'F',	'Boston',	'Park Drive',	'MA',	'01425');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(8,	'Sebastian Rycroft','	Mr. Sebastian Rycroft, Chambers  2076759759, Innsbruck - 0000, France',	'18-JUL-96',	'425-716-0817',	'Sebastian_Rycroft812483468@brety.org',			8,			'Sebastian_Rycroft812483468@brety.org',	'Northeastern@28', 'M',	'Lowell',	'13 Stark Street',	'MA',	'01225');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(9,	'Sebastian Morrison	','Mr. Sebastian Morrison, Canal  444698042, Minneapolis - 0000, Saint Vincent and the Grenadines',	'23-FEB-91',	'021-844-0144',	'Sebastian_Morrison1065165198@bretoux.com',			9,			'Sebastian_Morrison1065165198@bretoux.com',	'Northeastern@29', 'M',	'Dallas',	'JA Park',	'TX',	'14562');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(10,	'Rocco Tailor ','	Mr. Rocco Tailor, Besson  2003293710, Saint Paul - 0000, Oman',	'20-APR-04',	'624-800-5275',	'Rocco_Tailor1689568041@bulaffy.com',			10,			'Rocco_Tailor1689568041@bulaffy.com',	'Northeastern@30', 'M',	'Austin',	'OT Street',	'TX',	'01245');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(11,	'Tyson Chappell	','Mr. Tyson Chappell, Norland  2076013518, Charlotte - 0000, Trinidad and Tobago',	'01-FEB-87',	'546-987-6569',	'Tyson_Chappell888199334@jiman.com',			2,			'Tyson_Chappell888199334@jiman.com',	'Northeastern@31', 'M',	'Chicago',	'NW Street',	'IL',	'01451');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(12,	'Makena Willis','	Mrs. Makena Willis, Cedarne  1237275124, Oklahoma City - 0000, Belgium',	'01-JUL-03',	'235-564-6564',	'Makena_Willis585382553@gompie.com',			1,			'Makena_Willis585382553@gompie.com',	'Northeastern@32', 'F',	'Seattle',	'JFK Street',	'WA',	'01052');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(13,	'Mark Richardson ','	Mr. Mark Richardson, Thoresby   252660058, Lyon - 0000, Canada',	'09-SEP-96',	'789-564-2122',	'Mark_Richardson1680930294@irrepsy.com',			5,			'Mark_Richardson1680930294@irrepsy.com',	'Northeastern@33', 'M',	'San Jose',	'SJSU Street	CA',	'02312');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(14,	'Angelina Young','	Ms. Angelina Young, Ayres   112154772, Saint Paul - 0000, France',	'05-APR-01',	'457-897-2465',	'Angelina_Young1883813933@cispeto.com',			6,			'Angelina_Young1883813933@cispeto.com',	'Northeastern@34', 'F',	'Las Vegas',	'LV Street',	'NV',	'01455');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(15,	'Cadence Blackburn	','Ms. Cadence Blackburn, Timber   107753506, Escondido - 0000, Turkey',	'12-MAY-02',	'789-987-8521',	'Cadence_Blackburn1943268910@extex.org',		6,			'Cadence_Blackburn1943268910@extex.org',	'Northeastern@35', 'F',	'Penuelas',	'PR Street',	'PR',	'01245');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(16,	'Rick Bright',' Mr. Rick Bright, East 1566520575, Toledo - 0000, Haiti',	'17-SEP-08',	'487-561-8965',	'Rick_Bright47520000@joiniaa.com',			2,			'Rick_Bright47520000@joiniaa.com',	'Northeastern@36', 'M',	'Sharon',	'SP Street',	'MA',	'04521');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(17,	'Domenic Knight ','	Mr. Domenic Knight, Bede  1077989712, Louisville - 0000, Israel',	'04-JAN-95',	'124-897-9860',	'Domenic_Knight2002797611@naiker.biz',			2,			'Domenic_Knight2002797611@naiker.biz',	'Northeastern@37', 'M',	'Troy',	'TD Street',	'NH',	'01451');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(18,	'Amelia Phillips','	Ms. Amelia Phillips, Dutton   1055576511, Escondido - 0000, Switzerland',	'04-MAY-98',	'124-569-8000',	'Amelia_Phillips82892398@vetan.org',			5,			'Amelia_Phillips82892398@vetan.org',	'Northeastern@38', 'F',	'Lisbon',	'LT Street',	'NH',	'15463');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(19,	'Kirsten Bell ','	Mrs. Kirsten Bell, Kilner   624061709, Santa Ana - 0000, Central African Republic',	'06-MAY-99',	'781-589-9632',	'Kirsten_Bell793718949@brety.org',			4	,		'Kirsten_Bell793718949@brety.org',	'Northeastern@39', 'F',	'Blaine',	'BG Street',	'ME',	'01452');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(20,	'Victoria Hood ','	Ms. Victoria Hood, South 862934190, Glendale - 0000, Algeria',	'08-MAR-95',	'123-456-7890',	'Victoria_Hood1734072221@gembat.biz',			4,			'Victoria_Hood1734072221@gembat.biz',	'Northeastern@40', 'F',	'Fairfax',	'VT Street',	'VT',	'04512');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(21,	'Caleb Shields ','	Mr. Caleb Shields, Hampden  713904839, Charlotte - 0000, Central African Republic',	'02-OCT-98',	'458-965-8521',	'Caleb_Shields401362496@cispeto.com',			2,			'Caleb_Shields401362496@cispeto.com',	'Northeastern@41', 'M',	'Red Bank',	'RB Street',	'NJ',	'01478');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(22,	'Alan Wild','	Mr. Alan Wild, Fieldstone 1795520454, Tallahassee - 0000, East Timor (Timor-Leste)',	'07-SEP-03',	'124-965-8965',	'Alan_Wild780471328@hourpy.biz',			6,			'Alan_Wild780471328@hourpy.biz',	'Northeastern@42', 'M',	'Brooklyn',	'Watt Street',	'NY',	'01452');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(23,	'Audrey Cox	',' Miss Audrey Cox, South 471021301, Madison - 0000, San Marino',	'05-JUN-91',	'785-654-9632',	'Audrey_Cox413450124@ubusive.com',			6,			'Audrey_Cox413450124@ubusive.com',	'Northeastern@43', 'F',	'Holmes',	'Roxbury',	'NY',	'01452');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(24, 'Ada James','	Miss Ada James, Lincoln 1011139759, Rochester - 0000, Congo, Republic of the',	'08-FEB-85',	'784-569-3215',	'Ada_James316668414@bretoux.com',			6,			'Ada_James316668414@bretoux.com',	'Northeastern@44', 'F',	'Robinson',	'TS Street',	'PA',	'07896'');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    VALUES(25,	'Cassandra Benfield','	Ms. Cassandra Benfield, Caroline  1524301778, Houston - 0000, Zambia',	'06-JAN-98',	'125-963-7895',	'Cassandra_Benfield1367201885@sheye.org',			6,			'Cassandra_Benfield1367201885@sheye.org',	'Northeastern@45', 'F',	'Butler',	'BCG Street',	'PA',	'04213');    
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (26,'Lucas Bradshaw','Mr. Lucas Bradshaw, Andrews 1996108851, Escondido - 0000, Saudi Arabia',to_date('17-AUG-87','DD-MON-RR'),'458-963-4521','Lucas_Bradshaw418027303@bauros.biz',14,240,4,26,'Wait','Lucas_Bradshaw418027303@bauros.biz','Northeastern@46', 'M',	'Reston',	'LA Street',	'VA',	'04451');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (27,'Leanne Davies','Mrs. Leanne Davies, Marischal 1971766684, Denver - 0000, Vatican City',to_date('11-NOV-05','DD-MON-RR'),'564-986-3215','Leanne_Davies1656102163@acrit.org',10,550,2,27,'Done','Leanne_Davies1656102163@acrit.org','Northeastern@51', 'M',	'Laurel',	'MG Street',	'MD',	'21453');  
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (28,'Michael Knight','Mr. Michael Knight, Yoakley 2010364703, Murfreesboro - 0000, Grenada',to_date('01-FEB-89','DD-MON-RR'),'456-963-7115','Michael_Knight865421450@brety.org',28,730,7,28,'Done','Michael_Knight865421450@brety.org','Northeastern@47', 'F',	'Lanexa',	'RG Street',	'VA',	'78512');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (29,'Susan Rosenbloom','Ms. Susan Rosenbloom, Blake 724518212, Lakewood - 0000, United Kingdom',to_date('13-APR-98','DD-MON-RR'),'458-963-8513','Susan_Rosenbloom537515968@dionrab.com',9,150,7,29,'Wait','Susan_Rosenbloom537515968@dionrab.com','Northeastern@48', 'M',	'Susan',	'NM Street',	'VA',	'03695');
INSERT INTO Customer(CUSTOMER_ID, CUSTOMER_NAME, ADDRESS, DATE_OF_BIRTH, CONTACT, Email,EMPLOYEE_ID,login_email,Password, Gender, City, Street, State, Zipcode) 
    values (30,'Erick Anderson','Mr. Erick Anderson, Oxford 610904444, Escondido - 0000, Kosovo',to_date('17-JAN-01','DD-MON-RR'),'789-653-4521','Erick_Anderson1959329508@ovock.tech',1,500,1,30,'Done','Erick_Anderson1959329508@ovock.tech','Northeastern@50', 'F',	'Dowell',	'Beacon Street',	'MD',	'01452');


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


insert into policy_prerequisites values( 20, 8, 'Diabties', 'Insulin_resistance','AV');
insert into policy_prerequisites values( 3, 11, 'Lung', 'spirometry','AV');
insert into policy_prerequisites values( 26, 22, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 28, 25, 'Lung', 'spirometry','AV');
insert into policy_prerequisites values( 29, 27, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 31, 28, 'Blood', 'Leucocyte Count','AV');
insert into policy_prerequisites values( 32, 29, 'Diabties', 'Insulin_resistance','AV');
insert into policy_prerequisites values( 11, 12, 'Lung', 'spirometry','AV');
insert into policy_prerequisites values( 15, 13, 'Diabties', 'Insulin_resistance','AV');
insert into policy_prerequisites values( 19, 17, 'Lung', 'spirometry','AV');



