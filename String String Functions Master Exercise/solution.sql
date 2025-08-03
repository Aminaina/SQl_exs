-- ============================================================================
-- SQL STRING FUNCTIONS EXERCISE - COMPLETE SOLUTION
-- Based on your provided solution approach
-- ============================================================================

-- Setup Data
CREATE TABLE raw_customers (
    id INT IDENTITY(1,1) PRIMARY KEY,
    full_name NVARCHAR(200),
    email NVARCHAR(150),
    phone NVARCHAR(50),
    address NVARCHAR(300),
    city NVARCHAR(100),
    state_code NVARCHAR(10),
    zip_code NVARCHAR(20)
);

INSERT INTO raw_customers VALUES
('  JOHN   DOE  ', '  JOHN.DOE@GMAIL.COM  ', '(555) 123-4567', '123 MAIN ST APT 4B', '  New York  ', 'ny', '10001-1234'),
('jane smith', 'JANE_SMITH@HOTMAIL.COM', '555.987.6543', '456 Oak Avenue', 'los angeles', 'CA', '90210'),
('  Bob Johnson Jr.  ', 'bob.johnson@company.co.uk', '+1-555-456-7890', '789 Pine Street, Unit 2', 'Chicago', 'IL', '60601-0000'),
('mary o''connor', 'mary.oconnor@email.net', '5551234567', '321 Elm Drive', 'houston', 'tx', '77001'),
('DAVID WILLIAMS III', 'david.williams+work@domain.org', '(555) 111-2222 ext 123', '654 Cedar Lane', 'Phoenix', 'AZ', '85001-9999');

-- ============================================================================
-- PART 1: INITIAL DATA VIEW
-- ============================================================================
SELECT * FROM raw_customers;

-- ============================================================================
-- PART 2: CLEAN CUSTOMER NAMES (TRIM + UPPER)
-- ============================================================================

-- Remove leading and trailing spaces from full_name
UPDATE raw_customers
SET full_name = LTRIM(RTRIM(full_name));

-- Convert full_name to uppercase
UPDATE raw_customers
SET full_name = UPPER(full_name);

-- ============================================================================
-- PART 3: CLEAN EMAIL ADDRESSES (LOWER + REPLACE + TRIM)
-- ============================================================================

-- Convert emails to lowercase
UPDATE raw_customers
SET email = LOWER(email);

-- Replace underscores and plus signs with dots (optional cleaning)
UPDATE raw_customers
SET email = REPLACE(REPLACE(email, '+', '.'), '_', '.');

-- Remove leading and trailing spaces from email
UPDATE raw_customers
SET email = TRIM(email);

-- ============================================================================
-- PART 4: EXTRACT PHONE EXTENSIONS (SUBSTRING + CHARINDEX + CASE)
-- ============================================================================

-- First, test the extension extraction logic
SELECT phone, 
    CASE 
        WHEN LOWER(phone) LIKE '%ext%' THEN 
            LTRIM(SUBSTRING(phone, CHARINDEX('ext', LOWER(phone))+3, 50))
        WHEN LOWER(phone) LIKE '%extension%' THEN 
            LTRIM(SUBSTRING(phone, CHARINDEX('extension', LOWER(phone))+9, 50))
        WHEN LOWER(phone) LIKE '%x[0-9]%' THEN 
            RIGHT(phone, LEN(phone) - CHARINDEX('x', LOWER(phone)))
        ELSE NULL
    END AS extracted_extension
FROM raw_customers;

-- Add extension column to table
ALTER TABLE raw_customers
ADD extension VARCHAR(10);

-- Update extension column with extracted values
UPDATE raw_customers
SET extension = CASE 
    WHEN LOWER(phone) LIKE '%ext%' THEN 
        LTRIM(SUBSTRING(phone, CHARINDEX('ext', LOWER(phone))+3, 50))
    WHEN LOWER(phone) LIKE '%extension%' THEN 
        LTRIM(SUBSTRING(phone, CHARINDEX('extension', LOWER(phone))+9, 50))
    WHEN LOWER(phone) LIKE '%x%' THEN 
        RIGHT(phone, LEN(phone) - CHARINDEX('x', LOWER(phone)))
    ELSE NULL
END;

-- Remove extension part from phone numbers
UPDATE raw_customers
SET phone = CASE 
    WHEN LOWER(phone) LIKE '%ext%' THEN 
        LEFT(phone, CHARINDEX('ext', LOWER(phone))-1)
    WHEN LOWER(phone) LIKE '%extension%' THEN 
        LEFT(phone, CHARINDEX('extension', LOWER(phone))-1)
    WHEN LOWER(phone) LIKE '%x%' THEN 
        LEFT(phone, CHARINDEX('x', LOWER(phone))-1)
    ELSE phone
