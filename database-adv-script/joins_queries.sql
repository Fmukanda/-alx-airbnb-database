-- Purpose: Fetch all bookings with user information
-- Description: This query retrieves all booking records and joins them with user information.
SELECT
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.total_price,
    b.status,
    b.created_at,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM
    booking AS b
INNER JOIN
    "user" AS u ON b.user_id = u.user_id;


-- Purpose: Retrieve all properties and their reviews, including properties with no reviews
-- Description: This query retrieves all property records and joins them with their reviews.
SELECT
    p.property_id,
    p.name AS property_name,
    p.pricepernight,
    p.location,
    r.review_id,
    r.user_id AS reviewer_id,
    r.rating,
    r.comment
FROM
    property AS p
LEFT JOIN
    review AS r ON p.property_id = r.property_id;


-- Purpose: Retrieve all users and all bookings, including users without bookings and bookings without users
-- Description: This query uses a FULL OUTER JOIN to retrieve all records from both the "user" and "booking" tables.
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date
FROM
    "user" AS u
FULL OUTER JOIN
    booking AS b ON u.user_id = b.user_id;

