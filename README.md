# BubbleMatch: локальный запуск

Требования: Docker Desktop с Docker Compose; репозитории должны лежать рядом
(`bmatch-deployment`, `bmatch-gameserver`, `bmatch-gateway`, `bmatch-frontend`, а для ручной
аналитики ещё `bmatch-analytics`).

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

Smoke-тест (Node 22+, из `bmatch-gameserver`, при запущенном стеке):

```sh
npm install
node scripts/smoke.js
```

Тест создаёт случайных dev-пользователей, собирает лобби с ботами и выполняет ход.
Каждый шаг ограничен 15 секундами; ошибка возвращает код 1.

Юнит-тесты gameserver: `npm test` (Node 22+, в образах и `.nvmrc` — Node 24). Без локального
Node их можно запустить в образе стека: `docker compose run --rm --no-deps gameserver node --test`.

Аналитика партий (Memory, Accuracy, Speed, Streaks, Consistency и предложение по MMR) — отдельный
сервис `../bmatch-analytics`, запускается вручную и в `up` не стартует:
`docker compose run --rm analytics list`, затем `docker compose run --rm analytics <game_uuid>`
(`--save` сохраняет результат, `--apply` ещё и меняет MMR). Подробности — в его README.

Проверка уязвимостей: `trivy fs --scanners vuln,secret,misconfig ..` из `bmatch-deployment`
и `trivy image` для собранных образов (`docker compose images`).

Брошенная игра (ни одного хода человека за `GAME_IDLE_TIMEOUT_SECONDS`, по умолчанию 300)
завершается на ближайшем тайм-ауте хода.
