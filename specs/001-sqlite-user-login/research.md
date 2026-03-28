# Research: User Login Screen (SQLite)

**Feature**: `001-sqlite-user-login`  
**Goal**: Design a clean, persistent login flow using Flutter.

## SQLite Integration (`sqflite`)

### Decision: Singleton Database Helper
- **Rationale**: Ensure a single connection to the local database file is maintained throughout the app lifecycle.
- **Pattern**: `DatabaseHelper` class with a private constructor and a `static final` static instance.
- **Initialization**: Database will be initialized on first access, including `CREATE TABLE users` and seeding the `admin@admin.com` account.

### Decision: Plain Text Persistence (Limited Scope)
- **Rationale**: User explicitly requested plain text comparison for the mock (`admin@admin.com` / `12345`).
- **Security Warning**: For production, this MUST be updated to BCrypt/Argon2. The architecture will separate the hashing logic to make this future upgrade trivial.

---

## State Management (`provider`)

### Decision: `AuthService` with `ChangeNotifier`
- **Rationale**: Decouple the UI (Login Screen) from the authentication logic and database access.
- **Flow**:
  1. `LoginScreen` uses `Provider.of<AuthService>(context, listen: false).login(email, password)`.
  2. `AuthService` handles database query.
  3. `AuthService` updates internal `isLoggedIn` state and calls `notifyListeners()`.
  4. UI reacts to state changes (success/error messages).

---

## Minimalist UI Design

### Decision: Single Column Layout
- **Rationale**: Focus onto the core task (login).
- **Styling**: Large margins, clean `TextFormField` with subtle labels, and a primary action button at the bottom.
- **Feedback**: Use `ScaffoldMessenger.of(context).showSnackBar()` for transient secondary messages (success/error).

## Alternatives Considered

| Alternative | Rejected Because |
|-------------|------------------|
| Hive (NoSQL) | User specifically requested SQLite for this feature. |
| BLoC | Too much boilerplate for this "simple/minimalist" requirement. |
| Firebase Auth | User requested local SQLite persistence. |
