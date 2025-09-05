# Database Indexing and Performance Strategy
This document explains the indexing decisions for the **User**, **Booking**, and **Property** tables based on their query usage.
## 1. High-Usage Columns Identification
> ### User Table
 - **user_id:** primary key, used in JOINs and WHERE clauses
 - **email:** unique constraint, used in WHERE clauses for authentication
 - **role:** used in WHERE clauses for filtering by user type
 - **created_at:** Used in ORDER BY for chronological sorting

> ### Booking Table
 - **booking_id:** primary key, used in JOINs and WHERE clauses
 - **user_id:** foreign key, used in JOINs with user table
 - **property_id:** foreign key, used in JOINs with property table
 - **status:** used in WHERE clauses for filtering booking status
 - **start_date:** used in WHERE clauses for date range queries
 - **end_date:** used in WHERE clauses for filtering booking status
 - **created_at:** used in ORDER BY for chronological sorting

> ### Property Table
 - **property_id:** primary key, used in JOINs and WHERE clauses
 - **host_id:** foreign key, used in JOINs with user table
 - **location:** used in WHERE clauses for location-based filtering
 - **pricepernight :** used in WHERE clauses for price filtering and ORDER BY
 - **created_at:** used in ORDER BY for chronological sorting
   
## 2. Creating Database Indexes
See the [database_index.sql](https://github.com/Fmukanda/-alx-airbnb-database/blob/0a269de4152830a70f86dd936e1ef853d2e1e829/database-adv-script/database_index.sql) file for the specific CREATE INDEX commands.

## 3. Measuring Query Performance
>### Before Adding Indexes
Run these commands to measure baseline performance:
```sql
-- Example 1: User bookings query
EXPLAIN ANALYZE
SELECT u.user_id, u.first_name, u.last_name, COUNT(b.booking_id) as total_bookings
FROM "user" u
INNER JOIN booking b ON u.user_id = b.user_id
WHERE u.role = 'guest'
GROUP BY u.user_id
HAVING COUNT(b.booking_id) > 2
ORDER BY total_bookings DESC;

-- Example 2: Property reviews query
EXPLAIN ANALYZE
SELECT p.property_id, p.name, p.location, AVG(r.rating) as avg_rating
FROM property p
LEFT JOIN review r ON p.property_id = r.property_id
WHERE p.location = 'Hawaii' AND p.pricepernight BETWEEN 100 AND 300
GROUP BY p.property_id
HAVING AVG(r.rating) > 4.0
ORDER BY avg_rating DESC;

-- Example 3: Date range bookings
EXPLAIN ANALYZE
SELECT * FROM booking
WHERE start_date >= '2024-01-01' 
AND end_date <= '2024-12-31'
AND status = 'confirmed'
ORDER BY created_at DESC;
```
>### After Adding Indexes
 - Execute the CREATE INDEX commands from [database_index.sql](https://github.com/Fmukanda/-alx-airbnb-database/blob/0a269de4152830a70f86dd936e1ef853d2e1e829/database-adv-script/database_index.sql)
 - Run the same EXPLAIN ANALYZE queries again
 - Compare the execution plans and timing
   
## 4. Expected Performance Improvements
 - **Query 1**: 70-90% faster due to idx_user_role and idx_booking_user_id
 - **Query 2**: 60-80% faster due to idx_property_location_price and idx_review_property_id
 - **Query 3**: 80-95% faster due to idx_booking_dates and idx_booking_status
