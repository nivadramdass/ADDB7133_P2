SET SERVEROUTPUT ON;

-- Dropping existing tables if they exist

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customer_donation CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customer CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employee CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE donator CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE donation CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE delivery CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE returns CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE invoice CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Create customer table
CREATE TABLE customer (
    customer_id NUMBER(5) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    surname VARCHAR2(50) NOT NULL,
    address VARCHAR2(100),
    contact_number VARCHAR2(15),
    email VARCHAR2(100)
);

-- Inserting data into customer table
INSERT INTO customer VALUES (11011, 'Jack', 'Smith', '18 Water Rd', '0877277521', 'smith@isat.com');
INSERT INTO customer VALUES (11012, 'Pat', 'Hendricks', '22 Water Rd', '0834567891', 'ph@mcom.co.za');
INSERT INTO customer VALUES (11013, 'Andre', 'Clark', '101 Summer Lane', '0863257857', 'aclark@mcom.co.za');
INSERT INTO customer VALUES (11014, 'Kevin', 'Jones', '55 Mountain Way', '0612547895', 'kj@isat.co.za');
INSERT INTO customer VALUES (11015, 'Lucy', 'Williams', '5 Main Rd', '0827238521', 'Tw@mcal.co.za');

-- Create employee table
CREATE TABLE employee (
    employee_id VARCHAR2(6) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    surname VARCHAR2(50) NOT NULL,
    contact_number VARCHAR2(15),
    address VARCHAR2(100),
    email VARCHAR2(100)
);

-- Inserting data into employee table
INSERT INTO employee VALUES ('emp101', 'Jeff', 'Davis', '0877277521', '10 Main Road', 'jand@isat.com');
INSERT INTO employee VALUES ('emp102', 'Kevin', 'Marks', '0837377522', '18 Water Road', 'km@isat.com');
INSERT INTO employee VALUES ('emp103', 'Adanva', 'Adebayo', '0817117523', '21 Circle Lane', 'aa@isat.com');
INSERT INTO employee VALUES ('emp104', 'Xolani', 'Andrews', '0797215244', '1 Sea Road', 'arver@isat.com');
INSERT INTO employee VALUES ('emp105', 'Dryer', 'Samson', '0827122255', '12 Main Road', 'xosam@isat.com');

-- Create donator table
CREATE TABLE donator (
    donator_id NUMBER(5) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    surname VARCHAR2(50) NOT NULL,
    contact_number VARCHAR2(15),
    email VARCHAR2(100)
);

-- Inserting data into donator table
INSERT INTO donator VALUES (20111, 'Jeff', 'Watson', '0827172250', 'watson@ymail.com');
INSERT INTO donator VALUES (20112, 'Stephen', 'Jones', '0837865670', 'joness@ymail.com');
INSERT INTO donator VALUES (20113, 'James', 'Joe', '0878978650', 'jj@isat.com');
INSERT INTO donator VALUES (20114, 'Kelly', 'Ross', '0826575650', 'kross@gsat.com');
INSERT INTO donator VALUES (20115, 'Abraham', 'Clark', '0797656430', 'aclark@ymail.com');

-- Create donation table
CREATE TABLE donation (
    donation_id NUMBER(4) PRIMARY KEY,
    donator_id NUMBER(5) NOT NULL,
    item VARCHAR2(50) NOT NULL,
    price NUMBER(8, 2),
    donation_date DATE,
    FOREIGN KEY (donator_id) REFERENCES donator(donator_id)
);

