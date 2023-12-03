USE GamersRUs;

-- ADMIN rights to admin
CREATE USER 'admin1'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON GamersRus.* TO 'admin1'@'localhost';

-- TOMMYBOI can read and write everything
CREATE USER 'TOMMYBOI'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT, INSERT, UPDATE, DELETE ON GamersRus.* TO 'TOMMYBOI'@'localhost';

-- KIM_ANALYST can only read from all tables to perform analytics 
CREATE USER 'KIM_ANALYST'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON GamersRus.* TO 'KIM_ANALYST'@'localhost';

-- CS_Darren can only see Customer as he is over customer success
CREATE USER 'CS_Darren'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON GamersRus.Customer TO 'CS_Darren'@'localhost';
FLUSH PRIVILEGES;
