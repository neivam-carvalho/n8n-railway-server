#!/bin/bash

# Startup script for n8n on Railway
# This script can be used for custom initialization if needed

echo "🚀 Starting n8n server on Railway..."

# Check if required environment variables are set
if [ -z "$N8N_ENCRYPTION_KEY" ]; then
    echo "❌ ERROR: N8N_ENCRYPTION_KEY is not set!"
    exit 1
fi

if [ -z "$DB_POSTGRESDB_HOST" ]; then
    echo "❌ ERROR: Database configuration is missing!"
    exit 1
fi

# Print some basic info (without sensitive data)
echo "📊 n8n Configuration:"
echo "   - Host: $N8N_HOST"
echo "   - Port: $N8N_PORT"
echo "   - Protocol: $N8N_PROTOCOL"
echo "   - Database Type: $DB_TYPE"
echo "   - Environment: $NODE_ENV"
echo "   - Timezone: $GENERIC_TIMEZONE"

# Start n8n
echo "🎯 Launching n8n..."
exec n8n start