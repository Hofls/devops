CREATE DATABASE customers_db;

CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL
);

CREATE INDEX customers_email_idx ON customers (email);

CREATE FUNCTION get_customer_count()
RETURNS INTEGER AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM customers);
END;
$$ LANGUAGE plpgsql;

CREATE VIEW customer_view AS
SELECT name, email, phone FROM customers;

CREATE MATERIALIZED VIEW customer_mat_view AS
select * from customer_view

INSERT INTO customers (name, email, phone)
VALUES
('John Smith', 'jsmith@example.com', '555-555-5555'),
('Jane Doe', 'jdoe@example.com', '555-555-5556'),
('Bob Johnson', 'bjohnson@example.com', '555-555-5557');

CREATE AGGREGATE sum_total (NUMERIC)
(
    SFUNC = NUMERIC_ADD,
    STYPE = NUMERIC,
    INITCOND = '0'
);