# Fullstack Blog App — DevOps Series

A simple blogging app (Node.js + React + PostgreSQL) being taken from local setup to a fully automated GitOps deployment with ArgoCD.

## Run Locally

1. Add a `.env` in `backend/`:

```env
DB_USER=appuser
DB_PASSWORD=apppassword
DB_HOST=localhost
DB_PORT=5432
DB_NAME=appdb
```

2. Start the database:

```bash
docker compose up -d
```

3. Start backend and frontend:

```bash
cd backend && npm install && npm run dev
cd frontend && npm install && npm run dev
```