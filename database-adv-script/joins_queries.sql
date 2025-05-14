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
    p.description, 
    r.review_id, 
    r.rating, 
    r.review_text
FROM 
    properties p
LEFT JOIN 
    reviews r ON p.property_id = r.property_id;

--3. FULL OUTER JOIN: Retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

SELECT
    u.user_id AS user_id,
    u.username,
    b.booking_id,
    b.booking_date
FROM
    users u
LEFT JOIN
    bookings b ON u.user_id = b.user_id
UNION ALL
  
-- Bookings without matching users

SELECT
    u.user_id AS user_id,
    u.username,
    b.booking_id,
    b.booking_date
FROM
    bookings b
RIGHT JOIN
    users u ON b.user_id = u.user_id
WHERE
    b.booking_id IS NULL;