-- Purpose: Fetch all bookings with user information
-- Description: This query retrieves all booking records and joins them with user information.
-- It provides a complete view of which user made each booking, including their personal details.
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

