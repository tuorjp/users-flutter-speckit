# Quickstart: Users App (Gerenciar Colaboradores)

## Overview

O projeto `users` é um aplicativo mobile focado em gestão interna. Esta sub-feature implementa a tela segura e responsiva onde o administrador, após efetuar login, consegue listar, inserir formatações a serem providas, editar e excluir (com modal de dupla confirmação) colaboradores persistidos num banco interno de dados local (SQLite). 

## Setup and Running

**1. Instalar as dependências:**
Certifique-se de que tenha o Flutter correspondente (>= 3.11.0). Na raiz do repositório, rode:
```bash
flutter pub get
```

**2. Rodar o App (Modo Desenvolvedor):**
Por padrão, com um emulador Android / iOS aberto ou com suporte ao Chrome (Device Web):
```bash
flutter run
```

**3. Testando o ciclo de Login (Feature 01 + Feature 02):**
- Na tela de login, insira o usuário padrão garantido pelas rotinas prévias (geralmente `admin@admin.com` - consultar regras de ciclo 01).
- Ao realizar o click, a tela irá processar e se deslocar para `Cadastro de colaboradores`.
- Nela, a listagem mockada do seu banco local virá e deve suportar scrolling "livre".

**4. Rodando os Testes Automatizados:**
A arquitetura de TDD prevê arquivos dentro de `/test/unit` e `/test/widget`. Para constatar uma suíte de aprovação verdinha (Green tests):
```bash
flutter test
```

## Troubleshooting
- **Database Exceptions**: É preciso garantir que o sqflite ffi wrapper ou mock apropriado esteja importado se for rodar testes contínuos sem UI mobile explícita. O app inclui `sqflite_common_ffi` em dev_dependencies para test-runs de build sem emulador mobile. No main do código dos testes, garanta iniciar o ffi hook (`sqfliteFfiInit(); databaseFactory = databaseFactoryFfi;`).
