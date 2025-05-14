--1. Non-Correlated Subquery: Find all properties where the average rating is greater than 4.0.
SELECT
    p.property_id,
    p.property_name
FROM
    properties p
WHERE
    p.property_id IN (
        SELECT
            r.property_id
        FROM
            reviews r
        GROUP BY
            r.property_id
        HAVING
            AVG(r.rating) > 4.0
    );

--2. Correlated Subquery: Find users who have made more than 3 bookings.

SELECT
    u.user_id,
    u.username
FROM
    users u
WHERE
    (SELECT COUNT(*) FROM bookings b WHERE b.user_id = u.user_id) > 3;