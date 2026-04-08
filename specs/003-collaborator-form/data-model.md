# Data Model: Collaborator

## Entity: User (Colaborador)

| Field | Type | Validation | Notes |
| :--- | :--- | :--- | :--- |
| `id` | `int?` | N/A | Primary Key (autoincrement) |
| `name` | `String` | Not Empty | Required |
| `email` | `String` | Valid Email, Unique | Required. Checked against SQLite UNIQUE constraint. |
| `password` | `String` | Not Empty | Required. Masked in UI with toggle. |
| `status` | `String` | "Ativo" or "Inativo" | Required. Default is "Ativo". |

## State Transitions

- **Creation**: `id` is null -> Insert -> `id` assigned.
- **Edition**: `id` is present -> Update existing record.
- **Status Toggle**: Handled via Switch component in the form.

## Persistence Schema (Existing)

```sql
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  status TEXT NOT NULL
)
```
