# OpenClaw + Ollama (Gemma4:e4b) Local Stack

A simple, local-first Docker Compose setup that starts:

- **Ollama** (LLM runtime)
- **Gemma4:e4b** (auto-pulled on startup)
- **OpenClaw UI** (preconfigured to use Ollama)

## 1) Install Docker

Install Docker Desktop (Windows/macOS) or Docker Engine + Compose plugin (Linux):

- https://docs.docker.com/get-docker/

Then verify:

```bash
docker --version
docker compose version
```

## 2) Start everything

From this project folder:

```bash
docker compose up -d
```

That's it. The stack will:

1. Start Ollama on port `11434`
2. Pull `gemma4:e4b` automatically (if not already downloaded)
3. Start OpenClaw after Ollama is healthy

## 3) Open OpenClaw UI

Open your browser:

- http://localhost:3000

(If you changed `OPENCLAW_PORT`, use that port instead.)

## 4) Verify services and model

Check container status:

```bash
docker compose ps
```

Check Ollama API tags:

```bash
curl http://localhost:11434/api/tags
```

You should see `gemma4:e4b` listed once model pull finishes.

## 5) Restart stack

```bash
docker compose restart
```

## 6) Stop stack

```bash
docker compose down
```

Your Ollama models are preserved in the `ollama_data` volume.

## Optional: customize settings

1. Copy env template:

```bash
cp .env.example .env
```

2. Edit values in `.env` if needed:

- `OPENCLAW_IMAGE`
- `OPENCLAW_PORT`
- `OLLAMA_MODEL`

## Notes on stability

- `restart: unless-stopped` is enabled for both services.
- Ollama model storage uses a persistent Docker volume.
- Internal service communication uses Docker DNS (`http://ollama:11434`) — no in-container localhost assumptions.
