-- database_index.sql

-- Index for users table
CREATE INDEX idx_user_id ON users (user_id);
CREATE INDEX idx_username ON users (username);
CREATE INDEX idx_email ON users (email);

-- Index for bookings table
CREATE INDEX idx_booking_id ON bookings (booking_id);
CREATE INDEX idx_user_id_bookings ON bookings (user_id);
CREATE INDEX idx_property_id_bookings ON bookings (property_id);
CREATE INDEX idx_booking_date ON bookings (booking_date);

-- Index for properties table
CREATE INDEX idx_property_id ON properties (property_id);
CREATE INDEX idx_property_name ON properties (property_name);
CREATE INDEX idx_location ON properties (location);

-- Consider composite indexes for columns often used together in WHERE clauses
-- Example: Finding bookings within a specific date range for a specific property
CREATE INDEX idx_property_date_bookings ON bookings (property_id, booking_date);