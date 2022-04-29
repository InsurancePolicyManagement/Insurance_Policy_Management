CREATE OR REPLACE PACKAGE sign_in AS 
Procedure C_signup(F_name in company.company_name%type, License_no in company.license_number%type, Create_date in company.created_date%type , user_name in admin.username%type, pass_word in admin.pasword%type, contact in admin.contact%type,c_email in admin.email_id%type);
 Procedure signup(s_email IN varchar, pass_word VARCHAR, F_name varchar, contact varchar, dob date, City varchar, street varchar, states varchar
,zipcode number,Gender varchar,emp_id number);

END sign_in;
/

