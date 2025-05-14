--1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings.
SELECT
    b.booking_id,
    b.booking_date,
    u.user_id,
    u.username,
    u.email
FROM
    bookings b
INNER JOIN
    users u ON b.user_id = u.user_id;