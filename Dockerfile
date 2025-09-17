# Use Node.js base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git \
    wget \
    curl

# Install n8n globally first
RUN npm install -g n8n@latest

# Copy package files
COPY package*.json ./

# Install any additional dependencies (if any)
RUN npm install --production || true

# Create n8n user and directories
RUN addgroup -g 1000 n8n && \
    adduser -u 1000 -G n8n -s /bin/sh -D n8n && \
    mkdir -p /app/.n8n && \
    chown -R n8n:n8n /app

# Copy application files
COPY --chown=n8n:n8n . .

# Switch to n8n user
USER n8n

# Set environment variables
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV N8N_USER_FOLDER=/app/.n8n

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]