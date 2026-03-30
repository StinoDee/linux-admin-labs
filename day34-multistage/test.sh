#!/bin/bash

echo "Running tests..."

# Example test: check if Dockerfile exists
if [ ! -f Dockerfile ]; then
  echo "❌ Dockerfile not found!"
  exit 1
fi

echo "✅ Tests passed!"
