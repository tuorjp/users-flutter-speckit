# Quickstart: Collaborator Form

## Overview
This feature provides a form for creating and editing collaborators, integrated with local SQLite persistence and a premium visual design.

## Development Environment
- **Framework**: Flutter ^3.11.0
- **State Management**: Provider
- **Storage**: SQLite (sqflite)

## Running the Feature
1. Ensure the app is running on an emulator or physical device.
2. Navigate to the Collaborator List (Home).
3. Click the "Add" button to open the form in **Creation Mode**.
4. Click on an existing collaborator in the list to open the form in **Edition Mode**.

## Testing
### Automated Tests
- Run unit tests for `UsersProvider`:
  ```bash
  flutter test test/unit/users_provider_test.dart
  ```
- Run widget tests for `CollaboratorFormScreen`:
  ```bash
  flutter test test/widget/collaborator_form_screen_test.dart
  ```

### Manual Verification
1. Open the form.
2. Verify that the "RH" header is large and positioned correctly above the form.
3. Try to save with empty fields; verify error messages.
4. Fill Name, Email, Password, and Status.
5. Click Save; verify message "Sucesso" and return to list.
6. Edit a collaborator; verify data is pre-filled.
7. Change data and save; verify update.
8. Try to exit with modified data; verify confirmation dialog.
