#!/bin/bash

# Local Deployment Script
# This script helps you deploy the app locally using Docker Compose

set -e

# Color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Local Deployment Script${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Check if Docker is running
echo -e "${YELLOW}Checking Docker...${NC}"
if ! docker info > /dev/null 2>&1; then
    echo -e "${RED}Error: Docker is not running. Please start Docker Desktop.${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Docker is running${NC}"
echo ""

# Stop any existing containers
echo -e "${YELLOW}Stopping existing containers...${NC}"
docker-compose down > /dev/null 2>&1 || true
echo -e "${GREEN}✓ Cleaned up existing containers${NC}"
echo ""

# Build and start services
echo -e "${YELLOW}Building and starting services...${NC}"
echo -e "${BLUE}This may take a few minutes on first run...${NC}"
echo ""

docker-compose up --build -d

# Wait for services to be healthy
echo ""
echo -e "${YELLOW}Waiting for services to start...${NC}"
sleep 5

# Check backend health
echo -e "${YELLOW}Checking backend health...${NC}"
BACKEND_HEALTHY=false
for i in {1..30}; do
    if curl -s http://localhost:8000/ > /dev/null 2>&1; then
        BACKEND_HEALTHY=true
        break
    fi
    sleep 1
done

if [ "$BACKEND_HEALTHY" = true ]; then
    echo -e "${GREEN}✓ Backend is healthy${NC}"
else
    echo -e "${RED}✗ Backend failed to start${NC}"
    echo "Check logs with: docker-compose logs backend"
    exit 1
fi

# Check frontend health
echo -e "${YELLOW}Checking frontend health...${NC}"
FRONTEND_HEALTHY=false
for i in {1..30}; do
    if curl -s http://localhost:3000/ > /dev/null 2>&1; then
        FRONTEND_HEALTHY=true
        break
    fi
    sleep 1
done

if [ "$FRONTEND_HEALTHY" = true ]; then
    echo -e "${GREEN}✓ Frontend is healthy${NC}"
else
    echo -e "${RED}✗ Frontend failed to start${NC}"
    echo "Check logs with: docker-compose logs frontend"
    exit 1
fi

# Success message
echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}  🚀 Deployment Successful!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "Your application is now running:"
echo ""
echo -e "  ${BLUE}Frontend:${NC}     http://localhost:3000"
echo -e "  ${BLUE}Backend API:${NC}  http://localhost:8000"
echo -e "  ${BLUE}API Docs:${NC}     http://localhost:8000/docs"
echo ""
echo -e "Useful commands:"
echo -e "  ${YELLOW}View logs:${NC}        docker-compose logs -f"
echo -e "  ${YELLOW}Stop services:${NC}    docker-compose down"
echo -e "  ${YELLOW}Restart:${NC}          docker-compose restart"
echo ""
echo -e "${GREEN}Happy coding! 🎉${NC}"

