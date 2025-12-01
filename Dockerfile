# ---- Build stage ----
FROM golang:1.25-alpine AS builder

WORKDIR /app

# Copy go module files first (for better caching)
COPY go.mod ./
RUN go mod download || true

# Copy the rest of the source
COPY . .

# Build the Go binary
RUN go build -o hello .

# ---- Run stage ----
FROM alpine:latest

WORKDIR /app

# Copy binary from builder
COPY --from=builder /app/hello .

# Run the app
CMD ["./hello"]