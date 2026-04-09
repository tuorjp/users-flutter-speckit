# RH Colaboradores

## Iniciar banco de dados

```SQL
-- Criar tabela de usuários
CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  status TEXT NOT NULL
);

-- Inserir dados iniciais
INSERT INTO users (name, email, password, status) 
VALUES ('Admin User', 'admin@admin.com', '12345', 'Ativo');
INSERT INTO users (name, email, password, status) 
VALUES ('João Silva', 'joao@example.com', '123', 'Ativo');
INSERT INTO users (name, email, password, status) 
VALUES ('Maria Souza', 'maria@example.com', '123', 'Inativo');
```
