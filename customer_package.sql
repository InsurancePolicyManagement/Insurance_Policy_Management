CREATE OR REPLACE PACKAGE customer_package
AS    
        PROCEDURE signup(s_email IN varchar, 
                        pass_word VARCHAR,
                        F_name varchar, 
                        contact varchar,
                        dob date,
                        City varchar, 
                        street varchar, 
                        states varchar,
                        zipcode number,
                        Gender varchar,
                        emp_id number);
        FUNCTION assign_card_details(customerId number,
                                    cardName varchar2,
                                    cardNumber varchar2, 
                                    cardExpiryDate date, 
                                    cardCVV number)
                return number; 
    
END customer_package;
/