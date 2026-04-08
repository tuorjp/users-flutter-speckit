# Data Model: Gerenciar Colaboradores

## Entity: `User` (Colaborador)

Esta entidade reflete as informações armazenadas no backend/Database (SQLite).
Com base nas especificações (Nome, Email, Status) e no contexto comum de aplicações (id), temos:

### Fields

| Name | Type | Description |
|-----------|---------|--------------------------------|
| `id` | int? | Primary Key automincrement. SQLite id. |
| `name` | String | Nome completo do colaborador. MUST be non-empty. |
| `email` | String | Email de contato/login. MUST follow valid email format. |
| `status` | String | Estado do colaborador na empresa (ex: 'Ativo', 'Inativo', 'Férias'). Default = 'Ativo'. |
| `password`| String | (Implicit from cycle 1) Hash ou dado de validação exigido para o login admin. |

### Relationships
Não há relacionamentos explícitos especificados (1 para 1). A entidade é auto-contida.

### Validation Rules

- `name`: Não pode ser uma string vazia.
- `email`: Tem que obedecer a RegEx padrão de e-mails para não quebrar a lógica de login/cadastro.
- `status`: Valida-se preferencialmente partindo de um `Enum` interno, mapeado para String na persistência (para resiliência contra 'typos' e erros estruturais do SQLite).

### State Transitions

- O `User` transita do estado não autenticado (visitante) para autenticado via formulário de Login. A tabela exibida no sistema consome os User Models cadastrados, com seu respectivo `status`. O modelo não contém lógicas supercomplexas de states fora de sua carga CRUD.
