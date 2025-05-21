import mysql.connector
from faker import Faker
import uuid
import random
from datetime import datetime, timedelta
import os

# Configuration
NUM_USERS = 1000
NUM_PROPERTIES = 300
NUM_BOOKINGS = 3000
NUM_PAYMENTS = 3000
NUM_REVIEWS = 2000
NUM_MESSAGES = 5000
BATCH_SIZE = 100

faker = Faker()
Faker.seed(42)
random.seed(42)

password = os.getenv("USER_PASSWORD")  # Read password from env var

if not password:
    raise ValueError("USER_PASSWORD environment variable not set")

print(f"User password: {password}")
# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password=password,
    database="airbnbclone"
)
cursor = conn.cursor()

def insert_many(sql, data):
    for i in range(0, len(data), BATCH_SIZE):
        batch = data[i:i+BATCH_SIZE]
        cursor.executemany(sql, batch)
        conn.commit()

def gen_uuid():
    return str(uuid.uuid4())

# 1. Insert Users
users = []
for _ in range(NUM_USERS):
    users.append((
        gen_uuid(),
        faker.first_name(),
        faker.last_name(),
        faker.unique.email(),
        faker.sha256(),
        faker.phone_number()[:20],
        random.choice(['guest', 'host', 'admin']),
        faker.date_time_between(start_date='-1y', end_date='now')
    ))

user_sql = """
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
"""
insert_many(user_sql, users)

# Extract user IDs by role
cursor.execute("SELECT user_id, role FROM User")
user_rows = cursor.fetchall()
host_ids = [uid for uid, role in user_rows if role == 'host']
guest_ids = [uid for uid, role in user_rows if role == 'guest']

# 2. Insert Properties
properties = []
for _ in range(NUM_PROPERTIES):
    properties.append((
        gen_uuid(),
        random.choice(host_ids),
        faker.catch_phrase(),
        faker.paragraph(nb_sentences=3),
        faker.city(),
        round(random.uniform(50, 500), 2),
        faker.date_time_between(start_date='-1y', end_date='-1d'),
        faker.date_time_between(start_date='-11mo', end_date='now')
    ))

property_sql = """
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
"""
insert_many(property_sql, properties)

# Get property IDs
cursor.execute("SELECT property_id FROM Property")
property_ids = [row[0] for row in cursor.fetchall()]

# 3. Insert Bookings
bookings = []
for _ in range(NUM_BOOKINGS):
    start_date = faker.date_between(start_date='-6mo', end_date='-1d')
    end_date = start_date + timedelta(days=random.randint(1, 14))
    total_price = round((end_date - start_date).days * random.uniform(50, 300), 2)
    bookings.append((
        gen_uuid(),
        random.choice(property_ids),
        random.choice(guest_ids),
        start_date,
        end_date,
        total_price,
        random.choice(['pending', 'confirmed', 'canceled']),
        faker.date_time_between(start_date='-6mo', end_date='now')
    ))

booking_sql = """
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at)
VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
"""
insert_many(booking_sql, bookings)

# Get booking IDs and their amounts
cursor.execute("SELECT booking_id, total_price FROM Booking")
booking_rows = cursor.fetchall()

# 4. Insert Payments
payments = []
for bid, amount in random.sample(booking_rows, NUM_PAYMENTS):
    payments.append((
        gen_uuid(),
        bid,
        amount,
        faker.date_time_between(start_date='-6mo', end_date='now'),
        random.choice(['credit_card', 'paypal', 'stripe'])
    ))

payment_sql = """
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method)
VALUES (%s, %s, %s, %s, %s)
"""
insert_many(payment_sql, payments)

# 5. Insert Reviews
reviews = []
for _ in range(NUM_REVIEWS):
    reviews.append((
        gen_uuid(),
        random.choice(property_ids),
        random.choice(guest_ids),
        random.randint(1, 5),
        faker.sentence(nb_words=12),
        faker.date_time_between(start_date='-6mo', end_date='now')
    ))

review_sql = """
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at)
VALUES (%s, %s, %s, %s, %s, %s)
"""
insert_many(review_sql, reviews)

# 6. Insert Messages
messages = []
for _ in range(NUM_MESSAGES):
    sender, recipient = random.sample(user_rows, 2)
    messages.append((
        gen_uuid(),
        sender[0],
        recipient[0],
        faker.sentence(nb_words=15),
        faker.date_time_between(start_date='-6mo', end_date='now')
    ))

message_sql = """
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at)
VALUES (%s, %s, %s, %s, %s)
"""
insert_many(message_sql, messages)

# Done
print("✅ Data population complete.")
cursor.close()
conn.close()
