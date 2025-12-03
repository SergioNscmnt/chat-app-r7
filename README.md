# Chat App (Rails 7 + Hotwire)

Aplicação de chat em tempo real construída com Ruby on Rails 7, Hotwire (Turbo/Stimulus), Devise para autenticação e Tailwind CSS para o layout.

## Principais recursos
- Criação e edição de salas, associação de usuários às salas.
- Mensagens em tempo real com Turbo Streams (criar, editar, remover).
- Sidebar dinâmica com salas e detalhes atualizados via broadcast.

## Stack
- Ruby 3.0.4, Rails 7, Hotwire/Turbo, Devise, Tailwind CSS, SQLite.
- Docker pronto: `docker compose up --build web css` sobe a app em `http://localhost:3000`, prepara o banco e gera os assets do Tailwind.

## Desenvolvimento local (Docker)
```bash
docker compose up --build web css
```

## Próximos passos
- Ajustar credenciais/variáveis de ambiente conforme necessário.
- Se preferir outra branch padrão, renomeie: `git branch -M main`.
