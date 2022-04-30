
--------------------------------------------------Package Creation For Company Sign_up and Insurance_policies----------------------------------------------------------------

create or replace PACKAGE Company_Ip_Package AS 

Procedure C_signup(F_name in company.company_name%type, License_no in company.license_number%type, Create_date in company.created_date%type , user_name in admin.username%type, pass_word in admin.pasword%type, contact in admin.contact%type,c_email in admin.email_id%type);
 Procedure IP(Policy_tp insurance_policies.policy_type%type, prem insurance_policies.premium%type,c_code insurance_policies.c_code%type,
time_p insurance_policies.time_period%type, sum_ass insurance_policies.sum_assuared%type, policy_bene insurance_policies.policy_benefits%type, 
pre_req_disease policy_prerequisites.prerequisite_disease%type,prereq_test policy_prerequisites.prerequisite_test_name%type );

END Company_Ip_Package;



--------------------------------------------------Package Body Creation For Company Sign_up and Insurance_policies(Procedures)----------------------------------------------------------------

create or replace PACKAGE Body Company_Ip_Package AS 
Procedure C_signup(F_name in company.company_name%type, License_no in company.license_number%type, Create_date in company.created_date%type , user_name in admin.username%type, pass_word in admin.pasword%type, contact in admin.contact%type,c_email in admin.email_id%type)
is 
max_cc number;
max_ssid number;
maxssid number;
maxcc number;
Licenseno exception;
date_error exception;
countUnique number;
license_len_error exception;
contact_len_error exception;
license_unique exception;
email_invalid exception;
COMPANY_ROW COMPANY%ROWTYPE;

BEGIN
    select count(*) into countUnique from company where license_number=License_no;
    select Max(Company_code)into maxcc from company;
select Max(system_id)into maxssid from admin;
    max_cc := maxcc +1;
    max_ssid := maxssid +1;


    if (countUnique>0)
        then raise license_unique;
    elsif length(License_no)<>12 
        then raise license_len_error;

    elsif check_email_pattern(c_email)=0
        then raise email_invalid;
    elsif length(contact)<>10 
        then raise contact_len_error;

    else


     insert into admin (System_id,
        name,
    Username,
    pasword,
    contact,
    email_id
    )VALUES
    (max_ssid,
    F_name,
    user_name,
    pass_word,
    contact,
    c_email
    );
    insert into company (Company_code,
        Company_name,
    License_number,
    Created_date,
    System_id 
    )VALUES
    (max_cc,
    F_name,
    License_no,
    Create_date,
    max_ssid
    );
    end if;


    dbms_output.put_line('The company you have added is/n');
    select * into COMPANY_ROW from company where Company_Code = max_cc;
    dbms_output.put_line('Company_Code:'||company_row.company_code||' |Company_name '|| COMPANY_ROW.company_name||' |License Number' ||COMPANY_ROW.License_number|| ' | Created Date' ||COMPANY_ROW.created_date);



    exception
    When License_Len_error Then
        raise_application_error (-20001,'License number should be 12 Character ');
    When License_unique Then      
        raise_application_error (-20003,'License should be unique');
    When email_invalid Then
        raise_application_error (-20007,'Email pattern invalid');
       when Contact_Len_error Then
        raise_application_error (-20001,'Contact number should be 10 digits ');
        END C_Signup;


Procedure IP(Policy_tp insurance_policies.policy_type%type, prem insurance_policies.premium%type,c_code insurance_policies.c_code%type,
time_p insurance_policies.time_period%type, sum_ass insurance_policies.sum_assuared%type, policy_bene insurance_policies.policy_benefits%type, 
pre_req_disease policy_prerequisites.prerequisite_disease%type,prereq_test policy_prerequisites.prerequisite_test_name%type )
is 
max_pid number;
max_pptc number;
maxpptc number;
maxpid number;
prem_NOTNUMBER exception;
sum_NOTNUMBER exception;
IP_ROW INSURANCE_POLICIES%ROWTYPE;
policy_wrong exception;
BEGIN

    select Max(policy_number)into maxpid from insurance_policies;
select Max(policy_prerequisite_test_code)into maxpptc from policy_prerequisites;
    max_pptc := maxpptc +1;
    max_pid := maxpid +1;

  IF Policy_tp NOT IN('Private','Public','Government')
        THEN raise policy_wrong;dbms_output.put_line( 'Policy type must be entered as Private, Public or government');
  END IF;

    if IS_NUMBER(prem)=0
        then raise prem_NOTNUMBER;
    elsif IS_NUMBER(sum_ass)=0
        then raise sum_NOTNUMBER;


    else
        insert into insurance_policies (policy_number,
        policy_type,
        Premium,
        C_code,
        Time_period,
        Sum_assuared,
        Policy_benefits
        )VALUES
        (max_pid,
        Policy_tp,
        prem,
        c_code,
        time_p,
        sum_ass,
        policy_bene
        );

    end if;
    if (pre_req_disease is NOT NULL) then
    insert into policy_PREREQUISITES (policy_prerequisite_test_code,
        Policy_number,
    prerequisite_disease,
    prerequisite_test_name,
    status
    )VALUES
    (max_pptc,
    max_pid,
    pre_req_disease,
    prereq_test,
    'Av'
    );


    end if;
      dbms_output.put_line('The Insurance Policy you have added is');
    select * into IP_ROW from insurance_policies where policy_number = max_pid;
    dbms_output.put_line('POLICY_NUMBER'||IP_ROW.POLICY_NUMBER||' |POLICY TYPE:  '||IP_ROW.POLICY_TYPE|| ' |PREMIUM:' ||IP_ROW.PREMIUM|| ' | COMPANY_CODE:' ||IP_ROW.C_CODE|| '| TIME PERIOD:' ||IP_ROW.TIME_PERIOD|| '|SUM_ASSURED:' ||IP_ROW.SUM_ASSUARED|| '| POLICY_BENEFITS:' ||IP_ROW.POLICY_BENEFITS);




    exception
    when prem_NOTNUMBER Then
        raise_application_error (-20006,'Premium SHOULD CONTAIN ONLY NUMBERS');
    when sum_NOTNUMBER Then
        raise_application_error (-20006,'Sum_assured SHOULD CONTAIN ONLY NUMBERS');
    when policy_wrong then
        raise_application_error(-20006,'Policy type must be entered as Private, Public or government');
    end IP;



