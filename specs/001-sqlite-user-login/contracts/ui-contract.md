# UI Contract: User Login Screen (SQLite)

**Feature**: `001-sqlite-user-login`  
**Purpose**: Define the interaction signals and UI state transitions for the login flow.

## Inputs (Interactive Elements)

| Element | ID | Type | Validation (Field-Level) | Description |
|---------|----|------|-------------------------|-------------|
| `EmailField` | `login_email` | `TextFormField` | `Required`, `Regex Match` | Input for the user's email identifier. |
| `PasswordField` | `login_password` | `TextFormField` | `Required` | Input for the user's password (hidden by default). |
| `VisibilityToggle` | `password_toggle` | `IconButton` | N/A | Icon to toggle password visibility. |
| `LoginButton` | `btn_login` | `ElevatedButton` | N/A | Triggers the login verification process. |

## Outputs (Feedback Signals)

| Signal | Type | Trigger | Message / Visual |
|--------|------|---------|------------------|
| `SuccessFeedback` | `SnackBar` | Successful credential match in SQLite. | "Login successful" (Green background) |
| `ErrorFeedback` | `SnackBar` | Failed credential match. | "Invalid email or password" (Red background) |
| `ValidationError` | `Inline Text` | Blank or malformed field on submission. | "Email is required" / "Password is required" |

## UI States

### 1. Initial State
- Email and Password fields are empty.
- Login button is enabled (or disabled until fields are non-empty).

### 2. Submitting State (Intermediate)
- Login button shows a `CircularProgressIndicator` (if needed for minimalist feel, otherwise brief lock).
- User input is temporarily locked.

### 3. Success State
- `SuccessFeedback` is displayed.
- System transitions to the next phase (post-login navigation - out of scope for now).

### 4. Failure State
- `ErrorFeedback` is displayed.
- Fields remain clickable for correction.
