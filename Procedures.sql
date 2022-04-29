--Procedure For company signup


Create or replace Procedure C_signup(F_name in company.company_name%type, License_no in company.license_number%type, Create_date in company.created_date%type , user_name in admin.username%type, pass_word in admin.pasword%type, contact in admin.contact%type,c_email in admin.email_id%type)
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
        /
        
      
     

—————————————————————————————————————————————————————————————————————————————————————————————————
--procedure for customer signup

create or replace Procedure signup(s_email IN varchar, pass_word VARCHAR, F_name varchar, contact varchar, dob date, City varchar, street varchar, states varchar
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
ca_id number;
max_ca_id number;
BEGIN
    select count(*) into countUnique from customer where login_email= s_email;
    select max(card_id) into ca_id from customer;
    max_ca_id := ca_id+1;
    
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
    card_id,
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
    max_ca_id,
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
    /
        

    
——————————————————————————————————————————————————————————————————————————————
--procedure for registering insurance policies 
    
    set serveroutput on;
create or replace Procedure IP(Policy_tp insurance_policies.policy_type%type, prem insurance_policies.premium%type,c_code insurance_policies.c_code%type,
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
    /
————————————————————————————————————————————————————————————————————
--Anonymous  block to see the registered policy

begin
DBMS_OUTPUT.PUT_LINE('Company_name  | Policy__number | Policy_type | Premium | Time_Period | Sum_assured');
for row_show in (select company_name,policy_number, policy_type, premium,  time_period, Sum_assuared  from policydetails order by policy_number) loop
 DBMS_OUTPUT.PUT_LINE(row_show.company_name|| '| '||row_show.policy_number||'|'||row_show.policy_type||'|'||row_show.premium||'|'||row_show.time_period||'|'||row_show.sum_assuared);
 end loop;
 end;

————————————————————————————————————————————————————————————————————————————————————————————————————————
--Customer Selecting the policy

Create or replace Procedure Customer_input( c_id customer.customer_id%type, Chosen_policy insurance_policies.policy_number%type) IS

P_number insurance_policies.policy_number%type;
pre_mium insurance_policies.premium%type;
pptc policy_prerequisites.policy_prerequisite_test_code%type;
prd policy_prerequisites.prerequisite_disease%type;
prtn policy_prerequisites.prerequisite_test_name%type;
s policy_prerequisites.status%type;
cnt policy_prerequisites.policy_prerequisite_test_code%type;
maxlid number;
maxbill number;
max_bill number;
max_lid number;
cnt_1 number;
addition number;
trans number;
trans_max number;
bill customer.premium%type;
lab_idunique exception;
lcount number;
begin

select count (*) into lcount from lab_order_line where customer_id = c_id;
select count(*) into pptc from policy_prerequisites where policy_number = chosen_policy;

select policy_number, premium into P_number,pre_mium from insurance_policies where policy_number = Chosen_policy;

if (lcount>0)
        then raise lab_idunique;
end if;
if (pptc>0)then 
    Update CUSTOMER SET POLICY_NUMBER =  p_number, Premium=pre_mium, status= 'Wait' where customer_id= c_id;
     select count(policy_prerequisite_test_code) into cnt from policy_prerequisites where policy_number = chosen_policy;
       select policy_prerequisite_test_code into prd from policy_prerequisites where policy_number = chosen_policy;
    
        select Max(labid)into maxlid from lab_order_line;
        max_lid := maxlid +1;
        insert into lab_order_line (labid,Hospital_id ,pre_requisite_test_code,customer_id,price)values(max_lid,3,prd,c_id, 30);
    

    else 
     Update CUSTOMER SET POLICY_NUMBER =  p_number, Premium=pre_mium, status= 'Bill' where customer_id= c_id;
end if;



for row_show in (select Customer_id,customer_name,policy_number, premium, status from customer where customer_id =c_id) loop
 DBMS_OUTPUT.PUT_LINE('Customer_ID:'||row_show.customer_id|| '| Customer_name: '||row_show.customer_name||'| Policy_selected:'||row_show.policy_number||'| Poilcy Premium:'||row_show.premium||'| Current Status:'||row_show.status);
 end loop;

 for row_show in (select policy_prerequisite_test_code, prerequisite_disease, prerequisite_test_name, Status from policy_prerequisites where policy_number = chosen_policy) loop
         DBMS_OUTPUT.PUT_LINE('policy_prerequisite_test_code:'||row_show.policy_prerequisite_test_code|| '| prerequisite_disease: '||row_show.prerequisite_disease||'| prerequisite_test_name:'||row_show.prerequisite_test_name||'|Status:'||row_show.Status);

    
 end loop;

    
exception
    When lab_idunique Then
        raise_application_error (-20001,'Customer should be unique ');

        
 end Customer_input;
 /
——————————————————————————————————————————————————————————————————————————

--Customer Bill:


create or replace procedure billing(c_id customer.customer_id%type) IS
maxlid number;
maxbill number;
max_bill number;
max_lid number;
cnt_1 number;
addition number;
trans number;
trans_max number;
bill customer.premium%type;
cnt number;
acount number;
billing_unique exception;
begin

select count (*) into acount from entity_billing where customer_id = c_id;
if (acount>0)
then  raise Billing_unique;

end if;
select policy_number into cnt from customer where customer_id= c_id;
select premium into bill from customer where customer_id= c_id;
    select Max(labid)into maxlid from lab_order_line;
    select max(transaction_id) into trans from entity_billing;
    trans_max := trans+1;
    select max(bill_id) into maxbill from entity_billing;
    max_bill := maxbill +1;
    SELECT SUM(CUSTOMER.PREMIUM +LAB_ORDER_LINE.PRICE) into addition
    FROM CUSTOMER INNER JOIN LAB_ORDER_LINE 
    ON CUSTOMER.CUSTOMER_ID=LAB_ORDER_LINE.CUSTOMER_ID 
    WHERE LAB_ORDER_LINE.CUSTOMER_ID=c_id;
    if (addition>0) then 
    insert into entity_billing(bill_id, transaction_id, bill_ammount, time_stamp, customer_id, policy_id,lab_id) values(max_bill,trans_max,addition,Sysdate,c_id,cnt,maxlid); 
 else 
    insert into entity_billing(bill_id, transaction_id, bill_ammount, time_stamp, customer_id, policy_id,lab_id) values(max_bill,trans_max,bill,Sysdate,c_id,cnt,NULL); 
 end if;
 
 for row_show in (select bill_id, transaction_id, bill_ammount, time_stamp ,customer_id, policy_id, lab_id from entity_billing where customer_id = c_id) loop
         DBMS_OUTPUT.PUT_LINE('bill_id:'||row_show.bill_id|| '| transaction_id: '||row_show.transaction_id||'| bill_ammount:'||row_show.bill_ammount||'|time_stamp:'||row_show.time_stamp||'|customer_id:'|| row_show.customer_id|| '|policy_id:'||row_show.policy_id|| '| lab_id'||row_show.lab_id);


 end loop;
 
 exception
    When Billing_unique Then
        raise_application_error (-20001,'Customer should be unique ');

 end billing;
 /—————————————————————————————————————————————————————————————————————————————————————————————————————
--Customer transactions:

create or replace procedure transactions(c_id customer.customer_id%type, t_type transaction_entity.transaction_type%type) is
trans number;
trans_max number;
bill entity_billing.bill_ammount%type;

begin


select max(transaction_id) into trans from entity_billing;
    trans_max := trans+1;
    
select bill_ammount into bill from entity_billing where customer_id= c_id;

insert into transaction_entity (Transaction_id, transaction_type,Time_stamp,status,Customer_id,Issued_amount)VALUES (trans_max,t_type, Sysdate,'Y',c_id,bill);

for row_show in (select Transaction_id, transaction_type, Time_stamp, Customer_id ,Issued_amount from transaction_entity where customer_id = c_id) loop
         DBMS_OUTPUT.PUT_LINE('Transaction_id:'||row_show.Transaction_id|| '| transaction_type: '||row_show.transaction_type||'| Time_stamp:'||row_show.Time_stamp||'|Customer_id:'||row_show.Customer_id||'|Issued Amount:'|| row_show.Issued_amount);

     
 end loop;
end transactions;
/

