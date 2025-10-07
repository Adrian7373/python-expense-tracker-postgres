---
# 💰 Python Expense Tracker (PostgreSQL)

A simple **Expense Tracker** built with **Python** and **PostgreSQL**, where users can record expenses, manage categories, and maintain personal spending records — all from the terminal.

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
✅ Organized menu-based terminal interface  

---

## 🗂️ Project Structure

```

📦 python-expense-tracker-postgres
┣ 📄 main.py          ← main Python program
┣ 📄 schema.sql       ← database schema and sample data
┣ 📄 .gitignore       ← ignored files list
┗ 📄 README.md        ← documentation

````

---

## ⚙️ Setup Instructions

### 1️⃣ Clone this repository
```bash
git clone https://github.com/Adrian7373/python-expense-tracker-postgres.git
cd python-expense-tracker-postgres
````

### 2️⃣ Install dependencies

Make sure you have **Python 3** and **PostgreSQL** installed, then install the required Python library:

```bash
pip install psycopg2
```

### 3️⃣ Create the database

Open your PostgreSQL terminal or pgAdmin and run:

```sql
CREATE DATABASE practice;
```

### 4️⃣ Set up tables and sample data

Run the schema file:

```bash
\i schema.sql
```

*(You can also copy its contents into pgAdmin and execute manually.)*

### 5️⃣ Run the application

```bash
python main.py
```

---

## 🧠 How It Works

* The program connects to your PostgreSQL database using **psycopg2**.
* Users can add, delete, and view data directly through a terminal interface.
* When adding an expense, the program automatically finds the corresponding **user ID** and **category ID** based on their names — you never need to know them manually.
* Every transaction automatically includes the current date and time.

---

## 🧱 Database Schema Overview

| Table        | Description                                                    |
| ------------ | -------------------------------------------------------------- |
| `users`      | Stores user names and emails.                                  |
| `categories` | Stores expense category names.                                 |
| `expenses`   | Links users and categories with amount, description, and date. |

---

## 🪪 License

This project is licensed under the **MIT License** — free to use, modify, and share.

---

## ⭐ Support

If you found this project helpful, please consider **starring ⭐ the repository** — it helps others discover it and motivates future improvements!
---

🧩 *Made with Python, PostgreSQL, and passion for learning.*
