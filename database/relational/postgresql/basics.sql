-- Haven't used Postgres for a long time? Here is a quick reminder:

-- Create database
CREATE DATABASE db_name;

-- Create table
CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Insert data
INSERT INTO user(name, rank) VALUES('John', 7);

-- Select data
SELECT * FROM user
WHERE name = 'John' and rank > 3;

-- Update data
UPDATE user
SET name = 'Rick',
    rank = 3
WHERE id = 11;

-- Delete data
DELETE FROM user WHERE id = 11;

-- Aggregation - count, average, sum
SELECT count(*), avg(rank), sum(rank) from user
WHERE rank > 2;

-- Pagination - sort, offset, limit
SELECT * FROM user
ORDER BY rank ASC
LIMIT 10 OFFSET 50;

-- Join
SELECT * FROM user u
INNER JOIN purchase p on p.user_id = u.id;

-- Create index
CREATE INDEX idx_user_rank on user(rank);

-- Check performance of a query
explain select * from user where name = 'John';
