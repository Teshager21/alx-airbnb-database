--1. Find the total number of bookings made by each user using COUNT and GROUP BY.
SELECT
    u.user_id,
    u.username,
    COUNT(b.booking_id) AS total_bookings
FROM
    users u
LEFT JOIN
    bookings b ON u.user_id = b.user_id
GROUP BY
    u.user_id,
    u.username
ORDER BY
    total_bookings DESC;

--2. Rank properties based on the total number of bookings they have received using window functions (ROW_NUMBER and RANK).

WITH PropertyBookingCounts AS (
    SELECT
        p.property_id,
        p.property_name,
        COUNT(b.booking_id) AS total_bookings
    FROM
        properties p
    LEFT JOIN
        bookings b ON p.property_id = b.property_id
    GROUP BY
        p.property_id,
        p.property_name
)
SELECT
    property_id,
    property_name,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS booking_rank_row_number
FROM
    PropertyBookingCounts
ORDER BY
    booking_rank_row_number;