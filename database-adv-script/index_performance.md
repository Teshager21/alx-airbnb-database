# 📊 MySQL : Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE


## 📄 1. `EXPLAIN SELECT * FROM users WHERE username = 'some_username';`

| id | select_type | table | type  | possible_keys | key            | key_len | ref   | rows | Extra        |
|----|-------------|-------|-------|----------------|----------------|---------|-------|------|--------------|
| 1  | SIMPLE      | users | const | username_index | username_index | 102     | const | 1    | Using index  |

---

## 📄 2. `EXPLAIN SELECT * FROM bookings WHERE user_id = 123 AND booking_date BETWEEN '2024-01-01' AND '2024-01-31';`

| id | select_type | table    | type  | possible_keys       | key       | key_len | ref   | rows | Extra        |
|----|-------------|----------|-------|----------------------|-----------|---------|-------|------|---------------|
| 1  | SIMPLE      | bookings | range | user_id, date_idx    | date_idx  | 8       | NULL  | 15   | Using where   |

---

## 📄 3. `EXPLAIN SELECT p.property_name FROM properties p JOIN bookings b ON p.property_id = b.property_id WHERE b.user_id = 456;`

| id | select_type | table | type   | possible_keys        | key      | key_len | ref              | rows | Extra        |
|----|-------------|-------|--------|------------------------|----------|---------|------------------|------|--------------|
| 1  | SIMPLE      | b     | ref    | user_id, property_id   | user_id  | 4       | const            | 20   | Using where  |
| 1  | SIMPLE      | p     | eq_ref | PRIMARY                | PRIMARY  | 4       | b.property_id    | 1    |              |

---

