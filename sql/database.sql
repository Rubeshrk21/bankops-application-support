CREATE DATABASE IF NOT EXISTS bankops;

USE bankops;

CREATE TABLE customers (
	    customer_id INT PRIMARY KEY,
	    customer_name VARCHAR(100) NOT NULL,
	    email VARCHAR(100),
	    phone VARCHAR(20),
	    status VARCHAR(20),
	    created_at DATETIME
);

CREATE TABLE accounts (
	    account_id INT PRIMARY KEY,
	    customer_id INT NOT NULL,
	    account_number VARCHAR(20) NOT NULL,
	    account_type VARCHAR(20),
	    balance DECIMAL(12,2),
	    status VARCHAR(20),
	    created_at DATETIME,
	    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE transactions (
	    transaction_id VARCHAR(20) PRIMARY KEY,
	    account_id INT NOT NULL,
	    transaction_type VARCHAR(30),
	    amount DECIMAL(12,2),
	    transaction_status VARCHAR(20),
	    error_code VARCHAR(50),
	    transaction_date DATETIME,
	    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE support_tickets (
	    ticket_id INT PRIMARY KEY,
	    customer_id INT NOT NULL,
	    transaction_id VARCHAR(20),
	    issue_type VARCHAR(50),
	    description VARCHAR(255),
	    priority VARCHAR(20),
	    status VARCHAR(20),
	    created_at DATETIME,
	    resolved_at DATETIME,
	    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

CREATE TABLE application_errors (
	    error_id INT PRIMARY KEY,
	    transaction_id VARCHAR(20) NOT NULL,
	    error_code VARCHAR(50),
	    error_message VARCHAR(255),
	    severity VARCHAR(20),
	    error_timestamp DATETIME,
	    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);
