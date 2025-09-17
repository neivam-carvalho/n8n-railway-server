# Use Node.js base image instead of n8n image
FROM node:18-alpine

# Install required dependencies
RUN apk add --no-cache \
    python3 \
    make \
    g++ \
    git \
    wget

# Create app directory
WORKDIR /home/node

# Copy package files
COPY package*.json ./

# Install n8n and dependencies
RUN npm install -g n8n && \
    npm install --only=production && \
    npm cache clean --force

# Create n8n user and set permissions
RUN addgroup -g 1000 node && \
    adduser -u 1000 -G node -s /bin/sh -D node || true

# Copy application files
COPY --chown=node:node . .

# Switch to node user
USER node

# Create .n8n directory with proper permissions
RUN mkdir -p /home/node/.n8n && \
    chmod 700 /home/node/.n8n

# Set environment variables
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_PROTOCOL=https
ENV NODE_ENV=production
ENV EXECUTIONS_MODE=queue
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# Expose the port that n8n runs on
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]