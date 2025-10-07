# 🧮 Python Expense Tracker (PostgreSQL)

A simple command-line **Expense Tracker** built using **Python** and **PostgreSQL**, designed to help users manage expenses efficiently with categorized spending records.

---

## 🚀 Features

- Add, view, and delete users
- Add and manage expense categories
- Add new expense records linked to users and categories
- Data stored securely in PostgreSQL
- Input validation and error handling
- Transaction rollback on failed inserts

---

## 🗂 Database Schema

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
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    amount NUMERIC(10,2) NOT NULL,
    description TEXT,
    trans_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);



⚙️ Setup Instructions

Install PostgreSQL and create a new database:

CREATE DATABASE practice;


Run the schema file (schema.sql) to create tables.

Install dependencies:

pip install psycopg2


Update your connection details in the script:

con = psycopg2.connect(
    host="localhost",
    database="practice",
    user="postgres",
    password="yourpassword"
)


Run the script:
python main.py


📸 Sample Menu
------------Expenses Tracker---------------
1. Add user
2. Delete user
3. Add expense category
4. Add expense record
5. Exit


🧑‍💻 Author

Adrian Ablaza
🎓 BSIT Major in Database Systems Technology
📍 Nueva Ecija University of Science and Technology
💬 “Code. Learn. Build.”

📜 License

This project is licensed under the MIT License — free to use, modify, and share.

🌟 Star this repo

If you found this project helpful, consider starring ⭐ it to support future improvements!


---

## 🧱 **schema.sql**
Create another file named `schema.sql` and paste:

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
    category_id INT REFERENCES categories(id) ON DELETE SET NULL,
    amount NUMERIC(10,2) NOT NULL,
    description TEXT,
    trans_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
