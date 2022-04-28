CREATE OR REPLACE PACKAGE company_insurance_policy
AS
    Procedure C_signup
    (F_name in company.company_name%type, 
    License_no in company.license_number%type,
    Create_date in company.created_date%type , 
    user_name in admin.username%type, 
    pass_word in admin.pasword%type, 
    contact in admin.contact%type,
    c_email in admin.email_id%type);
    
    Procedure IP
    (Policy_tp insurance_policies.policy_type%type,
    prem insurance_policies.premium%type,
    c_code insurance_policies.c_code%type,
    time_p insurance_policies.time_period%type,
    sum_ass insurance_policies.sum_assuared%type,
    policy_bene insurance_policies.policy_benefits%type, 
    pre_req_disease policy_prerequisites.prerequisite_disease%type,
    prereq_test policy_prerequisites.prerequisite_test_name%type );
    
END company_insurance_policy;
/