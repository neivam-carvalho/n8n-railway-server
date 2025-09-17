# 🔑 CONFIGURAÇÃO DE VARIÁVEIS DE AMBIENTE - RAILWAY

## ⚡ VARIÁVEIS GERADAS (Pronto para usar)

### 🔐 Chaves de Segurança (COPIE EXATAMENTE):
```
N8N_ENCRYPTION_KEY=db8dded3a3835143946e5b5f4f64cfb5
N8N_USER_MANAGEMENT_JWT_SECRET=91f978e34ea08134415cbe9c8577c147ab8c7518239357416b71b2b30354a36f
```

### 🔑 Autenticação Básica (Opcional):
```
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=0cb3dcf6e898db834b289cb3
```

## 📋 COMO CONFIGURAR NA RAILWAY:

### 1. Acesse seu projeto na Railway
- Vá para [railway.app](https://railway.app)
- Entre no seu projeto n8n

### 2. Configure as variáveis
- Clique na aba **"Variables"**
- Adicione uma por vez:

```bash
# BÁSICAS (Sempre necessárias)
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_PROTOCOL=https
NODE_ENV=production

# SEGURANÇA (Use as geradas acima)
N8N_ENCRYPTION_KEY=db8dded3a3835143946e5b5f4f64cfb5
N8N_USER_MANAGEMENT_JWT_SECRET=91f978e34ea08134415cbe9c8577c147ab8c7518239357416b71b2b30354a36f
N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# DATABASE (Copie do seu PostgreSQL Railway)
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=postgres.railway.internal
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=railway
DB_POSTGRESDB_USER=postgres
DB_POSTGRESDB_PASSWORD=RBDzmHdcOHPDupEcSOmaTqQZUnVhMKXW
DB_POSTGRESDB_SCHEMA=public
DB_POSTGRESDB_SSL_ENABLED=true
DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

# OPCIONAIS (Configurar depois)
GENERIC_TIMEZONE=America/Sao_Paulo
N8N_LOG_LEVEL=info
EXECUTIONS_DATA_PRUNE=true
EXECUTIONS_DATA_MAX_AGE=336
```

### 3. URLs (Configure após deploy bem-sucedido)
Depois que o deploy funcionar, adicione:
```bash
N8N_EDITOR_BASE_URL=https://[sua-url-railway].up.railway.app
WEBHOOK_URL=https://[sua-url-railway].up.railway.app
```

## ⚠️ IMPORTANTE:

1. **NUNCA COMPARTILHE** essas chaves publicamente
2. **GUARDE EM LOCAL SEGURO** (ex: gerenciador de senhas)
3. **As chaves são únicas** - geradas especificamente para você
4. **Configure TODAS as variáveis** antes de testar

## 🚀 ORDEM DE CONFIGURAÇÃO:

1. ✅ Adicione as variáveis básicas + segurança
2. ✅ Configure database PostgreSQL
3. ✅ Faça deploy
4. ✅ Configure URLs após obter link final
5. ✅ Teste acesso ao n8n

---
**Data de geração:** 17/09/2025
**Chaves geradas com:** Node.js crypto.randomBytes()