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