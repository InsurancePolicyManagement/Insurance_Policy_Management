CREATE OR REPLACE PROCEDURE remove_objects (
    name_of_object VARCHAR2,
    type_of_object VARCHAR2
) IS
    cnt NUMBER := 0;
BEGIN
    IF upper(type_of_object) = 'Trigger' THEN
        SELECT
            COUNT(*)
        INTO cnt
        FROM
            user_tables
        WHERE
            upper(table_name) = upper(TRIM(name_of_object));

        IF cnt > 0 THEN
            EXECUTE IMMEDIATE 'drop Trigger ' || name_of_object || ' cascade constraints';
        END IF;
    END IF;

END;
/
CALL remove_objects('update_customer_status', 'Trigger');
set serveroutput on;
CREATE OR REPLACE TRIGGER update_customer_status
AFTER INSERT
   ON Lab_order_line
   FOR EACH ROW
Begin
        
         UPDATE customer set status = 'Test' WHERE customer_id = :new.customer_id;

        DBMS_OUTPUT.PUT_LINE('customer id - '  || ' is in testing status');
END;
/

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CALL remove_objects('update_transaction_customer_status', 'Trigger');
CREATE OR REPLACE TRIGGER update_transaction_customer_status
AFTER INSERT
   ON TRANSACTION_ENTITY
   FOR EACH ROW
Begin
        
         UPDATE customer set status = 'done' WHERE customer_id = :new.customer_id;

        DBMS_OUTPUT.PUT_LINE('customer id - '  || ' is in Done status');
END;
/


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

CALL remove_objects('update_billing_customer_status', 'Trigger');
CREATE OR REPLACE TRIGGER update_billing_customer_status
AFTER INSERT
   ON ENTITY_BILLING
   FOR EACH ROW
Begin
        
         UPDATE customer set status = 'Bill' WHERE customer_id = :new.customer_id;

        DBMS_OUTPUT.PUT_LINE('customer id - '  || ' is in Billing status');
END;
/


