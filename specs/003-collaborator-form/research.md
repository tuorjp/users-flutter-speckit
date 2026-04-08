# Research: Collaborator Form implementation

## Technical Decisions

### State Management
- **Decision**: Use `Provider` (specifically `UsersProvider`).
- **Rationale**: The project already uses `Provider` and `UsersProvider` already implements `addUser`, `updateUser`, and `fetchUsers`.
- **Alternatives Considered**: BLoC. Rejected to maintain consistency with existing codebase.

### Data Model
- **Decision**: Use the existing `UserModel`.
- **Rationale**: `UserModel` already contains all fields required by the spec: `name`, `email`, `password`, and `status`.
- **Validation**:
  - Name: Required.
  - Email: Required, Valid Format, Unique (handled by SQLite + check).
  - Password: Required, Masked (obscureText).
  - Status: Required, binary (Ativo/Inativo).

### Persistence
- **Decision**: Use the existing `DatabaseService` with SQLite.
- **Rationale**: Already implemented and supports the required operations.

### UI Architecture
- **Decision**: Create a single `CollaboratorFormScreen` that accepts an optional `UserModel`.
- **Rationale**: Reuses code for both Create and Edit modes as per spec assumptions.
- **Premium Aesthetics**:
  - Use `CustomScrollView` for smooth header integration.
  - Apply gradients to the "RH" header.
  - Use `AnimatedSwitcher` for success/error feedback state transitions.
  - Implement the "Success/Error" feedback using `ScaffoldMessenger.showSnackBar` (as per FR-006).

## Needs Clarification (Resolved)
- **State Management**: Provider is used (confirmed via code scan).
- **Navigation after success**: Return to list (confirmed via spec clarification).
- **Password UI**: Toggle required (confirmed via spec clarification).
- **Status UI**: Switch/Toggle chosen (confirmed via spec clarification).
- **Exit Confirmation**: Required for unsaved changes (confirmed via spec clarification).
