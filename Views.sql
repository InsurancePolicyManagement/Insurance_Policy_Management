
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


    IF upper(type_of_object) = 'VIEW' THEN
        SELECT
            COUNT(*)
        INTO cnt
        FROM
            user_views
        WHERE
            upper(view_name) = upper(name_of_object);

        IF cnt > 0 THEN
            EXECUTE IMMEDIATE 'DROP VIEW ' || name_of_object;
        END IF;
    END IF;

END;
/
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Customer Bill along with Policy Id

CALL remove_objects('customer_bill', 'view');

create view customer_bill as
select customer.customer_id ,customer.customer_name, entity_billing.policy_id, entity_billing.bill_ammount from
customer inner join entity_billing on
customer.customer_id = entity_billing.customer_id;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Customer Pre-Requisite Test along with Policy Id and Disease

CALL remove_objects('v_policy_info', 'view');

create view v_policy_info as
select customer.customer_id ,customer.customer_name, customer.policy_number, policy_prerequisites. prerequisite_disease, policy_prerequisites.prerequisite_test_name
from customer inner join policy_prerequisites on
customer.policy_number = policy_prerequisites.policy_number
order by customer.customer_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Customer Card Details along with expiry Date 

CALL remove_objects('v_customer_card', 'view');

create view v_customer_card as
select customer.customer_id, customer.customer_name, customer.address, customer.date_of_birth, customer.contact, customer.email, card_details.card_number, card_details.cvv, card_details.expiry_date
from customer inner join card_details on
customer.customer_id = card_details.cid;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Customer Policy Name table along with Premimum Information

CALL remove_objects('V_policy_look', 'view');

create view V_policy_look as
select entity_employee.employee_id, entity_employee.name, customer.customer_id, customer.customer_name,
insurance_policies.policy_number, insurance_policies.policy_type, insurance_policies.premium
from entity_employee inner join customer on
entity_employee.employee_id = customer.employee_id
inner join insurance_policies on
customer.policy_number = insurance_policies.policy_number;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Hospital table with Customer 

CALL remove_objects('V_ECH', 'view');

create view V_ECH as
select entity_employee.employee_id, entity_employee.name, customer.customer_id, customer.customer_name,
lab_order_line.labid,lab_order_line.price,hospital.hospital_id, hospital.h_name, hospital.address
from entity_employee inner join customer on
entity_employee.employee_id = customer.employee_id
inner join lab_order_line on
customer.customer_id= lab_order_line.customer_id
inner join hospital on
lab_order_line.hospital_id = hospital.hospital_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Customer Transaction details with Transaction Status

CALL remove_objects('V_E_Tran_Check', 'view');

create view V_E_Tran_Check as
select entity_employee.employee_id, entity_employee.name, customer.customer_id, customer.customer_name,
entity_billing.bill_id, entity_billing.bill_ammount, entity_billing.time_stamp,
transaction_entity.transaction_type, transaction_entity.status
from entity_employee inner join customer on
entity_employee.employee_id = customer.employee_id
inner join entity_billing on
customer.customer_id = entity_billing.customer_id
inner join transaction_entity on
entity_billing.transaction_id = transaction_entity.transaction_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Customer Policy Details along with Sum Assuared

CALL remove_objects('V_CompanyPolicy', 'view');

create view V_CompanyPolicy as
select company.company_name,insurance_policies.policy_number, insurance_policies.policy_type, insurance_policies.premium,
insurance_policies.time_period, insurance_policies.sum_assuared
from company inner join insurance_policies on
company.company_code = insurance_policies.c_code;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--View for Number of Customer who are also Employee

CALL remove_objects('V_EmployeeCustomerCount', 'view');

CREATE OR REPLACE VIEW V_EmployeeCustomerCount AS
select distinct(employee_id), count(customer_id) as Number_of_customers
from customer
group by employee_id
order by employee_id;