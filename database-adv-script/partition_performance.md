# Database Partitioning Booking Table
This document explains how we improved query performance on a large **Booking** table by implementing **partitioning** on the `start_date` column.

## 1. Implement Partitioning
Since the `Booking` table is very large and queries filtering by date range are slow, we applied **range partitioning** on the `start_date` column.

See the full implementation in [`partitioning.sql`](partitioning.sql)

## 2. Performance Testing Queries
```sql
-- Test 1: Query for specific date range (should use partition pruning)
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30'
AND status = 'confirmed';

-- Compare with original table
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30'
AND status = 'confirmed';

-- Test 2: Query across multiple partitions
EXPLAIN ANALYZE
SELECT * FROM booking_partitioned
WHERE start_date BETWEEN '2023-12-20' AND '2024-01-10';

-- Test 3: Aggregate queries with date filtering
EXPLAIN ANALYZE
SELECT 
    DATE_TRUNC('month', start_date) as month,
    COUNT(*) as bookings,
    AVG(total_price) as avg_price
FROM booking_partitioned
WHERE start_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY DATE_TRUNC('month', start_date)
ORDER BY month;

-- Test 4: Join queries with partitioned table
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    u.first_name,
    u.last_name,
    p.name as property_name
FROM booking_partitioned b
INNER JOIN "user" u ON b.user_id = u.user_id
INNER JOIN property p ON b.property_id = p.property_id
WHERE b.start_date BETWEEN '2024-07-01' AND '2024-07-31'
ORDER BY b.start_date;

-- Test 5: Complex query with multiple conditions
EXPLAIN ANALYZE
SELECT 
    status,
    COUNT(*) as count,
    AVG(total_price) as avg_price,
    AVG(end_date - start_date) as avg_nights
FROM booking_partitioned
WHERE start_date >= '2024-01-01'
```
AND total_price > 100
GROUP BY status;
