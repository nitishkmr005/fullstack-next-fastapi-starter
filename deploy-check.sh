#!/bin/bash

# Pre-Deployment Check Script
# This script verifies your app is ready for deployment

set -e

echo "🔍 Running Pre-Deployment Checks..."
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Track if any checks fail
CHECKS_PASSED=true

# Function to print check result
print_check() {
    if [ $1 -eq 0 ]; then
        echo -e "${GREEN}✓${NC} $2"
    else
        echo -e "${RED}✗${NC} $2"
        CHECKS_PASSED=false
    fi
}

# 1. Check if Docker is running
echo "1. Checking Docker..."
if docker info > /dev/null 2>&1; then
    print_check 0 "Docker is running"
else
    print_check 1 "Docker is not running - start Docker Desktop"
fi
echo ""

# 2. Check if docker-compose.yaml exists
echo "2. Checking docker-compose.yaml..."
if [ -f "docker-compose.yaml" ]; then
    print_check 0 "docker-compose.yaml exists"
else
    print_check 1 "docker-compose.yaml not found"
fi
echo ""

# 3. Check backend Dockerfile
echo "3. Checking backend Dockerfile..."
if [ -f "backend/Dockerfile" ]; then
    print_check 0 "backend/Dockerfile exists"
else
    print_check 1 "backend/Dockerfile not found"
fi
echo ""

# 4. Check frontend Dockerfile
echo "4. Checking frontend Dockerfile..."
if [ -f "frontend/Dockerfile" ]; then
    print_check 0 "frontend/Dockerfile exists"
else
    print_check 1 "frontend/Dockerfile not found"
fi
echo ""

# 5. Check if environment variable examples exist
echo "5. Checking environment variable templates..."
if [ -f "backend/env.example" ]; then
    print_check 0 "backend/env.example exists"
else
    print_check 1 "backend/env.example not found"
fi

if [ -f "frontend/env.local.example" ]; then
    print_check 0 "frontend/env.local.example exists"
else
    print_check 1 "frontend/env.local.example not found"
fi
echo ""

# 6. Try to build Docker images
echo "6. Testing Docker builds..."
echo -e "${YELLOW}Building backend image...${NC}"
if docker build -t hello-backend-test ./backend > /dev/null 2>&1; then
    print_check 0 "Backend Docker build successful"
else
    print_check 1 "Backend Docker build failed - check backend/Dockerfile"
fi

echo -e "${YELLOW}Building frontend image...${NC}"
if docker build -t hello-frontend-test ./frontend > /dev/null 2>&1; then
    print_check 0 "Frontend Docker build successful"
else
    print_check 1 "Frontend Docker build failed - check frontend/Dockerfile"
fi
echo ""

# 7. Check for backend tests
echo "7. Checking backend tests..."
if [ -f "backend/tests/test_api.py" ]; then
    print_check 0 "Backend tests exist"
    
    # Try to run tests if backend is already built
    echo -e "${YELLOW}Running backend tests...${NC}"
    cd backend
    if make test > /dev/null 2>&1; then
        print_check 0 "Backend tests passed"
    else
        print_check 1 "Backend tests failed - fix tests before deploying"
    fi
    cd ..
else
    print_check 1 "Backend tests not found"
fi
echo ""

# 8. Check for sensitive files that shouldn't be committed
echo "8. Checking for sensitive files..."
SENSITIVE_FILES_FOUND=false

if [ -f "backend/.env" ]; then
    echo -e "${YELLOW}⚠${NC}  Found backend/.env - make sure it's in .gitignore"
    SENSITIVE_FILES_FOUND=true
fi

if [ -f "frontend/.env.local" ]; then
    echo -e "${YELLOW}⚠${NC}  Found frontend/.env.local - make sure it's in .gitignore"
    SENSITIVE_FILES_FOUND=true
fi

if [ -f "frontend/.env.production" ]; then
    echo -e "${YELLOW}⚠${NC}  Found frontend/.env.production - make sure it's in .gitignore"
    SENSITIVE_FILES_FOUND=true
fi

if [ "$SENSITIVE_FILES_FOUND" = false ]; then
    print_check 0 "No sensitive files found in working directory"
fi
echo ""

# 9. Check .gitignore
echo "9. Checking .gitignore..."
if [ -f ".gitignore" ]; then
    print_check 0 ".gitignore exists"
    
    # Check if common patterns are in .gitignore
    if grep -q "\.env" .gitignore; then
        print_check 0 ".env files are ignored"
    else
        print_check 1 ".env files should be in .gitignore"
    fi
    
    if grep -q "node_modules" .gitignore; then
        print_check 0 "node_modules is ignored"
    else
        print_check 1 "node_modules should be in .gitignore"
    fi
else
    print_check 1 ".gitignore not found"
fi
echo ""

# 10. Check if code is in git repository
echo "10. Checking git repository..."
if [ -d ".git" ]; then
    print_check 0 "Git repository initialized"
    
    # Check for uncommitted changes
    if git diff-index --quiet HEAD -- 2>/dev/null; then
        print_check 0 "No uncommitted changes"
    else
        echo -e "${YELLOW}⚠${NC}  You have uncommitted changes - commit before deploying"
    fi
else
    print_check 1 "Not a git repository - initialize git for cloud deployment"
fi
echo ""

# Final summary
echo "================================"
if [ "$CHECKS_PASSED" = true ]; then
    echo -e "${GREEN}✓ All checks passed! Ready to deploy! 🚀${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Push your code to GitHub (if not already)"
    echo "2. Follow DEPLOYMENT.md for platform-specific instructions"
    echo "3. Set environment variables on your deployment platform"
    echo "4. Deploy and test!"
else
    echo -e "${RED}✗ Some checks failed. Fix issues before deploying.${NC}"
    echo ""
    echo "Review the errors above and fix them."
fi
echo "================================"
echo ""

# Cleanup test images
echo "Cleaning up test images..."
docker rmi hello-backend-test hello-frontend-test > /dev/null 2>&1 || true
echo -e "${GREEN}Done!${NC}"

