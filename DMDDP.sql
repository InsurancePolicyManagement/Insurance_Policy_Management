-- Test case for signing up for customer
exec signup ('arjun@gmail.com', 'arjun121', 'arjun nayak', 7188444979, '19/May/1999', 'Jaipur','tremont st','MP',02114,'M',4);
-- Test case for Company sign up
exec C_signup('Tata', 123456789098, '22/Aug/2012', 'Arjun','Bhatia',7188444979, 'bhatia@gmail.com');
-- Test case for entering insurance policy by company
exec ip('Personal',300,11,'2y',50000, 'Health insurance protects you from unexpected, high medical costs.','Diabties','Insulin_resistance');
-- Test case for selecting a policy by customer
exec customer_input(32,34);
--Test case for looking for a bill by customer
exec billing(32);
---Test case for viewing transactions by customer
exec transactions(31,card);