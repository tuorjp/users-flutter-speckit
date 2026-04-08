# Tasks: Gerenciar Colaboradores e Melhorias no Login

**Input**: Design documents from `/specs/002-gerenciar-colaboradores/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md

**Tests**: Test-Driven Development (TDD) is NON-NEGOTIABLE per the project's constitution. All logic updates must include failing tests first, then implementation.

**Organization**: Tasks are grouped by user story to enable independent implementation and testing of each story.

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic structure validation

- [x] T001 Ensure `provider` and `sqflite` dependencies are fully resolving in `pubspec.yaml`
- [x] T002 [P] Create initial directory structures for new UI components and providers in `lib/`

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [x] T003 Create `UserModel` entity based on `data-model.md` in `lib/models/user_model.dart`
- [x] T004 Update `DatabaseService` to include the `users` table schema and SQL helper methods in `lib/services/database_service.dart`

**Checkpoint**: Foundation ready - user story implementation can now begin.

---

## Phase 3: User Story 1 - Listagem de Colaboradores (Priority: P1) 🎯 MVP

**Goal**: Permitir que o usuário veja a listagem de todos os colaboradores cadastrados após o login.

**Independent Test**: Usuário submete o login e ajeita-se a ver uma tabela rolável contendo o mock de colaboradores vindos do SQLite.

### Tests for User Story 1 ⚠️

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [x] T005 [P] [US1] Unit test for `UsersProvider` fetching users in `test/unit/users_provider_test.dart`
- [x] T006 [P] [US1] Widget test for `UsersListScreen` verifying initial list rendering in `test/widget/users_list_screen_test.dart`

### Implementation for User Story 1

- [x] T007 [US1] Implement `UsersProvider` state logic for reading users in `lib/providers/users_provider.dart`
- [x] T008 [US1] Create UI Widget `UserListItem` in `lib/ui/widgets/user_list_item.dart`
- [x] T009 [US1] Implement `UsersListScreen` com `ListView.builder` em `lib/ui/screens/users_list_screen.dart`
- [x] T010 [US1] Adaptar a rota de sucesso do login para redirecionar à `UsersListScreen`

**Checkpoint**: At this point, User Story 1 should be fully functional and testable independently.

---

## Phase 4: User Story 2 - Ações Sobre Colaboradores (Priority: P1)

**Goal**: Fornecer os botões rápidos (Novo usuário, Editar, Excluir) dentro da gestão da equipe.

**Independent Test**: Verificar as opções contextuais em cada linha e o botão primário e como interagem.

### Tests for User Story 2 ⚠️

- [x] T011 [P] [US2] Unit test for `UsersProvider` (Create, Update, Delete methods) in `test/unit/users_provider_test.dart`
- [x] T012 [P] [US2] Widget test for CRUD interface interactions in `test/widget/users_list_screen_test.dart`

### Implementation for User Story 2

- [x] T013 [P] [US2] Implement C-U-D methods against `DatabaseService` within `UsersProvider` in `lib/providers/users_provider.dart`
- [x] T014 [US2] Update `UsersListScreen` to include "Novo usuário" button.
- [x] T015 [US2] Update `UserListItem` to feature icon buttons or contextual actions for "Editar" and "Excluir".

**Checkpoint**: At this point, User Stories 1 AND 2 should both work independently.

---

## Phase 5: User Story 3 - Confirmação de Exclusão (Priority: P2)

**Goal**: Prevenir remoção acidental requisitando modal de duplo fator.

**Independent Test**: Disparar tentar exclusão de item e ver modal antes de deletar de fato.

### Tests for User Story 3 ⚠️

- [x] T016 [P] [US3] Widget test para o compotamento de modal iterativo em `test/widget/confirm_delete_modal_test.dart`

### Implementation for User Story 3

- [x] T017 [P] [US3] Create `ConfirmDeleteModal` dialog widget in `lib/ui/widgets/confirm_delete_modal.dart`
- [x] T018 [US3] Wrap the delete action inside `UserListItem` with the modal confirmation call (`lib/ui/widgets/user_list_item.dart`)

**Checkpoint**: A deleção agora deve ser segura e auditável com UX fluida.

---

## Phase 6: User Story 4 - Reformulação Visual do Login e Localização (Priority: P3)

**Goal**: Título "RH", textos PT-BR inteiramente e alertas visuais integrados via Snackbar nativo.

**Independent Test**: Visitar tela de login desconectado, errar o login para ver a snackbar e analisar títulos.

### Tests for User Story 4 ⚠️

- [x] T019 [P] [US4] Widget test para nova formatação de tela de login (Título RH) e emissões de falha no `test/widget/login_screen_test.dart`

### Implementation for User Story 4

- [x] T020 [P] [US4] Update `LoginScreen` strings to "RH" no design e textos de interface pt-BR em `lib/ui/screens/login_screen.dart`
- [x] T021 [US4] Add global/scaffold `showSnackBar` handler em `lib/ui/screens/login_screen.dart` to showcase failure messages gracefully formatadas em Português-BR.
- [x] T022 [US4] Add `showSnackBar` handlers aos fluxos falhos do `UsersListScreen` e provider em `lib/ui/screens/users_list_screen.dart`.

**Checkpoint**: All user stories should now be independently functional.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories

- [x] T023 [P] Documentação do repositório/README updates
- [x] T024 Verificação de Layout (responsividade mobile x tablet) para as Lists Views.
- [x] T025 Run quickstart.md validation

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3+)**: All depend on Foundational phase completion
  - User Story 1 deve vir primeiro por engatilhar a base em tela que as outras consumirão.
- **Polish (Final Phase)**: Depends on all desired user stories being complete

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2)
- **User Story 2 (P1)**: Depende do molde do US1 pronto pois precisará do `UserListItem` e `UsersListScreen` preexistentes.
- **User Story 3 (P2)**: Depende da estrutura de botão criado no US2.
- **User Story 4 (P3)**: Independente da base de dados, pode ser feita em paralelo por tocar no frontend primordial, embora a captura de erros unificada feche as features anteriores.

### Within Each User Story

- Tests MUST be written and FAIL before implementation (TDD).
- Models before services.
- Services before endpoints (Widgets).
- Core implementation before integration.

### Parallel Opportunities

- Unidades de teste podem ser criadas em paralelo com Widget tests (ex: T005 com T006).
- Os fluxos para `LoginScreen` (US4) podem ocorrer paralelamente a construção de `UserListItem` do P1 assim que US1 estabeler os nomes das classes de rotas.

---

## Parallel Example: User Story 4

```bash
# Launch login screen testing logic while also writing the initial string layouts:
Task: T019 [P] [US4] Widget test para nova formatação de tela de login
Task: T020 [P] [US4] Update LoginScreen strings to "RH" no design e textos
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1 & 2 (Crucial Models and Schemas).
2. Complete Phase 3: Listagem de Usuários (Read Operation without modify).
3. **STOP and VALIDATE**: Check navigation from Login to List.

### Incremental Delivery

1. Foundation ready
2. Add US1 → App loga e lista a tabela
3. Add US2 → App ganha botões mockados/funcionais de gestão
4. Add US3 → Dialog para segurança de exclusão blindando a US2.
5. Add US4 → Visual UX / Error feedback polish.
6. Phase 7 → Finalize checks.
