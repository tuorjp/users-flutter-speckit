# Tasks: Formulário de Colaborador (Criação/Edição)

**Input**: Design documents from `/specs/003-collaborator-form/`
**Prerequisites**: plan.md (required), spec.md (required for user stories), research.md, data-model.md, quickstart.md

**Tests**: TDD approach is MANDATORY as per project constitution.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (e.g., US1, US2, US3)
- Include exact file paths in descriptions

## Path Conventions

- **Mobile project**: `lib/`, `test/` at repository root

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure

- [x] T001 Verify project dependencies (sqflite, provider) in `pubspec.yaml`
- [x] T002 Ensure project structure is ready for new screen: `lib/ui/screens/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure and base tests that MUST be complete before ANY user story implementation

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T003 [P] Create unit test scaffold for `UsersProvider` CRUD logic in `test/unit/users_provider_test.dart`
- [x] T004 [P] Create widget test scaffold for `CollaboratorFormScreen` in `test/widget/collaborator_form_screen_test.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Criar Novo Colaborador (Priority: P1) 🎯 MVP

**Goal**: Permitir que administradores criem novos colaboradores com validação e feedback visual.

**Independent Test**: Instanciar `CollaboratorFormScreen` (modo criação), preencher dados válidos e verificar se o título é "Novo colaborador", se o registro surge no SQLite e se a navegação retorna para a lista.

### Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T005 [P] [US1] Create unit tests for `addUser` in `test/unit/users_provider_test.dart`
- [ ] T006 [P] [US1] Create widget tests for "Novo colaborador" title and creation validation in `test/widget/collaborator_form_screen_test.dart`

### Implementation for User Story 1

- [ ] T007 [US1] Scaffold `CollaboratorFormScreen` in `lib/ui/screens/collaborator_form_screen.dart`
- [ ] T008 [P] [US1] Implement dynamic title logic for "Novo colaborador" in `lib/ui/screens/collaborator_form_screen.dart`
- [ ] T009 [US1] Implement form fields (Name, Email, Password with Mask/Toggle, Status with Switch) in `lib/ui/screens/collaborator_form_screen.dart`
- [ ] T010 [US1] Implement field validation (Required fields, Email format) in `lib/ui/screens/collaborator_form_screen.dart`
- [ ] T011 [US1] Integrate with `UsersProvider.addUser` and handle SnackBar success feedback
- [ ] T012 [US1] Implement navigation back to list after success in `lib/ui/screens/collaborator_form_screen.dart`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Editar Colaborador Existente (Priority: P1)

**Goal**: Permitir que administradores editem colaboradores existentes com preenchimento automático.

**Independent Test**: Abrir `CollaboratorFormScreen` passando um `UserModel` existente, verificar se o título é "Editar Colaborador", se os dados estão preenchidos e se a atualização persiste.

### Tests for User Story 2

- [ ] T013 [P] [US2] Create unit tests for `updateUser` in `test/unit/users_provider_test.dart`
- [ ] T014 [P] [US2] Create widget tests for "Editar Colaborador" title and data pre-filling in `test/widget/collaborator_form_screen_test.dart`

### Implementation for User Story 2

- [ ] T015 [US2] Implement dynamic title logic for "Editar Colaborador" in `lib/ui/screens/collaborator_form_screen.dart`
- [ ] T016 [US2] Implement data pre-filling from injected `UserModel` in `lib/ui/screens/collaborator_form_screen.dart`
- [ ] T017 [US2] Integrate with `UsersProvider.updateUser` and handle SnackBar success feedback
- [ ] T018 [US2] Ensure navigation back to list after update success

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently.

---

## Phase 5: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories or refine specific requirements.

- [ ] T019 [P] Update `LoginScreen` styling to include large, highlighted "RH" title above the form in `lib/ui/screens/login_screen.dart` (FR-008)
- [ ] T020 [US1] [US2] Implement confirmation dialog (`WillPopScope` or `PopScope`) for unsaved changes before exiting in `lib/ui/screens/collaborator_form_screen.dart` (FR-007)
- [ ] T021 Run final validation using `quickstart.md` scenarios

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies.
- **Foundational (Phase 2)**: Depends on Setup - BLOCKS all stories.
- **User Stories (Phase 3+)**: All depend on Foundational completion.
- **Polish (Final Phase)**: Depends on both user stories being complete.

### Parallel Opportunities

- ALL Tasks marked **[P]** can run in parallel within their respective phase.
- Once Phase 2 is done, Phase 3 and Phase 4 can start in parallel if needed (shares same file `collaborator_form_screen.dart`, beware of git conflicts).

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1 & 2.
2. Complete Phase 3 (US1).
3. **STOP and VALIDATE** US1 independently.
