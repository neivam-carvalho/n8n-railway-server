# Use the official n8n image as base
FROM n8nio/n8n:latest

# Set the working directory
WORKDIR /home/node

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
USER root
RUN npm ci --only=production && npm cache clean --force

# Switch back to node user for security
USER node

# Copy application files
COPY --chown=node:node . .

# Expose the port that n8n runs on
EXPOSE 5678

# Set environment variables
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV EXECUTIONS_MODE=queue
ENV QUEUE_BULL_REDIS_HOST=redis
ENV DB_TYPE=postgresdb

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]