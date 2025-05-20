
-- ---------------------------
-- 2. SAMPLE DATA INSERTS
-- ---------------------------

-- Users
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES
('u1-guest-001', 'Alice', 'Wong', 'alice@example.com', 'hashed_pwd1', '1234567890', 'guest', NOW()),
('u2-host-001', 'Bob', 'Smith', 'bob@example.com', 'hashed_pwd2', '2345678901', 'host', NOW()),
('u3-admin-001', 'Clara', 'Jones', 'clara@example.com', 'hashed_pwd3', '3456789012', 'admin', NOW());

-- Properties
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES
('p1-ny-001', 'u2-host-001', 'Cozy Loft NYC', 'A cozy loft in downtown NYC', 'New York, USA', 120.00, NOW(), NOW()),
('p2-la-002', 'u2-host-001', 'LA Beach House', 'Beautiful beachside house', 'Los Angeles, USA', 200.00, NOW(), NOW());

-- Bookings
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES
('b1-001', 'p1-ny-001', 'u1-guest-001', '2025-06-01', '2025-06-05', 480.00, 'confirmed', NOW()),
('b2-002', 'p2-la-002', 'u1-guest-001', '2025-07-10', '2025-07-12', 400.00, 'pending', NOW());

-- Payments
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES
('pay1-001', 'b1-001', 480.00, NOW(), 'credit_card'),
('pay2-002', 'b2-002', 400.00, NOW(), 'paypal');

-- Reviews
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES
('r1-001', 'p1-ny-001', 'u1-guest-001', 5, 'Great stay, very clean and central!', NOW()),
('r2-002', 'p2-la-002', 'u1-guest-001', 4, 'Nice place, but a bit noisy.', NOW());

-- Messages
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES
('m1-001', 'u1-guest-001', 'u2-host-001', 'Hi Bob, is the loft available on June 1st?', NOW()),
('m2-002', 'u2-host-001', 'u1-guest-001', 'Yes Alice, it is available. Would you like to book?', NOW());
