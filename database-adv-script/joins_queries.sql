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

--3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

-- Users with or without bookings
SELECT 
    users.user_id,
    users.name,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    users
LEFT JOIN 
    bookings ON users.user_id = bookings.user_id

UNION

-- Bookings without matching users
SELECT 
    users.user_id,
    users.name,
    bookings.booking_id,
    bookings.property_id,
    bookings.booking_date
FROM 
    bookings
LEFT JOIN 
    users ON bookings.user_id = users.user_id
WHERE 
    users.user_id IS NULL;

