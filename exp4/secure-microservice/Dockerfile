# ================================
# STAGE 1: Build / Dependencies
# ================================

FROM node:20-alpine AS builder

WORKDIR /build

# Copy dependency files first
COPY package*.json ./

# Install production dependencies
RUN npm ci --only=production

# Copy application source
COPY . .


# ================================
# STAGE 2: Production Runtime
# ================================

FROM node:20-alpine AS runner

WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

# Copy only required files from builder
COPY --from=builder /build/package*.json ./
COPY --from=builder /build/node_modules ./node_modules
COPY --from=builder /build/server.js ./

# Give ownership to non-root user
RUN chown -R appuser:appgroup /app

# Run application as non-root user
USER appuser

EXPOSE 3000

CMD ["node", "server.js"]