END;

-- ============================================================================
-- PART 5: CLEAN PHONE NUMBERS (REPLACE)
-- ============================================================================

-- Remove all formatting characters from phone numbers
UPDATE raw_customers
SET phone = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '(',''), ')',''), '-',''), '.',''), '+','');

-- Test the phone cleaning (view results)
SELECT phone, 
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '(',''), ')',''), '-',''), '.',''), '+','') AS cleaned_phone
FROM raw_customers;

-- ============================================================================
-- PART 6: CLEAN ADDRESS DATA (UPPER + TRIM + REPLACE)
-- ============================================================================

-- Clean address field
UPDATE raw_customers
SET address = REPLACE(UPPER(TRIM(address)), ',', '');

-- Clean city field
UPDATE raw_customers
SET city = UPPER(TRIM(city));

-- Clean state_code field
UPDATE raw_customers
SET state_code = UPPER(TRIM(state_code));

-- Test state code cleaning
SELECT id, state_code, REPLACE(UPPER(TRIM(state_code)), ',', '') AS cleaned_state
FROM raw_customers;

-- ============================================================================
-- PART 7: VIEW FINAL CLEANED DATA
-- ============================================================================

-- Display all cleaned data
SELECT * FROM raw_customers;

-- ============================================================================
-- PART 8: ADDITIONAL TRANSFORMATIONS (BONUS)
-- ============================================================================

-- Extract first name (everything before first space)
SELECT full_name,
    CASE 
        WHEN CHARINDEX(' ', full_name) > 0 THEN
            LEFT(full_name, CHARINDEX(' ', full_name) - 1)
        ELSE full_name
    END AS first_name
FROM raw_customers;

-- Extract last name (everything after last space)
SELECT full_name,
    CASE 
        WHEN CHARINDEX(' ', REVERSE(full_name)) > 0 THEN
            RIGHT(full_name, CHARINDEX(' ', REVERSE(full_name)) - 1)
        ELSE full_name
    END AS last_name
FROM raw_customers;

-- Extract email username (before @)
SELECT email,
    LEFT(email, CHARINDEX('@', email) - 1) AS username
FROM raw_customers;

-- Extract email domain (after @)
SELECT email,
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS domain
FROM raw_customers;

-- Create formatted mailing address
SELECT CONCAT(full_name, CHAR(13) + CHAR(10), 
              address, CHAR(13) + CHAR(10),
              city, ', ', state_code, ' ', zip_code) AS mailing_label
FROM raw_customers;

-- ============================================================================
-- PART 9: DATA QUALITY SUMMARY
-- ============================================================================

-- Count of records processed
SELECT COUNT(*) AS total_records FROM raw_customers;

-- Summary of extensions found
SELECT extension, COUNT(*) AS count
FROM raw_customers 
WHERE extension IS NOT NULL
GROUP BY extension;

-- Summary of email domains
SELECT SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS domain,
       COUNT(*) AS count
FROM raw_customers
GROUP BY SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email));

-- ============================================================================
-- PART 10: COMPREHENSIVE CLEANED VIEW
-- ============================================================================

-- Create a complete view showing original vs cleaned data
SELECT 
    id,
    -- Original data would be shown here if we had backup
    full_name AS cleaned_name,
    email AS cleaned_email,
    phone AS cleaned_phone,
    extension,
    address AS cleaned_address,
    city AS cleaned_city,
    state_code AS cleaned_state,
    zip_code,
    -- Derived fields
    LEFT(full_name, CHARINDEX(' ', full_name) - 1) AS first_name,
    CASE 
        WHEN CHARINDEX(' ', REVERSE(full_name)) > 0 THEN
            RIGHT(full_name, CHARINDEX(' ', REVERSE(full_name)) - 1)
        ELSE full_name
    END AS last_name,
    LEFT(email, CHARINDEX('@', email) - 1) AS email_username,
    SUBSTRING(email, CHARINDEX('@', email) + 1, LEN(email)) AS email_domain,
    CONCAT(address, ', ', city, ', ', state_code, ' ', zip_code) AS full_address
FROM raw_customers;

-- ============================================================================
-- NOTES:
-- This solution demonstrates all major string functions:
-- - LTRIM/RTRIM/TRIM: Remove spaces
-- - UPPER/LOWER: Case conversion  
-- - SUBSTRING: Extract parts of strings
-- - CHARINDEX: Find character positions
-- - REPLACE: Character substitution
-- - CONCAT: Combine strings
-- - LEFT/RIGHT: Extract from ends
-- - LEN: String length
-- - CASE WHEN: Conditional logic
-- ============================================================================
