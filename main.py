import psycopg2

def viewRecord():
    cur.execute("""
        SELECT u.name, c.name, e.amount, e.description, e.trans_date
        FROM expenses e
        JOIN users u ON e.user_id = u.id
        JOIN categories c ON e.category_id = c.id
        ORDER BY e.trans_date DESC
    """)
    rows = cur.fetchall()
    print("\n-----Expense Records------")
    for row in rows:
        print(f"User: {row[0]} | Category:{row[1]} | Amount: {row[2]} | Description:{row[3]} | Timestamp:{row[4]}")

def addRecord():
    newRecordName = input("Enter your name: ").strip().title()
    cur.execute("SELECT id FROM users WHERE name=%s", (newRecordName,))
    row = cur.fetchone()
    if not row:
        print("User not found")
        return
    while True:
        newRecordCat = input("Enter category name: ").strip().title()
        cur.execute("SELECT id from categories WHERE name=%s", (newRecordCat,))
        cat_row = cur.fetchone()
        if not cat_row:
            print("Category not found!")
        else:
            while True:
                try:
                    newRecordAmount = float(input("Enter amount: "))
                    break
                except ValueError:
                    print("Invalid Input! Please input a numeric value.")
            newRecordCat = cat_row[0]
            newRecordDesc = input("Enter description: ")
            try:
                cur.execute("INSERT INTO expenses(user_id,category_id,amount,description,trans_date) VALUES (%s,%s,%s,%s,CURRENT_TIMESTAMP)", (row[0],cat_row[0],newRecordAmount,newRecordDesc,))
                con.commit()
                print("Record successfully added!")
                break
            except Exception as e:
                con.rollback()
                print("Error adding record: ",e)



def addCat():
    newCategoryName = input("Enter new category: ").strip().title()
    if newCategoryName:
        running = True
        while running:
            cur.execute("SELECT * FROM categories WHERE name=%s", (newCategoryName,))
            rows = cur.fetchone()
            if rows:
                print("Category already exists!")
                breaker = input("Exit?(y/n)")
                if breaker.lower() == "y":
                    running = False
            else: 
                try:
                    cur.execute("INSERT INTO categories(name) VALUES (%s)", (newCategoryName,))
                    print("Category successfully added!")
                    con.commit()
                except Exception as e:
                    con.rollback()
                    print("Error adding category: ",e)
                break
    else:
        print("Cannot add empty value!")


def deleteUser():
    while True:
        deleteUserName = input("Enter user name to delete: ").strip().title()
        cur.execute("SELECT * FROM users WHERE name=%s", (deleteUserName,))
        rows = cur.fetchone()
        if rows:
            try:
                cur.execute("DELETE FROM users WHERE name=%s", (deleteUserName,))
                con.commit()
                print("User deleted successfully!")
            except Exception as e:
                con.rollback()
                print("Error deleting user: ",e)
            break
        else:
            print("User not found!")
            breaker = input("Exit?(y/n)")
            if breaker.lower() == "y":
                break 

def addUser():
    while True:
        newUserName = input("Enter user name: ").strip().title()
        if newUserName:
            newUserEmail = input("Enter valid email: ")
            if "@" in newUserEmail and "." in newUserEmail:
                try:
                    cur.execute("INSERT INTO users(name,email) VALUES (%s,%s)", (newUserName,newUserEmail,))
                    con.commit()
                    print("User added successfully!")
                except Exception as e:
                    print("Error adding user: ",e)
                break
            else:
                print("Invalid email!")
                breaker = input("Exit?(y/n)")
                if breaker.lower() == "y":
                    break 
        else:
            print("Cannot add empty value")

def mainMenu():
    while True:
        print("------------Expenses Tracker---------------")
        print("1. Add user")
        print("2. Delete user")
        print("3. Add expense category")
        print("4. Add expense record")
        print("5. View records")
        print("6. Exit")
        choice = input("Input choice: ")
        if choice in ("1","2","3","4","5"):
            return choice
        else:
            print("Invalid input!")
        

con = psycopg2.connect(
    host = "localhost",
    database = "practice",
    user = "postgres",
    password = "Koyuki73"
)

cur = con.cursor()
while True:
    choice = mainMenu()

    if choice == "1":
        addUser()
    elif choice == "2":
        deleteUser()
    elif choice == "3":
        addCat()
    elif choice == "4":
        addRecord()
    elif choice == "5":
        viewRecord()
    else:
        cur.close()
        con.close()
        exit()