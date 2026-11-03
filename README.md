# BubbleMatch: локальный запуск

Требования: Docker Desktop с Docker Compose; четыре репозитория должны лежать рядом
(`bmatch-deployment`, `bmatch-gameserver`, `bmatch-gateway`, `bmatch-frontend`).

Из `bmatch-deployment`:

```sh
cp .env.example .env
docker compose up --build
```

`.env.example` содержит только локальные dev-значения. Не используйте их на публичном сервере.
Порты опубликованы только на loopback-интерфейсе хоста.

- Frontend: http://localhost:5173
- API: http://localhost:8002
- RabbitMQ UI: http://localhost:15672 (учётные данные из `.env`)
- Consul UI: http://localhost:8500
- Lobby / game sockets: http://localhost:8004 / http://localhost:8005

Проверка состояния: `docker compose ps`. Остановка: `docker compose down`.

Схема БД: `compose/postgres/init-db.sql` (копия для gateway: `../bmatch-gateway/sql.sql`).
Init-скрипты выполняются только на пустом томе. После изменения схемы пересоздайте
локальные данные: `docker compose down -v`, затем `docker compose up --build`.
**Команда с `-v` удаляет локальные данные PostgreSQL.**

Smoke-тест (Node 18, из `bmatch-gameserver`, при запущенном стеке):

```sh
npm install
node scripts/smoke.js
```

Тест создаёт случайных dev-пользователей, собирает лобби с ботами и выполняет ход.
Каждый шаг ограничен 15 секундами; ошибка возвращает код 1.
