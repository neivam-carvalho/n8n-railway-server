# n8n Server na Railway

Este projeto configura um servidor n8n na plataforma Railway para automação de workflows.

## 📋 Pré-requisitos

- Conta na [Railway](https://railway.app)
- Conta no GitHub (para deploy via Git)
- PostgreSQL Database (recomendado Railway PostgreSQL)
- Redis (opcional, para modo queue)

## 🚀 Deploy Rápido

### 1. Deploy via Railway Dashboard

1. Acesse [Railway](https://railway.app) e faça login
2. Clique em "New Project"
3. Selecione "Deploy from GitHub repo"
4. Conecte este repositório
5. Railway detectará automaticamente o Dockerfile e iniciará o build

### 2. Configurar Banco de Dados

**Opção A: PostgreSQL da Railway (Recomendado)**
1. No projeto Railway, clique em "Add Service"
2. Selecione "PostgreSQL"
3. Anote as credenciais geradas

**Opção B: Banco Externo**
- Use qualquer instância PostgreSQL disponível

### 3. Configurar Variáveis de Ambiente

No painel da Railway, vá em "Variables" e configure:

#### ⚙️ Configurações Essenciais
```bash
# Básico
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_PROTOCOL=https
N8N_EDITOR_BASE_URL=https://SEU-PROJETO.up.railway.app

# Segurança (OBRIGATÓRIO)
N8N_ENCRYPTION_KEY=SuaChaveDeEncriptacaoMinimo10Chars
N8N_USER_MANAGEMENT_JWT_SECRET=SeuJWTSecretMinimo32Caracteres

# Banco de Dados PostgreSQL
DB_TYPE=postgresdb
DB_POSTGRESDB_HOST=containers-us-west-x.railway.app
DB_POSTGRESDB_PORT=5432
DB_POSTGRESDB_DATABASE=railway
DB_POSTGRESDB_USER=postgres
DB_POSTGRESDB_PASSWORD=sua-senha-postgres
DB_POSTGRESDB_SCHEMA=public
DB_POSTGRESDB_SSL_ENABLED=true
DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

# Produção
NODE_ENV=production
GENERIC_TIMEZONE=America/Sao_Paulo
```

#### 🔄 Configurações Opcionais de Queue (Redis)
```bash
# Para usar modo queue (recomendado para alta performance)
EXECUTIONS_MODE=queue
QUEUE_BULL_REDIS_HOST=seu-redis-host
QUEUE_BULL_REDIS_PORT=6379
QUEUE_BULL_REDIS_PASSWORD=sua-senha-redis
```

#### 🔐 Configurações de Autenticação (Opcional)
```bash
# Autenticação básica
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=SuaSenhaSegura123
```

#### 📊 Configurações Avançadas
```bash
# Webhooks
WEBHOOK_URL=https://SEU-PROJETO.up.railway.app

# Armazenamento
N8N_DEFAULT_BINARY_DATA_MODE=filesystem
N8N_BINARY_DATA_TTL=24

# Limpeza automática
EXECUTIONS_DATA_PRUNE=true
EXECUTIONS_DATA_MAX_AGE=336

# Logs
N8N_LOG_LEVEL=info
N8N_VERSION_NOTIFICATIONS_ENABLED=false
N8N_METRICS=false
```

## 🛠️ Configuração Local para Desenvolvimento

1. Clone o repositório:
```bash
git clone <seu-repositorio>
cd n8n-railway-server
```

2. Instale as dependências:
```bash
npm install
```

3. Copie o arquivo de ambiente:
```bash
cp .env.example .env
```

4. Configure suas variáveis no arquivo `.env`

5. Execute localmente:
```bash
npm start
```

## 📦 Estrutura do Projeto

```
n8n-railway-server/
├── Dockerfile              # Container configuration
├── railway.json           # Railway deployment config
├── package.json           # Node.js dependencies
├── .env.example           # Environment variables template
├── .gitignore            # Git ignore rules
├── .dockerignore         # Docker ignore rules
└── README.md             # This documentation
```

## 🔧 Personalização

### Modificar Versão do n8n
Edite o `package.json`:
```json
{
  "dependencies": {
    "n8n": "^1.60.1"  // Altere para a versão desejada
  }
}
```

### Adicionar Plugins/Nodes Customizados
1. Crie um diretório `custom-nodes/`
2. Adicione seus nodes personalizados
3. Modifique o Dockerfile para copiar os nodes

## 🚨 Solução de Problemas

### Erro "command start not found"
- **Problema resolvido**: Alterado para usar imagem oficial `n8nio/n8n:latest`
- **Causa**: Instalação global do n8n em Alpine Linux tinha conflitos
- **Solução**: Usar imagem oficial que já vem com n8n pré-configurado

### Erro de Conexão com Banco
- Verifique se as credenciais do PostgreSQL estão corretas
- Confirme se `DB_POSTGRESDB_SSL_ENABLED=true`
- Teste a conexão manualmente

### Erro de Autenticação
- Verifique se `N8N_ENCRYPTION_KEY` tem pelo menos 10 caracteres
- Confirme se `N8N_USER_MANAGEMENT_JWT_SECRET` tem pelo menos 32 caracteres

### Problema com Webhooks
- Certifique-se de que `WEBHOOK_URL` aponta para sua URL da Railway
- Verifique se `N8N_PROTOCOL=https`

### Performance Issues
- Configure Redis e use `EXECUTIONS_MODE=queue`
- Ajuste `EXECUTIONS_DATA_MAX_AGE` para limpar dados antigos

### Problemas de Permissões
- A imagem oficial já vem com permissões configuradas corretamente
- Diretório `.n8n` é criado automaticamente

## 📋 Checklist de Deploy

- [ ] Projeto criado na Railway
- [ ] PostgreSQL configurado
- [ ] Variáveis de ambiente definidas
- [ ] `N8N_ENCRYPTION_KEY` gerada (min 10 chars)
- [ ] `N8N_USER_MANAGEMENT_JWT_SECRET` gerada (min 32 chars)
- [ ] `N8N_EDITOR_BASE_URL` configurada com URL da Railway
- [ ] Deploy realizado com sucesso
- [ ] Aplicação acessível via HTTPS
- [ ] Banco de dados conectando corretamente

## 🔗 Links Úteis

- [Documentação n8n](https://docs.n8n.io/)
- [Railway Documentation](https://docs.railway.app/)
- [n8n Environment Variables](https://docs.n8n.io/hosting/environment-variables/)
- [Railway PostgreSQL](https://docs.railway.app/databases/postgresql)

## 📞 Suporte

Para problemas específicos:
1. Verifique os logs no Railway Dashboard
2. Consulte a documentação oficial do n8n
3. Verifique as configurações de rede e DNS

---

**Desenvolvido por:** Neivam Carvalho  
**Data:** Setembro 2024  
**Versão:** 1.0.0