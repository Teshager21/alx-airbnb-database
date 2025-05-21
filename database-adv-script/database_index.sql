-- performance before indexing
EXPLAIN
SELECT u.first_name, u.last_name, COUNT(b.booking_id)
FROM User u
JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id;


-- User Table
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_id ON User(user_id);

-- Booking Table
CREATE INDEX idx_booking_user_id ON Booking(user_id);
CREATE INDEX idx_booking_property_id ON Booking(property_id);
CREATE INDEX idx_booking_start_date ON Booking(start_date);

-- Property Table
CREATE INDEX idx_property_name ON Property(name);
CREATE INDEX idx_property_location ON Property(location);
CREATE INDEX idx_property_id ON Property(property_id);


-- Performance after indexing
EXPLAIN
SELECT u.first_name, u.last_name, COUNT(b.booking_id)
FROM User u
JOIN Booking b ON u.user_id = b.user_id
GROUP BY u.user_id;
