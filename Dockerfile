# ==============================================================================
# Multi-Stage Dockerfile for Celebration & Event Planner
# Compatible with Google Cloud Run, AWS App Runner, and standard Docker hosts.
# ==============================================================================

# ------------------------------------------------------------------------------
# Stage 1: Builder (Builds React Vite Client)
# ------------------------------------------------------------------------------
FROM node:20-alpine AS builder

WORKDIR /app

# Copy root and workspace package files
COPY package.json package-lock.json ./
COPY client/package.json ./client/
COPY server/package.json ./server/

# Install dependencies
RUN npm ci

# Copy full source tree
COPY shared ./shared
COPY client ./client
COPY server ./server

# Build production client bundle
RUN npm run build

# ------------------------------------------------------------------------------
# Stage 2: Production Runtime
# ------------------------------------------------------------------------------
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=8080
ENV MOCK_AI=true

# Copy package manifests
COPY package.json package-lock.json ./
COPY server/package.json ./server/

# Install only production dependencies
RUN npm ci --omit=dev

# Copy server code and shared schemas
COPY shared ./shared
COPY server ./server

# Copy compiled frontend from builder stage
COPY --from=builder /app/client/dist ./client/dist

# Use non-root node user for hardened security
USER node

# Expose standard Cloud Run / Container port
EXPOSE 8080

# Launch server
CMD ["node", "server/index.js"]
