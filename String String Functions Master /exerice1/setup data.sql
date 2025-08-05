create table raw_customers (
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
