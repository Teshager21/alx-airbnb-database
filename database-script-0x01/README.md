# 🏡 Relational Database Schema for Property Booking System

This repository contains the SQL schema for a property rental and booking system. The database is fully normalized and supports core features such as user accounts, property listings, bookings, payments, reviews, and messaging between users.

---

## 📦 Entities and Attributes

### 👤 User
Stores registered user information.

| Attribute       | Type        | Constraints                             |
|----------------|-------------|------------------------------------------|
| `user_id`       | UUID        | Primary Key, Indexed                     |
| `first_name`    | VARCHAR     | NOT NULL                                 |
| `last_name`     | VARCHAR     | NOT NULL                                 |
| `email`         | VARCHAR     | UNIQUE, NOT NULL                         |
| `password_hash` | VARCHAR     | NOT NULL                                 |
| `phone_number`  | VARCHAR     | NULL                                     |
| `role`          | ENUM        | NOT NULL (`guest`, `host`, `admin`)      |
| `created_at`    | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                |

---

### 🏠 Property
Represents a rental listing posted by a host.

| Attribute       | Type        | Constraints                              |
|----------------|-------------|-------------------------------------------|
| `property_id`   | UUID        | Primary Key, Indexed                      |
| `host_id`       | UUID        | Foreign Key → User(`user_id`)             |
| `name`          | VARCHAR     | NOT NULL                                  |
| `description`   | TEXT        | NOT NULL                                  |
| `location`      | VARCHAR     | NOT NULL                                  |
| `pricepernight` | DECIMAL     | NOT NULL                                  |
| `created_at`    | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                 |
| `updated_at`    | TIMESTAMP   | ON UPDATE CURRENT_TIMESTAMP               |

---

### 📆 Booking
Captures a user’s booking for a specific property.

| Attribute       | Type        | Constraints                              |
|----------------|-------------|-------------------------------------------|
| `booking_id`    | UUID        | Primary Key, Indexed                      |
| `property_id`   | UUID        | Foreign Key → Property(`property_id`)     |
| `user_id`       | UUID        | Foreign Key → User(`user_id`)             |
| `start_date`    | DATE        | NOT NULL                                  |
| `end_date`      | DATE        | NOT NULL                                  |
| `total_price`   | DECIMAL     | NOT NULL                                  |
| `status`        | ENUM        | NOT NULL (`pending`, `confirmed`, `canceled`) |
| `created_at`    | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                 |

---

### 💳 Payment
Records transactions made for bookings.

| Attribute        | Type        | Constraints                              |
|------------------|-------------|-------------------------------------------|
| `payment_id`     | UUID        | Primary Key, Indexed                      |
| `booking_id`     | UUID        | Foreign Key → Booking(`booking_id`)       |
| `amount`         | DECIMAL     | NOT NULL                                  |
| `payment_date`   | TIMESTAMP   | DEFAULT CURRENT_TIMESTAMP                 |
| `payment_method` | ENUM        | NOT NULL (`credit_card`, `paypal`, `stripe`) |

---

### ⭐ Review
Allows users to leave feedback on properties.

| Attribute     | Type      | Constraints                                        |
|---------------|-----------|----------------------------------------------------|
| `review_id`   | UUID      | Primary Key, Indexed                               |
| `property_id` | UUID      | Foreign Key → Property(`property_id`)              |
| `user_id`     | UUID      | Foreign Key → User(`user_id`)                      |
| `rating`      | INTEGER   | NOT NULL, CHECK rating BETWEEN 1 AND 5             |
| `comment`     | TEXT      | NOT NULL                                           |
| `created_at`  | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                          |

---

### 💬 Message
Enables communication between users.

| Attribute       | Type      | Constraints                              |
|-----------------|-----------|-------------------------------------------|
| `message_id`     | UUID      | Primary Key, Indexed                      |
| `sender_id`      | UUID      | Foreign Key → User(`user_id`)             |
| `recipient_id`   | UUID      | Foreign Key → User(`user_id`)             |
| `message_body`   | TEXT      | NOT NULL                                  |
| `sent_at`        | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP                 |

---

## 🔐 Constraints Summary

- **User Table**
  - Unique constraint on `email`
  - NOT NULL for required fields

- **Property Table**
  - Foreign key on `host_id` referencing `User(user_id)`

- **Booking Table**
  - Foreign keys on `property_id`, `user_id`
  - `status` must be one of `pending`, `confirmed`, `canceled`

- **Payment Table**
  - Foreign key on `booking_id`

- **Review Table**
  - Rating must be 1 to 5
  - Foreign keys on `property_id`, `user_id`

- **Message Table**
  - Foreign keys on `sender_id`, `recipient_id`

---

## ⚡ Indexing Strategy

- **Primary Keys** are automatically indexed.
- **Additional Indexes:**
  - `email` in `User`
  - `property_id` in `Property` and `Booking`
  - `booking_id` in `Booking` and `Payment`

---

## 🧠 Normalization

All entities follow **Third Normal Form (3NF)**:
- ✅ Atomic attributes (1NF)
- ✅ Full functional dependency on the primary key (2NF)
- ✅ No transitive dependencies between non-key attributes (3NF)

---

## 🧪 Usage

To create the database schema:

```bash
psql -U your_user -d your_database -f create_schema.sql
