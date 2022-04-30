set serveroutput on;
-- trigger to update customer status
CREATE OR REPLACE TRIGGER update_customer_status
AFTER INSERT
   ON Lab_order_line
   FOR EACH ROW
Begin
        
         UPDATE customer set status = 'Test' WHERE customer_id = :new.customer_id;
        DBMS_OUTPUT.PUT_LINE('customer id - '  || ' is in testing status');
END;
/
-- trigger to update transaction customer status
CREATE OR REPLACE TRIGGER update_transaction_customer_status
AFTER INSERT
   ON TRANSACTION_ENTITY
   FOR EACH ROW
Begin
        
         UPDATE customer set status = 'done' WHERE customer_id = :new.customer_id;

        DBMS_OUTPUT.PUT_LINE('customer id - '  || ' is in Done status');
END;
/


-- trigger to update billing customer status

CREATE OR REPLACE TRIGGER update_billing_customer_status
AFTER INSERT
   ON ENTITY_BILLING
   FOR EACH ROW
Begin
        
         UPDATE customer set status = 'Bill' WHERE customer_id = :new.customer_id;

        DBMS_OUTPUT.PUT_LINE('customer id - '  || ' is in Billing status');
END;
/


