# Stage 1: Build stage
FROM node:18 AS builder

WORKDIR /app
COPY . .

# Simulate build step
RUN echo "Building app..."

# Stage 2: Production stage
FROM node:18-alpine

WORKDIR /app

# Copy only needed files from builder
COPY --from=builder /app /app

CMD ["node", "app.js"]
