create or replace FUNCTION assign_card_details(customerId number, cardName varchar2, cardNumber varchar2, cardExpiryDate date, cardCVV number)
	
		RETURN number IS
		customer_card_id number;
        Card_id_error EXCEPTION;
        cnt number;
    BEGIN
        select COUNT(card_id)into cnt from customer where CUSTOMER_ID=customerId ;
        select card_id into customer_card_id from customer where CUSTOMER_ID=customerId;
        IF cnt>0 then
		INSERT INTO card_details(cid, card_name, card_number,expiry_date,cvv)VALUES(customer_card_id,cardName,cardNumber,cardExpiryDate,cardCVV);
		else 
            RAISE Card_id_error;
		end if;
        EXCEPTION
        WHEN Card_id_error THEN
        raise_application_error(-20001, 'CardId does not exist in Database');
        RETURN customer_card_id;
    END assign_card_details;
    
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
create or replace FUNCTION update_billing_transaction_details(customerId number, TRANSACTIONID NUMBER, TRANSACTIONTYPE VARCHAR, timedateSTAMP date, transStatus CHAR, transIssueAmount NUMBER)

		RETURN number IS
		customer_billing_id number;
        Customer_id_error EXCEPTION;
        cnt number;
    BEGIN
        select COUNT(CUSTOMER_ID)into cnt from ENTITY_BILLING where CUSTOMER_ID=customerId ;
        select CUSTOMER_ID into customer_billing_id from ENTITY_BILLING where CUSTOMER_ID=customerId;
        IF cnt>0 then
        Insert into TRANSACTION_ENTITY (TRANSACTION_ID,TRANSACTION_TYPE,TIME_STAMP,STATUS,CUSTOMER_ID,ISSUED_AMOUNT) values (TRANSACTIONID,TRANSACTIONTYPE,timedateSTAMP,transStatus,customer_billing_id,transIssueAmount);
		else 
            RAISE Customer_id_error;
		end if;
        EXCEPTION
        WHEN Customer_id_error THEN
        raise_application_error(-20001, 'Customer Id does not exist in Database');
        RETURN customer_billing_id;
    END update_billing_transaction_details;
    