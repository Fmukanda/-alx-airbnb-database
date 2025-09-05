# Database Indexing and Performance Strategy
This document explains the indexing decisions for the **User**, **Booking**, and **Property** tables based on their query usage.
## 1. High-Usage Columns Identification
### User Table
 - **user_id:** primary key, used in JOINs and WHERE clauses
 - **email:** unique constraint, used in WHERE clauses for authentication
 - **role:** used in WHERE clauses for filtering by user type
 - **created_at:** Used in ORDER BY for chronological sorting

### Booking Table
 - **booking_id:** primary key, used in JOINs and WHERE clauses
 - **user_id:** foreign key, used in JOINs with user table
 - **property_id:** foreign key, used in JOINs with property table
 - **status:** used in WHERE clauses for filtering booking status
 - **start_date:** used in WHERE clauses for date range queries
 - **end_date:** used in WHERE clauses for filtering booking status
 - **created_at:** used in ORDER BY for chronological sorting

### Property Table
 - **property_id:** primary key, used in JOINs and WHERE clauses
 - **host_id:** foreign key, used in JOINs with user table
 - **location:** used in WHERE clauses for location-based filtering
 - **pricepernight :** used in WHERE clauses for price filtering and ORDER BY
 - **created_at:** used in ORDER BY for chronological sorting
   
## 2. Creating Database Indexes
See the [database_index.sql]() file for the specific CREATE INDEX commands.
