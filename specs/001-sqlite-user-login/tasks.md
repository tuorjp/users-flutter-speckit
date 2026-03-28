# Tasks: User Login Screen (SQLite)

**Feature**: `001-sqlite-user-login`  
**Plan**: [plan.md](file:///C:/prog-mobile/users/specs/001-sqlite-user-login/plan.md)  
**Spec**: [spec.md](file:///C:/prog-mobile/users/specs/001-sqlite-user-login/spec.md)

## Summary

Build a minimalist Flutter login interface that validates user credentials against a local SQLite database seeded with a mock account (`admin@admin.com` / `12345`).

## Dependencies

- **TDD Requirement**: Logic must be tested via `flutter_test` before implementation.
- **Story Completion Order**: `Phase 1 (Setup)` → `Phase 2 (Foundational)` → `Phase 3 (User Story 1)` → `Phase 4 (User Stories 2 & 3)` → `Phase 5 (Polish)`.

---

## Phase 1: Setup

Goal: Initialize the technical foundation.

- [ ] T001 Add `sqflite`, `path`, and `provider` dependencies to `pubspec.yaml`
- [ ] T002 [P] Sync dependencies using `flutter pub get`
- [ ] T003 Verify `lib/` and `test/` directory structures exist per `plan.md`

---

## Phase 2: Foundational

Goal: Build the common persistent and data layers.

- [ ] T101 [P] Create `User` model with `email` and `password` in `lib/models/user.dart`
- [ ] T102 Create singleton `DatabaseService` in `lib/services/database_service.dart` (Include schema creation and `admin@admin.com` seed logic)
- [ ] T103 [P] Verify seeds exist by inspecting the SQLite database through a script or unit test.

---

## Phase 3: User Story 1 - Successful Login

Goal: Implement the primary login flow (P1).

- [ ] T201 [P] [US1] Create unit tests for `AuthService.login` (Success path) in `test/unit/auth_service_test.dart` (RED)
- [ ] T202 [US1] Implement `AuthService` with SQLite lookup logic in `lib/services/auth_service.dart` (GREEN)
- [ ] T203 [P] [US1] Create widget test for `LoginScreen` (Verify success snackbar) in `test/widget/login_screen_test.dart` (RED)
- [ ] T204 [US1] Build minimalist `LoginScreen` structure in `lib/ui/screens/login_screen.dart`
- [ ] T205 [US1] Implement `LoginForm` with Email/Password fields and Login button in `lib/ui/widgets/login_form.dart`
- [ ] T206 [US1] Verify login with `admin@admin.com` / `12345` displays "Login successful" snackbar.

---

## Phase 4: User Stories 2 & 3 - Failure & Validation

Goal: Handle errors and invalid inputs.

- [ ] T301 [P] [US2] Update `auth_service_test.dart` to include "Invalid credentials" scenario.
- [ ] T302 [US2] Handle failed SQLite queries in `AuthService.login` and notify listeners.
- [ ] T303 [US2] Display "Invalid email or password" error snackbar in `LoginScreen`.
- [ ] T304 [P] [US3] Add `TextFormField` validation logic for empty fields and email regex in `lib/ui/widgets/login_form.dart`.
- [ ] T305 [US3] Verify inline validation errors appear (e.g., "Email is required").

---

## Phase 5: Polish & Cross-Cutting Concerns

Goal: Refine the user experience.

- [ ] T401 [P] Implement password visibility toggle in `lib/ui/widgets/login_form.dart`.
- [ ] T402 [P] Audit contrast ratios for error messages to ensure accessibility (4.5:1).
- [ ] T403 Final verification of all user scenarios via `quickstart.md`.

---

## Parallel Execution

- T003, T101, T201, T203 are good candidates for initial setup or parallel implementation where they don't depend on common logic.
- T301 and T304 can be implemented concurrently by independent agents focused on logic vs UI.

## Implementation Strategy: MVP First

- **MVP Phase**: Complete T001-T206. Focus purely on successful credentials matching and message display.
- **Incremental Layering**: Layer in Story 2 (errors) then Story 3 (validation) for robustness.
