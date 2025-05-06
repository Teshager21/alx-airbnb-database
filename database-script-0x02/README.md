# 🌱 Database Seeding – Property Booking System

This script seeds the database with realistic data for development and testing purposes. It populates core entities such as `users`, `properties`, `bookings`, `payments`, `reviews`, and `messages`.

---

## 📄 Script Name

`seed_data_postgres.sql`

---

## 🚀 What It Does

The seed script:

- Inserts **4 users** (2 guests, 1 host, 1 admin)
- Adds **2 properties** listed by the host
- Creates **2 bookings**, one confirmed and one pending
- Adds a **payment** linked to a confirmed booking
- Inserts **2 reviews** from users who stayed at the properties
- Sends **2 direct messages** between a guest and a host

The data uses **real-world-like values** and simulates typical interactions in a property booking system.

---

## 🧪 Dependencies

- PostgreSQL 12+
- `uuid-ossp` extension (enabled in the script)

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

## ⚙️ How to Use
Make sure the schema has already been created using your DDL script.

Run the seed script with:

```
psql -U your_user -d your_database -f seed_data_postgres.sql
```
Replace your_user and your_database with your actual PostgreSQL credentials.

## 📋 Example Data Preview

👤 Users

- Alice Johnson (guest)

- Bob Smith (host)

- Carol Brown (guest)

- David Wilson (admin)

## 🏠 Properties

- Cozy Cottage in Lakeview, OR

- Urban Apartment in San Francisco, CA

## 📆 Bookings

- Confirmed booking for Alice

- Pending booking for Carol

## 💳 Payments

- Credit card payment by Alice for a confirmed booking

## ⭐ Reviews

- 5-star and 4-star reviews with real comments

## 💬 Messages

- Alice inquiring about availability

- Bob replying with confirmation

## 🧼 Notes

- UUIDs are generated dynamically using uuid_generate_v4().

- Foreign key references are resolved using SELECT subqueries.

- The script is idempotent-safe if the database is cleared before reseeding.

## 📂 File Structure

├── create_schema.sql   
├── seed_data_postgres.sql   
└── README.md   
       

## 🗨️ Feedback & Contributions

If you have suggestions for improving the realism or coverage of the seed data, feel free to open an issue or submit a pull request!
