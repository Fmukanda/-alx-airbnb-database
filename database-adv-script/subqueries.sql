-- Purpose: To find properties with high ratings
-- Description: This query finds all properties that have an average review rating of greater than 4.0.
-- It accomplishes this by using a subquery to first identify the property IDs that meet the criteria.
SELECT
    *
FROM
    property
WHERE
    property_id IN (
        SELECT
            property_id,
            AVG(rating)
        FROM
            review
        GROUP BY
            property_id
        HAVING
            AVG(rating) > 4.0
    );


-- Purpose: To find users with multiple bookings
-- Description: This query uses a correlated subquery to find all users who have made more than 3 bookings.
SELECT
    u.user_id,
    u.first_name,
    u.last_name
FROM
    "user" AS u
WHERE
    (SELECT
        COUNT(b.booking_id)
    FROM
        booking AS b
    WHERE
        b.user_id = u.user_id
    ) > 3;