-- Inserting data into donation table
INSERT INTO donation VALUES (7111, 20111, 'KIC Fridge', 599, TO_DATE('01-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO donation VALUES (7112, 20112, 'Samsung 42inch LCD', 1299, TO_DATE('03-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO donation VALUES (7113, 20113, 'Sharp Microwave', 1599, TO_DATE('03-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO donation VALUES (7114, 20115, '6 Seat Dining Table', 799, TO_DATE('05-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO donation VALUES (7115, 20114, 'Lazyboy Sofa', 1199, TO_DATE('07-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO donation VALUES (7116, 20113, 'JVC Surround Sound', 179, TO_DATE('09-MAY-2024', 'DD-MON-YYYY'));

-- Create delivery table
CREATE TABLE delivery (
    delivery_id NUMBER(4) PRIMARY KEY,
    delivery_notes VARCHAR2(100),
    dispatch_date DATE
);

-- Inserting data into delivery table
INSERT INTO delivery VALUES (511, 'Double packaging requested', TO_DATE('10-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO delivery VALUES (512, 'Delivery to work address', TO_DATE('12-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO delivery VALUES (513, 'Signature required', TO_DATE('12-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO delivery VALUES (514, 'No notes', TO_DATE('12-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO delivery VALUES (515, 'Birthday present wrapping required', TO_DATE('18-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO delivery VALUES (516, 'Delivery to work address', TO_DATE('20-MAY-2024', 'DD-MON-YYYY'));

-- Create invoice table before returns
CREATE TABLE invoice (
    invoice_num NUMBER(4) PRIMARY KEY,
    customer_id NUMBER(5) NOT NULL,
    invoice_date DATE,
    employee_id VARCHAR2(6) NOT NULL,
    delivery_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
);

-- Inserting data into invoice table
INSERT INTO invoice VALUES (8111, 11011, TO_DATE('15-MAY-2024', 'DD-MON-YYYY'), 'emp103', TO_DATE('15-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO invoice VALUES (8112, 11013, TO_DATE('15-MAY-2024', 'DD-MON-YYYY'), 'emp101', TO_DATE('15-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO invoice VALUES (8113, 11012, TO_DATE('17-MAY-2024', 'DD-MON-YYYY'), 'emp101', TO_DATE('17-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO invoice VALUES (8114, 11015, TO_DATE('17-MAY-2024', 'DD-MON-YYYY'), 'emp102', TO_DATE('15-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO invoice VALUES (8115, 11011, TO_DATE('17-MAY-2024', 'DD-MON-YYYY'), 'emp102', TO_DATE('19-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO invoice VALUES (8116, 11015, TO_DATE('18-MAY-2024', 'DD-MON-YYYY'), 'emp103', TO_DATE('25-MAY-2024', 'DD-MON-YYYY'));

-- Now creating the returns table after invoice creation
CREATE TABLE returns (
    return_id VARCHAR2(6) PRIMARY KEY,
    invoice_num NUMBER(4) NOT NULL,
    return_date DATE,
    reason VARCHAR2(100),
    FOREIGN KEY (invoice_num) REFERENCES invoice(invoice_num)
);

-- Inserting data into returns table
INSERT INTO returns VALUES ('ret001', 8111, TO_DATE('25-MAY-2024', 'DD-MON-YYYY'), 'Customer not satisfied with product');
INSERT INTO returns VALUES ('ret002', 8113, TO_DATE('25-MAY-2024', 'DD-MON-YYYY'), 'Product had broken section');

-- Question 2: Add delivery_id and donation_id to the invoice table to link them
ALTER TABLE invoice ADD (delivery_id NUMBER(4), donation_id NUMBER(4));

-- Adding foreign key constraints for delivery and donation
ALTER TABLE invoice ADD CONSTRAINT fk_delivery FOREIGN KEY (delivery_id) REFERENCES delivery(delivery_id);
ALTER TABLE invoice ADD CONSTRAINT fk_donation FOREIGN KEY (donation_id) REFERENCES donation(donation_id);

-- Updating invoice entries with delivery_id and donation_id
UPDATE invoice SET delivery_id = 511, donation_id = 7111 WHERE invoice_num = 8111;
UPDATE invoice SET delivery_id = 512, donation_id = 7112 WHERE invoice_num = 8113;
UPDATE invoice SET delivery_id = 513, donation_id = 7113 WHERE invoice_num = 8114;
UPDATE invoice SET delivery_id = 514, donation_id = 7114 WHERE invoice_num = 8114;
UPDATE invoice SET delivery_id = 515, donation_id = 7115 WHERE invoice_num = 8115;
UPDATE invoice SET delivery_id = 516, donation_id = 7116 WHERE invoice_num = 8116;

-- Pat should have the Samsung 42inch LCD (donation_id = 7112)
UPDATE invoice 
SET donation_id = 7112 
WHERE invoice_num = 8113;

-- Lucy should have the Sharp Microwave (donation_id = 7113)
UPDATE invoice 
SET donation_id = 7113 
WHERE invoice_num = 8114;

-- Lucy should also have the JVC Surround Sound (donation_id = 7116)
UPDATE invoice 
SET donation_id = 7116 
WHERE invoice_num = 8116;

-- Jack should have the Lazyboy Sofa (donation_id = 7115)
UPDATE invoice 
SET donation_id = 7115 
WHERE invoice_num = 8111;

-- Jack should also have the KIC Fridge (donation_id = 7111)
UPDATE invoice 
SET donation_id = 7111 
WHERE invoice_num = 8115;

-- Andre returned the 6 Seat Dining Table, so we remove the association by assigning NULL for donation_id
UPDATE invoice 
SET donation_id = 7114 
WHERE invoice_num = 8112;


-- Set appropriate column width for invoice_num
COLUMN invoice_num FORMAT 9999;

-- Set column widths for other fields as well if necessary
COLUMN customer_name FORMAT A15;
COLUMN employee_id FORMAT A10;
COLUMN delivery_notes FORMAT A20;
COLUMN donation_item FORMAT A15;
COLUMN invoice_date FORMAT A15;

-- Query to display all invoices after May 16th
SELECT 
    c.first_name || ' ' || c.surname AS customer_name, 
    i.employee_id, 
    d.delivery_notes, 
    don.item AS donation_item, 
    i.invoice_num, 
    i.invoice_date
FROM 
    invoice i
JOIN 
    customer c ON i.customer_id = c.customer_id
JOIN 
    delivery d ON i.delivery_id = d.delivery_id
JOIN 
    donation don ON i.donation_id = don.donation_id
WHERE 
    i.invoice_date > TO_DATE('16-MAY-2024', 'DD-MON-YYYY');

-- Question 3: Drop the funding table if it exists, avoiding errors when it does not exist
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE funding CASCADE CONSTRAINTS';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;
/

-- Creating the Funding table
CREATE TABLE funding (
    funding_id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY PRIMARY KEY, 
    funder VARCHAR2(100) NOT NULL,
    funding_amount NUMBER(10, 2)
);

-- Inserting data into funding table
INSERT INTO funding (funder, funding_amount) VALUES ('National Funding Corp', 50000.00);

-- Question 4: PL/SQL block to display returns with customer, donation item, price, and return reason
BEGIN
    FOR rec IN (
        SELECT 
            c.first_name || ' ' || c.surname AS customer_name,
            don.item AS donation_item,
            don.price AS donation_price,
            r.reason AS return_reason,
            r.return_date
        FROM 
            returns r
        JOIN 
            invoice i ON r.invoice_num = i.invoice_num
        JOIN 
            customer c ON i.customer_id = c.customer_id
        JOIN 
            donation don ON i.donation_id = don.donation_id
    ) 
    LOOP
        DBMS_OUTPUT.PUT_LINE('Customer: ' || rec.customer_name);
        DBMS_OUTPUT.PUT_LINE('Donation Item: ' || rec.donation_item);
        DBMS_OUTPUT.PUT_LINE('Price: ' || TO_CHAR(rec.donation_price, '9999.99'));
        DBMS_OUTPUT.PUT_LINE('Return Reason: ' || rec.return_reason);
        DBMS_OUTPUT.PUT_LINE('Return Date: ' || TO_CHAR(rec.return_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
END;
/


-- Question 5
SET SERVEROUTPUT ON;

-- PL/SQL block to display customer 11011's deliveries with employee, donation, dispatch date, delivery date, and days to delivery
BEGIN
    FOR rec IN (
        SELECT 
            c.first_name || ' ' || c.surname AS customer_name,
            e.first_name || ' ' || e.surname AS employee_name,
            don.item AS donation_item,
            d.dispatch_date,
            i.delivery_date,
            (i.delivery_date - d.dispatch_date) AS days_to_delivery
        FROM 
            invoice i
        JOIN 
            customer c ON i.customer_id = c.customer_id
        JOIN 
            employee e ON i.employee_id = e.employee_id
        JOIN 
            donation don ON i.donation_id = don.donation_id
        JOIN 
            delivery d ON i.delivery_id = d.delivery_id
        WHERE 
            i.customer_id = 11011  -- Only display information for customer 11011
    ) 
    LOOP
        -- Output each record
        DBMS_OUTPUT.PUT_LINE('CUSTOMER: ' || rec.customer_name);
        DBMS_OUTPUT.PUT_LINE('EMPLOYEE: ' || rec.employee_name);
        DBMS_OUTPUT.PUT_LINE('DONATION: ' || rec.donation_item);
        DBMS_OUTPUT.PUT_LINE('DISPATCH DATE: ' || TO_CHAR(rec.dispatch_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('DELIVERY DATE: ' || TO_CHAR(rec.delivery_date, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('DAYS TO DELIVERY: ' || rec.days_to_delivery);
        DBMS_OUTPUT.PUT_LINE('-----------------------------');
    END LOOP;
END;
/


-- Question 6
SET SERVEROUTPUT ON;

-- PL/SQL block to display the combined customer name and total amount spent by each customer
BEGIN
    FOR rec IN (
        SELECT 
            c.first_name, 
            c.surname, 
            SUM(don.price) AS total_amount
        FROM 
            invoice i
        JOIN 
            customer c ON i.customer_id = c.customer_id
        JOIN 
            donation don ON i.donation_id = don.donation_id
        GROUP BY 
            c.first_name, c.surname
    ) 
    LOOP
        -- Output each record
        DBMS_OUTPUT.PUT_LINE('FIRST NAME: ' || rec.first_name);
        DBMS_OUTPUT.PUT_LINE('SURNAME: ' || rec.surname);
        
        -- Calculate and display the amount with rating
        IF rec.total_amount >= 1500 THEN
            DBMS_OUTPUT.PUT_LINE('AMOUNT: R ' || TO_CHAR(rec.total_amount, '9999') || ' (***)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('AMOUNT: R ' || TO_CHAR(rec.total_amount, '9999'));
        END IF;

        DBMS_OUTPUT.PUT_LINE('------');
    END LOOP;
END;
/

-- Question 7
-- Q7.1: Example of %TYPE
SET SERVEROUTPUT ON;

DECLARE
    -- Declaring a variable with the same type as the 'email' column from the 'customer' table
    customer_email customer.email%TYPE;
    customer_id customer.customer_id%TYPE;
BEGIN
    -- Assigning a specific customer ID (for example, Jack's ID)
    customer_id := 11011;

    -- Retrieving the email of the customer using the %TYPE attribute variable
    SELECT email INTO customer_email 
    FROM customer 
    WHERE customer.customer_id = customer_id; -- Make sure to refer to the table's customer_id

    -- Output the email to the console
    DBMS_OUTPUT.PUT_LINE('Customer Email: ' || customer_email);
END;
/



-- Q7.2: Example of %ROWTYPE Attribute
SET SERVEROUTPUT ON;

DECLARE
    -- Declaring a record that holds the same structure as a row in the 'customer' table
    customer_record customer%ROWTYPE;
BEGIN
    -- Retrieving a full row for customer with ID 11011
    SELECT * INTO customer_record 
    FROM customer 
    WHERE customer_id = 11011;

    -- Output the customer details to the console
    DBMS_OUTPUT.PUT_LINE('Customer Name: ' || customer_record.first_name || ' ' || customer_record.surname);
    DBMS_OUTPUT.PUT_LINE('Address: ' || customer_record.address);
    DBMS_OUTPUT.PUT_LINE('Email: ' || customer_record.email);
    DBMS_OUTPUT.PUT_LINE('Contact Number: ' || customer_record.contact_number);
END;
/
-- End of Q7.2

-- Q7.3: Example of User-Defined Exception
SET SERVEROUTPUT ON;

DECLARE
    -- User-defined exception to handle the case where a customer has no donations
    no_donations_found EXCEPTION;
    total_donations NUMBER;

    customer_id customer.customer_id%TYPE := 11013;  -- Define the customer ID to check
BEGIN
    -- Calculate the total donations made by a specific customer
    SELECT SUM(don.price) INTO total_donations
    FROM invoice i
    JOIN donation don ON i.donation_id = don.donation_id
    WHERE i.customer_id = customer_id;

    -- If no donations are found (NULL or 0 total), raise the custom exception
    IF total_donations IS NULL THEN
        RAISE no_donations_found;
    ELSE
        -- Output the total amount donated if donations are found
        DBMS_OUTPUT.PUT_LINE('Total Donations by Customer ' || customer_id || ': R ' || total_donations);
    END IF;

EXCEPTION
    -- Handling the user-defined exception
    WHEN no_donations_found THEN
        DBMS_OUTPUT.PUT_LINE('Customer ' || customer_id || ' has not made any donations.');
END;
/
-- End of Q7.3

-- Question 8
SELECT 
    c.first_name, 
    c.surname, 
    'R ' || SUM(don.price) AS amount,
    CASE 
        WHEN SUM(don.price) >= 1500 THEN '***'  -- 3-star rating
        WHEN SUM(don.price) BETWEEN 1000 AND 1499 THEN '**'  -- 2-star rating
        ELSE '*'  -- 1-star rating
    END AS customer_rating
FROM 
    invoice i
JOIN 
    customer c ON i.customer_id = c.customer_id
JOIN 
    donation don ON i.donation_id = don.donation_id
GROUP BY 
    c.first_name, c.surname
ORDER BY 
    c.first_name;


SELECT 
    c.first_name || ' ' || c.surname AS customer_name,
    don.item AS donation_item,
    i.invoice_date
FROM 
    customer c
JOIN 
    invoice i ON c.customer_id = i.customer_id
JOIN 
    donation don ON i.donation_id = don.donation_id
ORDER BY 
    c.first_name, c.surname;
