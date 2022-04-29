CREATE OR REPLACE PACKAGE BODY sign_in AS 
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
        END C_Signup ;
        
        
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


END sign_in;
/

