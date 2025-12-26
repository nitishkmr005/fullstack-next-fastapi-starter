#!/bin/bash

# Deployment Status Checker
# This script checks if your deployed services are healthy

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Deployment Status Checker${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Function to check URL
check_url() {
    local url=$1
    local name=$2
    
    echo -e "${YELLOW}Checking ${name}...${NC}"
    
    if curl -s -o /dev/null -w "%{http_code}" --max-time 10 "$url" | grep -q "200\|301\|302"; then
        echo -e "${GREEN}✓ ${name} is accessible${NC}"
        return 0
    else
        echo -e "${RED}✗ ${name} is not accessible${NC}"
        return 1
    fi
}

# Check if running locally or remotely
if [ "$1" = "local" ] || [ -z "$1" ]; then
    echo "Checking local deployment..."
    echo ""
    
    # Check backend
    check_url "http://localhost:8000/" "Backend (http://localhost:8000)"
    BACKEND_STATUS=$?
    
    if [ $BACKEND_STATUS -eq 0 ]; then
        check_url "http://localhost:8000/api/hello" "Backend API endpoint"
        check_url "http://localhost:8000/docs" "Backend API docs"
    fi
    
    echo ""
    
    # Check frontend
    check_url "http://localhost:3000/" "Frontend (http://localhost:3000)"
    FRONTEND_STATUS=$?
    
    echo ""
    echo "================================"
    
    if [ $BACKEND_STATUS -eq 0 ] && [ $FRONTEND_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ All services are running!${NC}"
        echo ""
        echo "Access your application:"
        echo -e "  ${BLUE}Frontend:${NC}     http://localhost:3000"
        echo -e "  ${BLUE}Backend API:${NC}  http://localhost:8000"
        echo -e "  ${BLUE}API Docs:${NC}     http://localhost:8000/docs"
    else
        echo -e "${RED}✗ Some services are not running${NC}"
        echo ""
        echo "To start services, run:"
        echo "  ./deploy-local.sh"
        echo "or"
        echo "  docker-compose up --build"
    fi
    
elif [ "$1" = "remote" ]; then
    if [ -z "$2" ] || [ -z "$3" ]; then
        echo -e "${RED}Error: Remote check requires backend and frontend URLs${NC}"
        echo ""
        echo "Usage: $0 remote <backend-url> <frontend-url>"
        echo "Example: $0 remote https://api.example.com https://example.com"
        exit 1
    fi
    
    BACKEND_URL=$2
    FRONTEND_URL=$3
    
    echo "Checking remote deployment..."
    echo ""
    
    # Check backend
    check_url "$BACKEND_URL/" "Backend ($BACKEND_URL)"
    BACKEND_STATUS=$?
    
    if [ $BACKEND_STATUS -eq 0 ]; then
        check_url "$BACKEND_URL/api/hello" "Backend API endpoint"
        check_url "$BACKEND_URL/docs" "Backend API docs"
    fi
    
    echo ""
    
    # Check frontend
    check_url "$FRONTEND_URL/" "Frontend ($FRONTEND_URL)"
    FRONTEND_STATUS=$?
    
    echo ""
    echo "================================"
    
    if [ $BACKEND_STATUS -eq 0 ] && [ $FRONTEND_STATUS -eq 0 ]; then
        echo -e "${GREEN}✓ All services are accessible!${NC}"
        echo ""
        echo "Your application is live:"
        echo -e "  ${BLUE}Frontend:${NC}     $FRONTEND_URL"
        echo -e "  ${BLUE}Backend API:${NC}  $BACKEND_URL"
        echo -e "  ${BLUE}API Docs:${NC}     $BACKEND_URL/docs"
    else
        echo -e "${RED}✗ Some services are not accessible${NC}"
        echo ""
        echo "Troubleshooting steps:"
        echo "1. Check deployment logs on your platform"
        echo "2. Verify environment variables are set correctly"
        echo "3. Ensure services have finished deploying"
        echo "4. Check CORS configuration if frontend can't reach backend"
    fi
else
    echo -e "${RED}Invalid argument${NC}"
    echo ""
    echo "Usage:"
    echo "  $0                                    # Check local deployment"
    echo "  $0 local                              # Check local deployment"
    echo "  $0 remote <backend-url> <frontend-url> # Check remote deployment"
    echo ""
    echo "Examples:"
    echo "  $0"
    echo "  $0 local"
    echo "  $0 remote https://api.example.com https://example.com"
    exit 1
fi

echo "================================"
echo ""

