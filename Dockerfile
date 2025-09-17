# Use a imagem oficial do n8n
FROM n8nio/n8n:latest

# Mude para usuário root temporariamente para configurações
USER root

# Instalar curl para health check
RUN apk add --no-cache curl

# Definir diretório de trabalho
WORKDIR /home/node

# Copiar arquivos de configuração
COPY package*.json ./

# Voltar para o usuário node
USER node

# Configurar variáveis de ambiente
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production

# Expor porta
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Iniciar n8n
CMD ["n8n", "start"]