#!/bin/bash
set -e

echo "🚀 Iniciando n8n server na Railway..."

# Verificar se n8n está instalado
if ! command -v n8n &> /dev/null; then
    echo "❌ ERRO: n8n não encontrado, instalando..."
    npm install -g n8n@latest
fi

# Verificar versão
echo "📋 Versão n8n: $(n8n --version)"

# Verificar variáveis obrigatórias
if [ -z "$N8N_ENCRYPTION_KEY" ]; then
    echo "❌ ERRO: N8N_ENCRYPTION_KEY não configurada!"
    exit 1
fi

# Configurar diretório n8n
export N8N_USER_FOLDER=${N8N_USER_FOLDER:-/app/.n8n}
mkdir -p "$N8N_USER_FOLDER"

# Log configurações (sem dados sensíveis)
echo "📊 Configurações:"
echo "   - Host: ${N8N_HOST:-0.0.0.0}"
echo "   - Port: ${N8N_PORT:-5678}"
echo "   - Protocol: ${N8N_PROTOCOL:-http}"
echo "   - Environment: ${NODE_ENV:-development}"
echo "   - User Folder: $N8N_USER_FOLDER"

# Iniciar n8n
echo "🎯 Iniciando n8n..."
exec n8n start