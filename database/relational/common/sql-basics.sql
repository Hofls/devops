-- Haven't used SQL for a long time? Here is a quick reminder:

-- Create database
CREATE DATABASE db_name;

-- Create table
CREATE TABLE customer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    rank BIGINT
);

-- Insert data
INSERT INTO customer(name, rank) VALUES('John', 7);

-- Select data
SELECT * FROM customer
WHERE name = 'John' and rank > 3;

-- Update data
UPDATE customer
SET name = 'Rick',
    rank = 3
WHERE id = 11;

-- Delete data
DELETE FROM customer WHERE id = 11;

-- Aggregation - count, average, sum
SELECT count(*), avg(rank), sum(rank) from customer
WHERE rank > 2;

-- Pagination - sort, offset, limit
SELECT * FROM customer
ORDER BY rank ASC
LIMIT 10 OFFSET 50;

-- Join
SELECT * FROM customer u
INNER JOIN purchase p on p.customer_id = u.id;

-- Create index
CREATE INDEX idx_customer_rank on customer(rank);

-- Check performance of a query
explain select * from customer where name = 'John';
