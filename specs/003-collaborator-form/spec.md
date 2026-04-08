# Feature Specification: Formulário de Colaborador (Criação/Edição)

**Feature Branch**: `003-collaborator-form`  
**Created**: 2026-04-08  
**Status**: Draft  
**Input**: User description: "Agora vamos trabalhar na tela de criação/edição de colaborador. Os campos obrigatórios são: nome, email, senha e status. O status pode ser um checkbox ou um botão (sim/não), pode usar um enum com ativo e inativo. As validações devem ser feitas antes de salvar o formulário e deve haver mensagens de erro/sucesso ao criar ou editar colaborador. Arrume o título RH, deixe a fonte maior e 'cole' ele em cima do formulário."

## Clarifications

### Session 2026-04-08

- Q: O que acontece após o salvamento com sucesso? → A: Retornar para a lista de colaboradores.
- Q: Onde os dados devem ser persistidos? → A: Banco de dados SQLite local.
- Q: O campo de senha deve obrigatoriamente ter botão de mostrar/esconder? → A: Sim, incluir ícone para mostrar/ocultar a senha.
- Q: Como o status deve ser exibido visualmente? → A: Switch/Toggle.
- Q: O sistema deve confirmar antes de sair com alterações não salvas? → A: Sim, confirmar se houver alterações não salvas.
- Q: Quais os títulos da tela de formulário? → A: "Novo colaborador" (Criação) e "Editar Colaborador" (Edição).
- Q: O título "RH" pertence a qual tela? → A: Pertence à tela de Login, não ao formulário de colaborador.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Criar Novo Colaborador (Priority: P1)

Como um administrador do sistema RH (usuário logado), quero preencher um formulário com os dados de um novo colaborador (nome, email, senha, status) para registrá-lo no sistema.

**Why this priority**: É a funcionalidade central de entrada de dados para gerenciamento de colaboradores.

**Independent Test**: Pode ser testado instanciando o formulário vazio, preenchendo os dados e verificando se um novo registro foi criado no banco subjacente e se uma mensagem de sucesso apareceu na interface.

**Acceptance Scenarios**:

1. **Given** que o administrador está na tela de criação vazia, **When** o formulário carregar, **Then** o título exibido deve ser "Novo colaborador".
2. **Given** que o administrador preenche dados válidos e clica em salvar, **Then** o sistema exibe uma mensagem de sucesso, persiste o colaborador e retorna para a listagem.
2. **Given** que o administrador deixa um campo obrigatório vazio, **When** ele tenta salvar, **Then** o sistema exibe erros de validação diretamente nos campos não preenchidos do formulário e não salva os dados.

---

### User Story 2 - Editar Colaborador Existente (Priority: P1)

Como um administrador do sistema RH, quero visualizar o formulário já preenchido com os dados de um colaborador existente para poder modificá-los.

**Why this priority**: Modificar detalhes ou desativar colaboradores é crucial no dia a dia da operação e aproveita a estrutura do mesmo formulário.

**Independent Test**: Pode ser testado carregando o formulário com dados existentes, modificando um campo (ex: status ativo para inativo) e validando se a alteração foi salva com sucesso e acompanhada de feedback visual.

**Acceptance Scenarios**:

1. **Given** que a tela é aberta para editar um colaborador existente, **When** o formulário carregar, **Then** o título exibido deve ser "Editar Colaborador" e os dados originais (nome, email, senha, status) devem aparecer preenchidos.
2. **Given** o formulário preenchido, **When** os dados são alterados e salvos, **Then** o sistema confirma o sucesso, atualiza o seu registro e retorna para a listagem.
3. **Given** o formulário no modo edição, **When** o administrador esvazia um campo obrigatório e tenta salvar, **Then** mensagens de erro de validação aparecem e a modificação não ocorre.

### Edge Cases

- O que acontece quando tentamos cadastrar um colaborador com um email que já existe na base de dados? O sistema deve tratar a restrição UNIQUE do banco rejeitando a inserção via validação de email ou feedback claro amigável, não com crash de UI.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: O sistema DEVE exibir o título dinâmico na tela de formulário: "Novo colaborador" no modo inclusão e "Editar Colaborador" no modo edição.
- **FR-008**: [LOGIN] O título "RH" na tela de login deve ser grande, em destaque e posicionado imediatamente acima do formulário de acesso.
- **FR-002**: O sistema DEVE prover campos de interação para os atributos obrigatórios: Nome, Email, Senha e Status.
- **FR-003**: O campo de Senha DEVE mascarar o input para confidencialidade visual e PROVER um ícone/botão de toggle para exibir/ocultar o texto.
- **FR-004**: O campo `Status` DEVE ser exclusivo de duas seleções lógicas: "Ativo" e "Inativo", implementado visualmente via componente Switch/Toggle.
- **FR-005**: O sistema DEVE validar preenchimento obrigatório e formato válido (como de email) e disparar indicações visuais in-line nestes campos ANTES da requisição efetiva de salvar.
- **FR-006**: O sistema DEVE reportar imediatamente através de mensagens visíveis nativas (Snackbar/Toast) se houve SUCESSO ou tratar ERROS no salvamento.
- **FR-007**: O sistema DEVE solicitar confirmação do usuário antes de descartar alterações não salvas ao tentar sair da tela (via botão "Voltar" ou "Cancelar").

### Key Entities

- **Colaborador (User)**: Representa uma pessoa com entidade correspondente no controle de RH, com atributos principais sendo `name`, `email`, `password`, `status` (enumerador ativo/inativo).

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 100% das submissões através da tecla de salvamento com campos em branco ou inválidos não chegam ao repositório de dados.
- **SC-002**: A área em branco vertical de preenchimento (padding/margin) entre o cabeçalho/título "RH" e os inputs diretos não pode ser superior que um distanciamento visual de contato contíguo normal da diretriz de Design.
- **SC-003**: As transações de sucesso criam um tempo de feedback compreendido num aviso em tela reportando o usuário operante sobre o ocorrido sem falsos positivos.

## Assumptions

- Assumimos que a mesma tela é reutilizada tanto para Criação quanto para Edição, reagindo a injeção ou nula de um modelo Colaborador do fluxo pai.
- Supõe-se compatibilidade lógica: Status Ativo/Inativo internamente usa o mesmo campo `status` contido em `UserModel`.
- A persistência deve ser feita no banco de dados SQLite local existente.
