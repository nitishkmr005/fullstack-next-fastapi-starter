# Table of Contents
- [Local Deployment](#local-deployment)
- [Prerequisites](#prerequisites)
- [Method 1: One-Command Deploy](#method-1-one-command-deploy-recommended)
- [Method 2: Manual Docker Compose](#method-2-manual-docker-compose)
- [Method 3: Development Mode](#method-3-development-mode-separate-terminals)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Useful Commands](#useful-commands)

---

# Local Deployment

**Time**: 1-5 minutes  
**Difficulty**: ⭐ Easy  
**Cost**: Free (uses your computer)  
**Best for**: Development, testing, learning

## Prerequisites

- **Docker Desktop** installed ([download](https://www.docker.com/products/docker-desktop/))
- Code cloned to your computer

## Method 1: One-Command Deploy (Recommended)

### Quick Start

```bash
./deploy-local.sh
```

This script automatically:
- ✅ Checks if Docker is running
- ✅ Stops any existing containers
- ✅ Builds and starts both services
- ✅ Verifies health of backend and frontend
- ✅ Shows you the URLs

### Access Your App

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs

### Stop Services

```bash
docker-compose down
```

## Method 2: Manual Docker Compose

### Start Services

```bash
docker-compose up --build
```

Flags explained:
- `--build`: Rebuilds images before starting
- `-d`: Run in background (detached mode)

### View Logs

```bash
# All services
docker-compose logs -f

# Backend only
docker-compose logs -f backend

# Frontend only
docker-compose logs -f frontend
```

### Stop Services

```bash
# Stop and remove containers
docker-compose down

# Stop, remove containers and volumes
docker-compose down -v
```

## Method 3: Development Mode (Separate Terminals)

### Terminal 1: Backend

```bash
cd backend
make install  # Install dependencies
make run      # Start backend
```

Backend runs at: http://localhost:8000

### Terminal 2: Frontend

```bash
cd frontend
npm install   # Install dependencies
npm run dev   # Start frontend
```

Frontend runs at: http://localhost:3000

### Benefits

- Hot reload on file changes
- Faster iteration
- Direct access to logs
- Easy debugging

## Verification

### Check Deployment

```bash
./check-deployment.sh
```

This verifies:
- ✅ Backend is accessible
- ✅ API endpoint works
- ✅ Frontend is accessible
- ✅ API docs are available

### Manual Verification

**Backend**:
```bash
curl http://localhost:8000/
curl http://localhost:8000/api/hello
```

**Frontend**:
Open browser to http://localhost:3000

**API Docs**:
Open browser to http://localhost:8000/docs

## Troubleshooting

### Docker Not Running

**Problem**: `Cannot connect to the Docker daemon`

**Solution**:
1. Start Docker Desktop
2. Wait for Docker to fully start
3. Try again

### Port Already in Use

**Problem**: `Port 3000 (or 8000) is already allocated`

**Solutions**:

**Option 1 - Kill process using port**:
```bash
# Find process on port 3000
lsof -ti:3000 | xargs kill -9

# Find process on port 8000
lsof -ti:8000 | xargs kill -9
```

**Option 2 - Stop conflicting containers**:
```bash
docker-compose down
docker ps  # Check for other containers
docker stop $(docker ps -aq)  # Stop all containers
```

### Build Fails

**Problem**: Docker build errors

**Solutions**:
1. Check Docker logs:
   ```bash
   docker-compose logs
   ```

2. Rebuild from scratch:
   ```bash
   docker-compose down -v
   docker system prune -a  # WARNING: Removes all unused Docker data
   docker-compose up --build
   ```

3. Check specific service:
   ```bash
   cd backend  # or frontend
   docker build -t test .
   ```

### Frontend Can't Connect to Backend

**Problem**: CORS errors or connection refused

**Solutions**:
1. Verify backend is running:
   ```bash
   curl http://localhost:8000/
   ```

2. Check `docker-compose.yaml` environment variables:
   ```yaml
   frontend:
     environment:
       - NEXT_PUBLIC_API_URL=http://localhost:8000  # Should be this
   ```

3. Check browser console (F12) for specific errors

### Permission Denied

**Problem**: Permission errors when running scripts

**Solution**:
```bash
chmod +x deploy-local.sh
chmod +x check-deployment.sh
chmod +x deploy-check.sh
```

## Useful Commands

### Docker Compose

```bash
# Start services
docker-compose up                    # Foreground
docker-compose up -d                 # Background
docker-compose up --build            # Rebuild and start

# Stop services
docker-compose stop                  # Stop (can restart)
docker-compose down                  # Stop and remove
docker-compose down -v               # Stop, remove, and delete volumes

# View logs
docker-compose logs                  # All logs
docker-compose logs -f               # Follow logs
docker-compose logs -f backend       # Follow backend logs

# Restart services
docker-compose restart               # Restart all
docker-compose restart backend       # Restart backend only

# View running services
docker-compose ps

# Execute command in container
docker-compose exec backend bash     # Open bash in backend
docker-compose exec frontend sh      # Open shell in frontend
```

### Docker

```bash
# List containers
docker ps                            # Running containers
docker ps -a                         # All containers

# View logs
docker logs <container-id>           # View logs
docker logs -f <container-id>        # Follow logs

# Stop/Remove
docker stop <container-id>           # Stop container
docker rm <container-id>             # Remove container

# Images
docker images                        # List images
docker rmi <image-id>                # Remove image

# Clean up
docker system prune                  # Remove unused data
docker system prune -a               # Remove all unused data
docker volume prune                  # Remove unused volumes
```

### Backend (Development Mode)

```bash
cd backend

# Install dependencies
make install

# Run server
make run

# Run tests
make test

# Format code
make format

# Lint code
make lint

# Clean cache
make clean
```

### Frontend (Development Mode)

```bash
cd frontend

# Install dependencies
npm install

# Development server
npm run dev

# Production build
npm run build
npm start  # Run production build

# Linting
npm run lint
```

## Environment Variables

### For Docker Compose

Edit `docker-compose.yaml`:

```yaml
backend:
  environment:
    - LOG_LEVEL=DEBUG  # Change to DEBUG for more logs

frontend:
  environment:
    - NEXT_PUBLIC_API_URL=http://localhost:8000
```

### For Development Mode

**Backend** - Create `backend/.env`:
```
APP_NAME=Hello API
LOG_LEVEL=DEBUG
PORT=8000
```

**Frontend** - Create `frontend/.env.local`:
```
NEXT_PUBLIC_API_URL=http://localhost:8000
```

## Next Steps

### Make Changes

Both services support hot reload:
- Edit backend code → Server auto-restarts
- Edit frontend code → Page auto-refreshes

### Run Tests

```bash
# Backend tests
cd backend
make test

# Frontend tests (if added)
cd frontend
npm test
```

### Prepare for Cloud Deployment

1. Test locally first: `./deploy-local.sh`
2. Run pre-deployment checks: `./deploy-check.sh`
3. Choose cloud platform: See [START_HERE.md](./START_HERE.md)

---

## Quick Reference

```bash
# Deploy
./deploy-local.sh

# Check status
./check-deployment.sh

# View logs
docker-compose logs -f

# Stop
docker-compose down

# Rebuild
docker-compose up --build
```

---

**✅ Your app is now running locally! 🚀**

Ready for cloud deployment? See [START_HERE.md](./START_HERE.md)

