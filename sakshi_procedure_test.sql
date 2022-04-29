set SERVEROUTPUT ON;
create or replace Procedure signup_entity_employee(E_name in ENTITY_EMPLOYEE.NAME%type ,  E_contact in ENTITY_EMPLOYEE.CONTACT%type, e_email in ENTITY_EMPLOYEE.EMAIL_ID%type ,  E_username in admin.username%type, E_password in admin.pasword%type)
is
max_eid number;
max_esid number;
maxesid number;
maxEmployeeId number;
emailCount number;
admin_name_count number;
contact_number_error exception;
emailId_unique exception;
email_Invalid exception;
same_name_error exception;

BEGIN 
    select count(*) into emailCount from ENTITY_EMPLOYEE where EMAIL_ID= e_email;
    select count(*) into admin_name_count from ENTITY_EMPLOYEE where NAME= E_name;
    select Max(EMPLOYEE_ID)into maxEmployeeId from ENTITY_EMPLOYEE;
    select Max(system_id)into maxesid from admin;
    max_eid := maxEmployeeId +1;
    max_esid := maxesid +1;
    
    if (emailCount>0)
        then raise emailId_unique;
    elsif (admin_name_count>0)
        then raise same_name_error;
    elsif check_email_pattern(e_email)=0
        then raise email_invalid;
    elsif  length(E_contact)<>10
        then raise contact_number_error;
        
    else 
        insert into admin(SYSTEM_ID,
        name,
        Username,
        pasword,
        contact,
        email_id
        )VALUES(max_esid,
        E_name,
        E_username,
        E_password,
        E_contact,
        e_email
        );
    insert into ENTITY_EMPLOYEE (EMPLOYEE_ID,
        NAME,
        CONTACT,
        EMAIL_ID,
        System_id 
        )VALUES
        (max_eid,
        E_name,
        E_contact,
        e_email,
        max_esid
        );
        end if;
        exception
    When contact_number_error Then
        raise_application_error (-20001,'Contact number should not be less than 10');
    When same_name_error then
        raise_application_error (-20003,'Name should be unique');
    When emailId_unique Then      
        raise_application_error (-20003,'Email id should be unique');
    When email_invalid Then
        raise_application_error (-20007,'Email pattern invalid');
        END signup_entity_employee;
        /
        
        
    exec signup_entity_employee('Sakshi', 9898912345, 'sakshi@gmail.com','Sakshi',1023456789 );
    exec signup_entity_employee('Taru', 09898912345, 'tarun@gmail.com','Taru',10234567898 );