USE bankops;

-- 1. Find all failed transactions
SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_status,
    error_code
FROM transactions
WHERE transaction_status = 'FAILED';


-- 2. Find the highest-value transaction
SELECT
    transaction_id,
    amount,
    transaction_status
FROM transactions
ORDER BY amount DESC
LIMIT 1;


-- 3. Count total transactions
SELECT COUNT(transaction_id) AS total_transactions
FROM transactions;


-- 4. Count transactions by status
SELECT
    transaction_status AS status,
    COUNT(transaction_id) AS count
FROM transactions
GROUP BY transaction_status;


-- 5. Find application errors that occurred more than once
SELECT
    error_code,
    COUNT(error_code) AS occurrence
FROM application_errors
GROUP BY error_code
HAVING COUNT(error_code) > 1;


-- 6. Find customer and account details for a customer
SELECT
    customer_name,
    account_number,
    account_type,
    balance,
    customers.status AS customer_status
FROM customers
INNER JOIN accounts
    ON customers.customer_id = accounts.customer_id
WHERE customers.customer_id = 1002;


-- 7. Investigate a specific transaction
SELECT
    customer_name,
    account_number,
    transaction_id,
    amount,
    transaction_status,
    error_code
FROM transactions
INNER JOIN accounts
    ON transactions.account_id = accounts.account_id
INNER JOIN customers
    ON accounts.customer_id = customers.customer_id
WHERE transaction_id = 'TXN10004';


-- 8. Find customer details for all failed transactions
SELECT
    customer_name,
    transaction_id,
    amount,
    error_code
FROM transactions
INNER JOIN accounts
    ON transactions.account_id = accounts.account_id
INNER JOIN customers
    ON accounts.customer_id = customers.customer_id
WHERE transaction_status = 'FAILED';


-- 9. Find all transactions for a specific customer
SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_status
FROM transactions
WHERE account_id = (
	    SELECT account_id
	    FROM accounts
	    WHERE customer_id = 1001
);


-- 10. Find transactions above the average transaction amount
SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_status
FROM transactions
WHERE amount > (
	    SELECT AVG(amount)
	    FROM transactions
);


-- 11. Find all high-severity application errors
SELECT
    error_id,
    transaction_id,
    error_code,
    error_message,
    severity,
    error_timestamp
FROM application_errors
WHERE severity = 'HIGH'
ORDER BY error_timestamp;


-- 12. Investigate a support ticket with its customer and transaction
SELECT
    support_tickets.ticket_id,
    customer_name,
    support_tickets.transaction_id,
    issue_type,
    description,
    priority,
    support_tickets.status
FROM support_tickets
INNER JOIN customers
    ON support_tickets.customer_id = customers.customer_id
WHERE support_tickets.ticket_id = 3001;
