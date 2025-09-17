# Use Node.js como base e instale n8n de forma robusta
# Use Node.js 20 Alpine (compatível com n8n 1.111.0)
FROM node:20-alpine

# Instalar dependências do sistema
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git \
    curl \
    bash

# Criar usuário n8n (usar grupo existente se GID 1000 já existir)
RUN addgroup -g 1001 n8n 2>/dev/null || addgroup n8n && \
    adduser -u 1001 -G n8n -s /bin/bash -D n8n

# Definir diretório de trabalho
WORKDIR /home/node
RUN chown n8n:n8n /home/node

# Instalar n8n globalmente
RUN npm install -g n8n@latest

# Criar script de inicialização
RUN echo '#!/bin/bash' > /usr/local/bin/start-n8n.sh && \
    echo 'set -e' >> /usr/local/bin/start-n8n.sh && \
    echo 'echo "🚀 Iniciando n8n..."' >> /usr/local/bin/start-n8n.sh && \
    echo 'echo "Versão n8n: $(n8n --version)"' >> /usr/local/bin/start-n8n.sh && \
    echo 'echo "PATH: $PATH"' >> /usr/local/bin/start-n8n.sh && \
    echo 'echo "Usuário: $(whoami)"' >> /usr/local/bin/start-n8n.sh && \
    echo 'mkdir -p /home/node/.n8n' >> /usr/local/bin/start-n8n.sh && \
    echo 'chown -R 1001:1001 /home/node/.n8n' >> /usr/local/bin/start-n8n.sh && \
    echo 'exec n8n start' >> /usr/local/bin/start-n8n.sh && \
    chmod +x /usr/local/bin/start-n8n.sh

# Mudar para usuário n8n
USER n8n

# Configurar variáveis de ambiente
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV PATH="/usr/local/bin:$PATH"

# Expor porta
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Usar ENTRYPOINT para garantir execução
ENTRYPOINT ["/usr/local/bin/start-n8n.sh"]