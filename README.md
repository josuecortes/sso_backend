# SSO Backend - Secretaria de Estado

Sistema de Autenticação e Autorização (SSO) desenvolvido para a Secretaria de Estado, fornecendo um serviço centralizado de gerenciamento de usuários e permissões.

## 🚀 Tecnologias Principais

- **Ruby on Rails 8.0.2** - Framework web robusto e produtivo
- **PostgreSQL** - Banco de dados relacional
- **Devise + JWT** - Autenticação e autorização
- **Pundit** - Controle de permissões
- **Docker** - Containerização da aplicação
- **Kamal** - Deploy automatizado

## 🔐 Funcionalidades Principais

- **Autenticação JWT** - Login seguro com tokens JWT
- **Gerenciamento de Usuários** - CRUD completo de usuários
- **Sistema de Roles** - Controle granular de permissões
  - Roles protegidas (master, administrador, normal)
  - Associação dinâmica de roles
  - Controle de status ativo/inativo
- **API RESTful** - Interface JSON para integração com outros sistemas
- **Segurança** - Proteção contra deleção de roles essenciais

## 🛠️ Configuração do Ambiente

### Pré-requisitos

- Ruby 3.3.0
- PostgreSQL
- Docker (opcional)
- Kamal (para deploy)

### Instalação

1. Clone o repositório:
   ```bash
   git clone [URL_DO_REPOSITÓRIO]
   cd sso_backend
   ```

2. Instale as dependências:
   ```bash
   bundle install
   ```

3. Configure o banco de dados:
   ```bash
   rails db:create db:migrate
   ```

4. Inicie o servidor:
   ```bash
   rails server
   ```

### Docker

Para rodar com Docker:

```bash
docker build -t sso-backend .
docker run -p 3000:3000 sso-backend
```

## 📚 Documentação da API

### Autenticação

- **POST /api/v1/login** - Login de usuário
- **DELETE /api/v1/logout** - Logout
- **POST /api/v1/signup** - Registro de novo usuário

### Perfil

- **GET /api/v1/auth/profile** - Obter perfil do usuário autenticado

### Roles

- **GET /api/v1/roles** - Listar roles
- **POST /api/v1/roles** - Criar role
- **PUT /api/v1/roles/:id** - Atualizar role
- **DELETE /api/v1/roles/:id** - Deletar role (com restrições)

## 🔒 Segurança

- Tokens JWT com expiração
- Proteção contra deleção de roles essenciais
- Validação de CPF único
- Controle de acesso baseado em roles
- Sanitização de parâmetros

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto é privado e destinado ao uso exclusivo da Secretaria de Estado.

## 👥 Autores

- [Seu Nome] - Desenvolvedor Principal

## 📞 Suporte

Para suporte, entre em contato com a equipe de desenvolvimento.