END Company_Ip_Package;



--------------------------------------------------Package Creation For Customer Sign_up and Card Details Assignment----------------------------------------------------------------

CREATE OR REPLACE PACKAGE Customer_sign_in AS 
Procedure assign_card_details(cust_id number, cardName varchar2, cardNumber varchar2, cardExpiryDate date, cardCVV number);
Procedure signup(s_email IN varchar, pass_word VARCHAR, F_name varchar, contact varchar, dob date, City varchar, street varchar, states varchar
,zipcode number,Gender varchar,emp_id number);

END Customer_sign_in;
/


--------------------------------------------------Package Body Creation For Customer Sign_up and Card Details Assignment----------------------------------------------------------------

CREATE OR REPLACE PACKAGE BODY Customer_sign_in AS 
Procedure signup(s_email IN varchar, pass_word VARCHAR, F_name varchar, contact varchar, dob date, City varchar, street varchar, states varchar
,zipcode number,Gender varchar,emp_id number)
is 
max_cid number;
maxcust_id number;
contact_len_error exception;
date_error exception;
email_unique exception;
countUnique number;
zipcode_notNumber exception;
email_invalid exception;
gender_notin exception;
CUSTOMER_ROW CUSTOMER%ROWTYPE;
BEGIN
    select count(*) into countUnique from customer where login_email= s_email;
    select Max(Customer_id)into maxcust_id from customer;
    max_cid := maxcust_id +1;

    if IS_NUMBER(zipcode)=0
        then raise zipcode_notNumber;
    elsif (countUnique>0)
        then raise email_unique;
    elsif check_email_pattern(s_email)=0
        then raise email_invalid;
    elsif length(contact)<>10 
        then raise contact_len_error;
    elsif gender NOT IN('M','F')
        then raise gender_notin;

    else
        insert into customer (Customer_id,
        Customer_name,
    City,
    Street,
    State, 
    Zipcode,
    Date_of_Birth,
    contact, 
    login_email,
    employee_id,
    password)VALUES
    (max_cid,
    F_name,
    City,
    Street,
    States,
    Zipcode,
    dob,
    contact,
    s_email,
    emp_id,
    pass_word);

    end if;

     dbms_output.put_line('The customer you have added is');
    select * into Customer_ROW from CUSTOMER where CUSTOMER_ID = max_cid;
    dbms_output.put_line('CUSTOMER_ID:'||CUSTOMER_ROW.CUSTOMER_ID||' |CUSTOMER NAME:  '||CUSTOMER_ROW.CUSTOMER_NAME|| ' |DATE OF BIRTH:' ||CUSTOMER_ROW.DATE_OF_BIRTH|| ' | CONTACT:' ||CUSTOMER_ROW.CONTACT|| '| EMAIL:' ||CUSTOMER_ROW.Login_EMAIL|| '|GENDER:' ||CUSTOMER_ROW.GENDER|| '| CITY:' ||CUSTOMER_ROW.CITY|| '|STREET:'||CUSTOMER_ROW.STREET|| '|STATE:' ||CUSTOMER_ROW.STATE|| '| ZIPCODE:'||CUSTOMER_ROW.ZIPCODE );


    exception
    When Contact_Len_error Then
        raise_application_error (-20001,'Contact number should be 10 digits ');
    When Email_unique Then      
        raise_application_error (-20003,'Email should be unique');
    When gender_notin Then
        raise_application_error (-20004,'Gender values should be m or f');
    When ZIPCODE_NOTNUMBER Then
        raise_application_error (-20006,'ZIPCODE SHOULD CONTAIN ONLY NUMBERS');
    When email_invalid Then
        raise_application_error (-20007,'Email pattern invalid');

        end signup;

 Procedure assign_card_details(cust_id number, cardName varchar2, cardNumber varchar2, cardExpiryDate date, cardCVV number)
	
		  IS
		customer_card_id number;
        Card_id_error EXCEPTION;
        cnt number;
    BEGIN
    select card_id into customer_card_id from customer where CUSTOMER_ID=cust_id;
        select COUNT(cid)into cnt from card_details where cid=customer_card_id ;

        if(cnt>0) then
         RAISE Card_id_error;

		else 
        insert into  card_details (cid,card_name,card_number, expiry_date,cvv) VALUES(customer_card_id,cardName,cardNumber,cardExpiryDate,cardCVV);
          	end if;
        EXCEPTION
        WHEN Card_id_error THEN
        raise_application_error(-20001, 'CardId already exist in Database');

    END assign_card_details;
    
    
    
    END Customer_sign_in;
/

