-- Purpose: Retrieve the total number of bookings made by each user using COUNT and GROUP BY
-- Description: This query finds the total number of bookings made by each user. 
-- It uses a JOIN to link users with their bookings and then uses the COUNT function along with a GROUP BY clause to count the bookings for each distinct user.
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM "user" u
LEFT JOIN booking b
    ON u.user_id = b.user_id
GROUP BY u.user_id
ORDER BY total_bookings DESC;


-- Purpose: Rank properties based on total number of bookings using window functions
-- Description: This query ranks properties based on the total number of bookings they have received. 
-- It uses a Common Table Expression (CTE) to first count the bookings per property, and then applies a window function to rank the properties based on that count.
WITH property_booking_counts AS (
    SELECT 
        p.property_id,
        p.name AS property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM property p
    LEFT JOIN booking b
        ON p.property_id = b.property_id
    GROUP BY p.property_id, p.name
)
SELECT 
    property_id,
    property_name,
    total_bookings,
    RANK() OVER (ORDER BY total_bookings DESC) AS booking_rank,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_row_number
FROM property_booking_counts
ORDER BY booking_rank, property_name;

