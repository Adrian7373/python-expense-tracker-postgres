# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a simple terminal-based expense tracker built with Python and PostgreSQL. The application allows users to manage personal expenses through a menu-driven interface, handling users, categories, and expense records with proper database relationships.

## Architecture & Code Structure

### Single-Module Design
The entire application is contained in `main.py` - a monolithic design with:
- Global database connection and cursor objects (`con`, `cur`)
- Menu-driven interface with function-based operations
- Direct SQL queries using psycopg2 for database operations

### Database Schema (PostgreSQL)
Three main tables with referential integrity:
- `users`: Stores user names and emails (id, name, email)
- `categories`: Expense categories (id, name) 
- `expenses`: Transaction records linking users and categories with amounts, descriptions, and timestamps

### Key Design Patterns
- **Name-based lookups**: Users enter names rather than IDs for better UX
- **Automatic timestamp**: Uses `CURRENT_TIMESTAMP` for transaction dates
- **Input validation**: Numeric validation for amounts, email format checking
- **Error handling**: Try-catch blocks with database rollbacks on failures

## Common Development Commands

### Setup and Running
```bash
# Install the required dependency
pip install psycopg2

# Set up the PostgreSQL database
psql -U postgres -c "CREATE DATABASE practice;"

# Initialize database schema and sample data
psql -U postgres -d practice -f schema.sql

# Run the application
python main.py
```

### Database Operations
```bash
# Connect to the database directly
psql -U postgres -d practice

# Reset database schema (drops and recreates tables)
psql -U postgres -d practice -f schema.sql

# View current expense data
psql -U postgres -d practice -c "SELECT u.name, c.name, e.amount, e.description, e.trans_date FROM expenses e JOIN users u ON e.user_id = u.id JOIN categories c ON e.category_id = c.id ORDER BY e.trans_date DESC;"
```

## Critical Implementation Details

### Database Connection
The application hardcodes database credentials in `main.py` lines 131-136:
- Host: localhost
- Database: practice
- User: postgres
- Password: "Koyuki73" (hardcoded - security concern)

### Error Handling Pattern
All database operations follow this pattern:
```python
try:
    cur.execute("SQL_QUERY", params)
    con.commit()
    print("Success message")
except Exception as e:
    con.rollback()
    print("Error message: ", e)
```

### User Input Processing
- Names are stripped and title-cased for consistency
- Numeric inputs have validation loops for amounts
- Email validation checks for "@" and "." presence (basic validation)

## Development Considerations

### Security Issues
- Database credentials are hardcoded and exposed in version control
- Basic email validation that's easily bypassed
- No SQL injection protection beyond parameterized queries

### Code Structure Improvements Needed
- No separation of concerns (database, UI, business logic all mixed)
- Global variables for database connection
- No configuration management
- No logging system
- No unit tests or test framework

### Potential Extensions
- Environment variables for database configuration
- Input validation improvements (proper email regex, amount ranges)
- User authentication/sessions
- Expense filtering and reporting features
- Database migration system
- RESTful API layer

## Database Schema Notes

The `trans_date` column in expenses uses `DATE` type but the application inserts `CURRENT_TIMESTAMP` (which includes time), so there might be precision loss. The schema file shows `DEFAULT CURRENT_DATE` but the application uses `CURRENT_TIMESTAMP` in INSERT statements.

Foreign key constraints use `ON DELETE CASCADE`, meaning deleting a user will automatically delete all their expenses.