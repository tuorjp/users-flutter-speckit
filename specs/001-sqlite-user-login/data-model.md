# Data Model: User Login Screen (SQLite)

**Feature**: `001-sqlite-user-login`  
**Purpose**: Define the relational schema for local authentication.

## Entity: User

| Property | Type | Constraints | Description |
|----------|------|-------------|-------------|
| `id` | INTEGER | PRIMARY KEY AUTOINCREMENT | Unique identifier for internal reference. |
| `email` | TEXT | UNIQUE, NOT NULL | User's email, used as login identifier. |
| `password` | TEXT | NOT NULL | Plain text password for the mock version. |

## SQLite Schema

```sql
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL
);
```

## Initial Seed Data

During first database initialization, the following record MUST be inserted if it does not exist:

```sql
INSERT INTO users (email, password) VALUES ('admin@admin.com', '12345');
```

## Validation & Business Rules

1. **Uniqueness**: `email` must be unique in the `users` table.
2. **Format**: Email must match the regex: `^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$` (Simple regex as requested).
3. **Comparison**: Password comparison is exact-match (case-sensitive) for this mock version.
4. **Constraint**: Case-sensitive email comparison (per spec clarification).
