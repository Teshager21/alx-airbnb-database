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

--2. LEFT JOIN: Retrieve all properties and their reviews, including properties that have no reviews.

SELECT
    p.property_id,
    p.property_name,
    r.review_id,
    r.review_text,
    r.rating
FROM
    properties p
LEFT JOIN
    reviews r ON p.property_id = r.property_id;