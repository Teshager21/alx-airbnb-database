## 📊 Database Normalization – `users` Table

This section explains how the designed database satisfies the conditions of the first three normal forms (1NF, 2NF, and 3NF), ensuring data integrity, minimal redundancy, and optimized structure.

---

### 🔹 First Normal Form (1NF)

✅ **Atomicity**: Each field contains indivisible values (e.g., `first_name`, `role`, `email`).

✅ **No repeating groups**: Every column holds a single value per row.

> ✔️ The database meets **1NF** requirements.

---

### 🔹 Second Normal Form (2NF)

✅ **Primary Key**: The table has a single-column primary key: `user_id` (UUID).

✅ **Full functional dependency**: All non-key attributes (`email`, `first_name`, `role`, etc.) depend entirely on the primary key.

> ✔️ The database design meets **2NF** because no partial dependencies exist.

---

### 🔹 Third Normal Form (3NF)

✅ **No transitive dependencies**: No non-key column depends on another non-key column.  
All fields depend directly and only on the primary key (`user_id`).

> ✔️ The database design meets **3NF**. It's properly normalized, avoids redundancy, and ensures consistency.

---

### ✅ Conclusion

The `airbnb database` is well-structured and normalized to **Third Normal Form (3NF)**:

- 📦 **Efficient storage**
- 🚀 **Minimal update anomalies**
- 🛡️ **High data integrity**

This makes it a solid foundation for relational database design.

---
