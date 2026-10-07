USE bankops;

INSERT INTO customers
(customer_id, customer_name, email, phone, status, created_at)
VALUES
(1001, 'Arun Kumar', 'arun@example.com', '9000000001', 'ACTIVE', '2026-01-10 09:00:00'),
(1002, 'Priya Sharma', 'priya@example.com', '9000000002', 'ACTIVE', '2026-01-11 09:00:00'),
(1003, 'Rahul Das', 'rahul@example.com', '9000000003', 'ACTIVE', '2026-01-12 09:00:00'),
(1004, 'Sneha Raj', 'sneha@example.com', '9000000004', 'ACTIVE', '2026-01-13 09:00:00'),
(1005, 'Vikram Singh', 'vikram@example.com', '9000000005', 'BLOCKED', '2026-01-14 09:00:00'),
(1006, 'Divya Menon', 'divya@example.com', '9000000006', 'ACTIVE', '2026-01-15 09:00:00'),
(1007, 'Karthik Rao', 'karthik@example.com', '9000000007', 'ACTIVE', '2026-01-16 09:00:00'),
(1008, 'Meena Iyer', 'meena@example.com', '9000000008', 'ACTIVE', '2026-01-17 09:00:00');

INSERT INTO accounts
(account_id, customer_id, account_number, account_type, balance, status, created_at)
VALUES
(2001, 1001, 'ACC100001', 'SAVINGS', 25000.00, 'ACTIVE', '2026-01-10 09:05:00'),
(2002, 1002, 'ACC100002', 'SAVINGS', 42000.00, 'ACTIVE', '2026-01-11 09:05:00'),
(2003, 1003, 'ACC100003', 'CURRENT', 55000.00, 'ACTIVE', '2026-01-12 09:05:00'),
(2004, 1004, 'ACC100004', 'SAVINGS', 38000.00, 'ACTIVE', '2026-01-13 09:05:00'),
(2005, 1005, 'ACC100005', 'SAVINGS', 12000.00, 'BLOCKED', '2026-01-14 09:05:00'),
(2006, 1006, 'ACC100006', 'CURRENT', 67000.00, 'ACTIVE', '2026-01-15 09:05:00'),
(2007, 1007, 'ACC100007', 'SAVINGS', 31000.00, 'ACTIVE', '2026-01-16 09:05:00'),
(2008, 1008, 'ACC100008', 'SAVINGS', 47000.00, 'ACTIVE', '2026-01-17 09:05:00');

INSERT INTO transactions
(transaction_id, account_id, transaction_type, amount, transaction_status, error_code, transaction_date)
VALUES
('TXN10001', 2001, 'TRANSFER', 1500.00, 'SUCCESS', NULL, '2026-10-01 09:10:00'),
('TXN10002', 2002, 'PAYMENT', 2500.00, 'SUCCESS', NULL, '2026-10-01 09:25:00'),
('TXN10003', 2003, 'TRANSFER', 3200.00, 'SUCCESS', NULL, '2026-10-01 10:15:00'),
('TXN10004', 2004, 'TRANSFER', 4500.00, 'FAILED', 'DB_TIMEOUT', '2026-10-01 10:30:00'),
('TXN10005', 2005, 'TRANSFER', 1000.00, 'FAILED', 'ACCOUNT_BLOCKED', '2026-10-01 11:00:00'),
('TXN10006', 2006, 'PAYMENT', 1800.00, 'SUCCESS', NULL, '2026-10-01 11:20:00'),
('TXN10007', 2007, 'TRANSFER', 2200.00, 'PROCESSING', 'PROCESSING_DELAY', '2026-10-01 12:05:00'),
('TXN10008', 2008, 'PAYMENT', 2750.00, 'SUCCESS', NULL, '2026-10-01 12:30:00'),
('TXN10009', 2001, 'TRANSFER', 1200.00, 'SUCCESS', NULL, '2026-10-01 13:10:00'),
('TXN10010', 2002, 'TRANSFER', 5200.00, 'FAILED', 'DB_TIMEOUT', '2026-10-01 13:45:00'),
('TXN10011', 2003, 'PAYMENT', 1600.00, 'SUCCESS', NULL, '2026-10-01 14:15:00'),
('TXN10012', 2004, 'TRANSFER', 3000.00, 'SUCCESS', NULL, '2026-10-01 15:00:00');

INSERT INTO support_tickets
(ticket_id, customer_id, transaction_id, issue_type, description, priority, status, created_at, resolved_at)
VALUES
(3001, 1004, 'TXN10004', 'Transaction Failure',
	 'Transaction failed due to database connection timeout',
	 'HIGH', 'RESOLVED', '2026-10-01 10:35:00', '2026-10-01 11:00:00'),
(3002, 1005, 'TXN10005', 'Account Blocked',
	 'Transaction rejected because account is blocked',
	 'MEDIUM', 'RESOLVED', '2026-10-01 11:05:00', '2026-10-01 11:30:00'),
(3003, 1007, 'TXN10007', 'Processing Delay',
	 'Transaction processing exceeded expected response time',
	 'MEDIUM', 'RESOLVED', '2026-10-01 12:10:00', '2026-10-01 12:40:00'),
(3004, 1002, 'TXN10010', 'Transaction Failure',
	 'Transaction failed due to database connection timeout',
	 'HIGH', 'OPEN', '2026-10-01 13:50:00', NULL);

INSERT INTO application_errors
(error_id, transaction_id, error_code, error_message, severity, error_timestamp)
VALUES
(5001, 'TXN10004', 'DB_TIMEOUT',
	 'Database connection timeout while processing transaction',
	 'HIGH', '2026-10-01 10:30:02'),
(5002, 'TXN10005', 'ACCOUNT_BLOCKED',
	 'Transaction rejected because account is blocked',
	 'MEDIUM', '2026-10-01 11:00:03'),
(5003, 'TXN10007', 'PROCESSING_DELAY',
	 'Transaction processing exceeded expected response time',
	 'MEDIUM', '2026-10-01 12:05:10'),
(5004, 'TXN10010', 'DB_TIMEOUT',
	 'Database connection timeout while processing transaction',
	 'HIGH', '2026-10-01 13:45:02');
