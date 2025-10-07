# 💰 Python Expense Tracker (PostgreSQL)

A simple **Expense Tracker** built with **Python** and **PostgreSQL**, where users can record expenses, manage categories, and view spending records.

---

## 👤 Author
**Adrian Ablaza**  
🎓 BSIT Major in Database Systems Technology  
🏫 Nueva Ecija University of Science and Technology  
💬 “Code. Learn. Build.”

---

## ✨ Features

✅ Add new users with email validation  
✅ Add or delete users  
✅ Create and manage expense categories  
✅ Record expenses using **user name** and **category name** (no need to know IDs!)  
✅ Automatically stores current timestamp for each transaction  
✅ Proper error handling and rollback for database operations  

---

## ⚙️ Setup Instructions

1. **Clone this repository**
```bash
   git clone https://github.com/Adrian7373/python-expense-tracker-postgres.git
   cd python-expense-tracker-postgres
````

2. **Install dependencies**

   ```bash
   pip install psycopg2
   ```

3. **Create the database**
   Open PostgreSQL and run:

   ```sql
   CREATE DATABASE practice;
   ```

4. **Run the schema file**
   Create a file named `schema.sql` and paste the following:

   ```sql
   CREATE TABLE users (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) NOT NULL,
       email VARCHAR(255) UNIQUE NOT NULL
   );

   CREATE TABLE categories (
       id SERIAL PRIMARY KEY,
       name VARCHAR(100) UNIQUE NOT NULL
   );

   CREATE TABLE expenses (
       id SERIAL PRIMARY KEY,
       user_id INT REFERENCES users(id) ON DELETE CASCADE,
       category_id INT REFERENCES categories(id) ON DELETE CASCADE,
       amount NUMERIC(10,2) NOT NULL,
       description TEXT,
       trans_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

5. **Run the program**

   ```bash
   python main.py
   ```

---

## 🪪 License

This project is licensed under the **MIT License** — free to use, modify, and share.

---

## ⭐ Support

If you found this project helpful, consider **starring ⭐ this repo** to support future improvements!

```
