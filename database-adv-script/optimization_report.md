# Query Performance Analysis
This document outlines the analysis and optimization of a complex query that retrieves **bookings** along with related **user, property, and payment details**.
## 1. Initial Query
This initial query is designed to demonstrate performance analysis. It retrieves all bookings along with extensive details from related tables. This query may be inefficient on a large dataset due to multiple joins.

See the [performance.sql](https://github.com/Fmukanda/-alx-airbnb-database/blob/6db6317441bf90d1e77ed930fa7567e5c2b8a85e/database-adv-script/perfomance.sql) file for SQL commands.
## 2. Performance Analysis
Run this analysis before optimization:
```sql
EXPLAIN ANALYZE
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status AS booking_status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    p.property_id,
    p.name AS property_name,
    p.location,
    pay.payment_id,
    pay.amount,
    pay.status AS payment_status,
    pay.created_at AS payment_created_at
FROM booking b
JOIN "user" u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;
```
>### Expected Inefficiencies Identified:
 - Sequential scans on large tables (booking, property) instead of index scans.
 - Expensive ORDER BY on b.created_at due to missing index.
 - Unnecessary columns retrieved (e.g., if not all fields are needed).
 - Joins on non-indexed foreign keys (booking.user_id, booking.property_id, payment.booking_id).

## 3. Refactored Query & Optimizations
>### Add Indexes
```sql
CREATE INDEX idx_booking_user_id ON booking(user_id);
CREATE INDEX idx_booking_property_id ON booking(property_id);
CREATE INDEX idx_booking_created_at ON booking(created_at);
CREATE INDEX idx_payment_booking_id ON payment(booking_id);
```
>### Refactor Query
```sql
SELECT 
    b.booking_id,
    b.start_date,
    b.end_date,
    b.total_price,
    u.first_name,
    u.last_name,
    p.name AS property_name,
    pay.amount,
    pay.status AS payment_status
FROM booking b
JOIN "user" u ON b.user_id = u.user_id
JOIN property p ON b.property_id = p.property_id
LEFT JOIN payment pay ON b.booking_id = pay.booking_id
ORDER BY b.created_at DESC;
```
>### Measure Again with EXPLAIN
EXPLAIN ANALYZE
```sql
 SELECT ...
 (optimized query);
```
>### Expected improvements
 - Index scans replace sequential scans.
 - Faster execution of ORDER BY due to idx_booking_created_at.
 - Reduced query execution time (lower Total Cost and Execution Time).
