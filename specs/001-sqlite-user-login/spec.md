# Feature Specification: User Login Screen (SQLite)

**Feature Branch**: `001-sqlite-user-login`  
**Created**: 2026-03-27  
**Status**: Draft  
**Input**: User description: "Crie uma tela de login simples e minimalista. O login deve validar o email 'admin@admin.com' e senha '12345' contra um registro em um banco de dados SQLite local. Exibir mensagens de sucesso e erro. Sem opção de 'Lembrar de mim'."

## Clarifications

### Session 2026-03-27
- Q: Password visibility toggle included? → A: Yes (Option A)
- Q: Password stored securely? → A: Plain text (Option B)
- Q: Login throttling enabled? → A: No (Option B)
- Q: Email case-sensitive? → A: Yes (Option B)

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Successful Login (Priority: P1)

As a registered user, I want to log in using my existing credentials so that I can access restricted areas of the application.

**Why this priority**: Core functionality needed for user identification and access control.

**Independent Test**: Can be tested by entering valid credentials (`admin@admin.com` / `12345`) and verifying that a success message is displayed.

**Acceptance Scenarios**:

1. **Given** the login screen is open, **When** I enter "admin@admin.com" and "12345" and click "Login", **Then** the system verifies the credentials against the SQLite database and displays a "Login successful" message.

---

### User Story 2 - Failed Login (Invalid Credentials) (Priority: P1)

As a user, I want to be notified if I enter incorrect credentials so that I can correct them and try again.

**Why this priority**: Essential for security and guiding the user to the correct input.

**Independent Test**: Can be tested by entering "wrong@email.com" or a wrong password and verifying that an error message is displayed.

**Acceptance Scenarios**:

1. **Given** the login screen is open, **When** I enter invalid credentials and click "Login", **Then** the system displays a clear error message: "Invalid email or password".

---

### User Story 3 - Input Validation (Priority: P2)

As a user, I want the system to prevent me from submitting empty fields so that I don't waste time on incomplete attempts.

**Why this priority**: Improves user experience by providing immediate feedback.

**Independent Test**: Can be tested by leaving fields blank and clicking "Login".

**Acceptance Scenarios**:

1. **Given** the email field is empty, **When** I click "Login", **Then** an error message "Email is required" appears near the email field.
2. **Given** the password field is empty, **When** I click "Login", **Then** an error message "Password is required" appears near the password field.

---

### Edge Cases

- **Database Unavailable**: If the SQLite database cannot be initialized or accessed, the system should display a technician-friendly but user-non-alarming message like "System error: could not connect to local storage."
- **Malformed Email**: If the user enters a string that is not a valid email format (e.g., "admin@admin"), the system should provide a validation error before attempting database lookup.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST provide a minimalist interface with fields for Email and Password (including a visibility toggle for the password field).
- **FR-002**: System MUST validate inputs for emptiness and email format before submission.
- **FR-003**: System MUST query a local SQLite database for a matching user record (email + plain text password).
- **FR-004**: System MUST display a success feedback (e.g., green snackbar or modal) upon successful verification.
- **FR-005**: System MUST display an error feedback (e.g., red message below fields) upon failed verification.
- **FR-006**: System MUST NOT include a "Remember Me" checkbox.

### Key Entities *(include if feature involves data)*

- **User**: Represents the account credentials.
  - Attributes: `email` (unique), `password`.
- **LoginSession**: Represents the temporary state of a successful login (to be expanded in future specs).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Users can complete a login attempt (submit to feedback) in under 1 second (excluding physical input time).
- **SC-002**: Visual feedback for errors must achieve a color contrast ratio of at least 4.5:1 for accessibility.
- **SC-003**: 100% of failed login attempts due to invalid credentials must display the specific "Invalid email or password" message.

## Assumptions

- The project is implemented using **Flutter**.
- Email addresses are considered **case-sensitive** for login purposes (e.g., "admin@admin.com" and "Admin@admin.com" are different).
- A local SQLite database will be initialized and seeded with the mock user `admin@admin.com` / `12345` during the setup phase.
- The UI follows a "minimalist" aesthetic (clean, reduced elements, focus on inputs).
- Post-login navigation to other screens is out of scope for this individual feature specification.
