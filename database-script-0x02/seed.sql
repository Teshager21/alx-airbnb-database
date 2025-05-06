-- Enable UUID extension (PostgreSQL only)
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ====== USERS ======
INSERT INTO users (user_id, first_name, last_name, email, password_hash, phone_number, role)
VALUES
  (uuid_generate_v4(), 'Alice', 'Johnson', 'alice@example.com', 'hashed_password_1', '1234567890', 'guest'),
  (uuid_generate_v4(), 'Bob', 'Smith', 'bob@example.com', 'hashed_password_2', '9876543210', 'host'),
  (uuid_generate_v4(), 'Carol', 'Brown', 'carol@example.com', 'hashed_password_3', NULL, 'guest'),
  (uuid_generate_v4(), 'David', 'Wilson', 'david@example.com', 'hashed_password_4', '4561237890', 'admin');

-- ====== PROPERTIES ======
INSERT INTO property (property_id, host_id, name, description, location, pricepernight)
VALUES
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'Cozy Cottage', 'A small cottage near the lake.', 'Lakeview, OR', 120.00),
  (uuid_generate_v4(), (SELECT user_id FROM users WHERE email = 'bob@example.com'), 'Urban Apartment', 'Modern 2-bedroom apartment downtown.', 'San Francisco, CA', 200.00);

-- ====== BOOKINGS ======
INSERT INTO booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES
  (uuid_generate_v4(),
   (SELECT property_id FROM property WHERE name = 'Cozy Cottage'),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   '2025-06-01', '2025-06-05', 480.00, 'confirmed'),

  (uuid_generate_v4(),
   (SELECT property_id FROM property WHERE name = 'Urban Apartment'),
   (SELECT user_id FROM users WHERE email = 'carol@example.com'),
   '2025-07-10', '2025-07-12', 400.00, 'pending');

-- ====== PAYMENTS ======
INSERT INTO payment (payment_id, booking_id, amount, payment_method)
VALUES
  (uuid_generate_v4(),
   (SELECT booking_id FROM booking WHERE total_price = 480.00 AND status = 'confirmed'),
   480.00, 'credit_card');

-- ====== REVIEWS ======
INSERT INTO review (review_id, property_id, user_id, rating, comment)
VALUES
  (uuid_generate_v4(),
   (SELECT property_id FROM property WHERE name = 'Cozy Cottage'),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   5, 'Amazing place! Super clean and cozy.'),

  (uuid_generate_v4(),
   (SELECT property_id FROM property WHERE name = 'Urban Apartment'),
   (SELECT user_id FROM users WHERE email = 'carol@example.com'),
   4, 'Great location, but a bit noisy at night.');

-- ====== MESSAGES ======
INSERT INTO message (message_id, sender_id, recipient_id, message_body)
VALUES
  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   (SELECT user_id FROM users WHERE email = 'bob@example.com'),
   'Hi Bob, is the cottage available in August?'),

  (uuid_generate_v4(),
   (SELECT user_id FROM users WHERE email = 'bob@example.com'),
   (SELECT user_id FROM users WHERE email = 'alice@example.com'),
   'Hi Alice, yes it’s available. I’ve opened the calendar.');
