# Quickstart: User Login Screen (SQLite)

**Feature**: `001-sqlite-user-login`  
**Purpose**: Guide to testing the local login implementation.

## Prerequisites
- Flutter SDK installed and configured.
- SQLite support on the target platform (default on iOS/Android).

## Setup & Run
1. Open the project root in your terminal.
2. Run `flutter pub get` to install dependencies (provider, sqflite, path).
3. Run the app on your preferred emulator or connected device:
   ```bash
   flutter run
   ```

## Testing Success Scenario
1. Navigate to the login screen.
2. Enter the following mock credentials:
   - **Email**: `admin@admin.com`
   - **Password**: `12345`
3. Click "Login".
4. **Expected Result**: A green `SnackBar` or success message appears stating **"Login successful"**.

## Testing Failure Scenario
1. Enter invalid credentials (e.g., `wrong@mail.com` and `password`).
2. Click "Login".
3. **Expected Result**: A red `SnackBar` or error message appears stating **"Invalid email or password"**.

## Testing Validation
1. Clear the email or password field.
2. Click "Login".
3. **Expected Result**: An inline validation error appears (e.g., **"Email is required"**).
