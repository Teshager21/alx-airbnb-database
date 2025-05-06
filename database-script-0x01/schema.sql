CREATE TABLE "User" (
  "user_id" UUID UNIQUE PRIMARY KEY,
  "first_name" VARCHAR NOT NULL,
  "last_name" VARCHAR NOT NULL,
  "email" VARCHAR UNIQUE NOT NULL,
  "password_hash" VARCHAR NOT NULL,
  "phone_number" VARCHAR,
  "role" ENUM(guest,host,admin) NOT NULL,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "Property" (
  "property_id" UUID UNIQUE PRIMARY KEY,
  "host_id" UUID,
  "name" VARCHAR NOT NULL,
  "description" TEXT NOT NULL,
  "location" VARCHAR NOT NULL,
  "pricepernight" DECIMAL NOT NULL,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "updated_at" TIMESTAMP
);

CREATE TABLE "Booking" (
  "booking_id" UUID UNIQUE PRIMARY KEY,
  "property_id" UUID,
  "user_id" UUID,
  "start_date" DATE NOT NULL,
  "end_date" DATE NOT NULL,
  "total_price" DECIMAL NOT NULL,
  "status" ENUM(pending,confirmed,canceled) NOT NULL,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "Payment" (
  "payment_id" UUID UNIQUE PRIMARY KEY,
  "booking_id" UUID,
  "amount" DECIMAL NOT NULL,
  "payment_date" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
  "payment_method" ENUM(credit_card,paypal,stripe) NOT NULL
);

CREATE TABLE "Review" (
  "review_id" UUID UNIQUE PRIMARY KEY,
  "property_id" UUID,
  "user_id" UUID,
  "rating" INTEGER NOT NULL,
  "comment" TEXT NOT NULL,
  "created_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

CREATE TABLE "Message" (
  "message_id" UUID UNIQUE PRIMARY KEY,
  "sender_id" UUID,
  "recipient_id" UUID,
  "message_body" TEXT NOT NULL,
  "sent_at" TIMESTAMP DEFAULT (CURRENT_TIMESTAMP)
);

COMMENT ON COLUMN "User"."user_id" IS 'Primary Key';

COMMENT ON COLUMN "User"."email" IS 'Indexed';

COMMENT ON COLUMN "Property"."property_id" IS 'Primary Key';

COMMENT ON COLUMN "Property"."updated_at" IS 'Auto updated on change';

COMMENT ON COLUMN "Booking"."booking_id" IS 'Primary Key';

COMMENT ON COLUMN "Payment"."payment_id" IS 'Primary Key';

COMMENT ON COLUMN "Review"."review_id" IS 'Primary Key';

COMMENT ON COLUMN "Review"."rating" IS 'Must be between 1 and 5 (CHECK constraint)';

COMMENT ON COLUMN "Message"."message_id" IS 'Primary Key';

ALTER TABLE "Property" ADD FOREIGN KEY ("host_id") REFERENCES "User" ("user_id");

ALTER TABLE "Booking" ADD FOREIGN KEY ("property_id") REFERENCES "Property" ("property_id");

ALTER TABLE "Booking" ADD FOREIGN KEY ("user_id") REFERENCES "User" ("user_id");

ALTER TABLE "Payment" ADD FOREIGN KEY ("booking_id") REFERENCES "Booking" ("booking_id");

ALTER TABLE "Review" ADD FOREIGN KEY ("property_id") REFERENCES "Property" ("property_id");

ALTER TABLE "Review" ADD FOREIGN KEY ("user_id") REFERENCES "User" ("user_id");

ALTER TABLE "Message" ADD FOREIGN KEY ("sender_id") REFERENCES "User" ("user_id");

ALTER TABLE "Message" ADD FOREIGN KEY ("recipient_id") REFERENCES "User" ("user_id");
