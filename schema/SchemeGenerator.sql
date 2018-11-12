/*
Paolo Trinchieri
Homework #6
Oct 28, 2018
CS-4530

Chapter 15, Step 2:
Write a script that creates and calls a stored function named
test_glaccounts_description. 

First, create a function that tests whether an account description is
already in the General_Ledger_Accounts table.

To do that, this function should accept one parameter for the account
description, and it should return a value of 1 if the account description
is in the table or 0 if it isn't. 

Note: If a SELECT statement doesn't return any data, it raises a
NOT FOUND condition that your function can handle.)
*/


USE ap;

DROP PROCEDURE IF EXISTS test_glaccounts_description;

DELIMITER //

CREATE PROCEDURE test_glaccounts_description
(
  IN 	check_description      	VARCHAR(50),
  OUT	WasFound				INT
)
BEGIN
    
    DECLARE AccNumb INT;
    
 	DECLARE CONTINUE HANDLER FOR NOT FOUND
 		SET WasFound = FALSE;

 	SET WasFound = TRUE;

	SELECT account_number 
        INTO AccNumb
		FROM General_Ledger_Accounts
        WHERE account_description = check_description;
        
 	SELECT WasFound;

END//

DELIMITER ;

CALL test_glaccounts_description('Accounting',@WasFound);
CALL test_glaccounts_description('Uncounting',@WasFound);
CALL test_glaccounts_description('IBM Lease',@WasFound);
CALL test_glaccounts_description('IMB Lease',@WasFound);