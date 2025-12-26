# Table of Contents
- [Quick Deployment Guide](#quick-deployment-guide)
- [Local Deployment (Development)](#local-deployment-development)
- [Cloud Deployment (Production)](#cloud-deployment-production)
  - [Option 1: Render](#option-1-render-recommended-for-beginners)
  - [Option 2: Railway](#option-2-railway)
  - [Option 3: Vercel + Render](#option-3-vercel-frontend--render-backend)
- [Pre-Deployment Checklist](#pre-deployment-checklist)
- [Environment Variables](#environment-variables)
- [Test Deployment](#test-deployment)
- [Common Issues](#common-issues)
- [Quick Commands](#quick-commands)

---

# Quick Deployment Guide

Choose your deployment method:

## 🏠 Local Deployment (Development)

### Using Deployment Script (Easiest)

```bash
./deploy-local.sh
```

This automatically:
- Checks Docker is running
- Builds and starts services
- Verifies health
- Shows URLs

### Manual Docker Compose

```bash
docker-compose up --build
```

Access at:
- Frontend: http://localhost:3000
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs

---

## ☁️ Cloud Deployment (Production)

### Option 1: Render (Recommended for Beginners)

**Time: 10 minutes | Cost: Free tier available**

1. Push code to GitHub
2. Sign up at [render.com](https://render.com)
3. Deploy backend:
   - New Web Service → Connect repo
   - Root Directory: `backend`
   - Runtime: Docker
   - Add env vars (see below)
4. Deploy frontend:
   - New Web Service → Connect repo
   - Root Directory: `frontend`
   - Runtime: Docker
   - Set `NEXT_PUBLIC_API_URL` to backend URL
5. Update backend `CORS_ORIGINS` with frontend URL

**Backend Environment Variables:**
```
APP_NAME=Hello API
APP_VERSION=1.0.0
HOST=0.0.0.0
PORT=8000
LOG_LEVEL=INFO
CORS_ORIGINS=https://your-frontend.onrender.com
```

**Frontend Environment Variables:**
```
NEXT_PUBLIC_API_URL=https://your-backend.onrender.com
NODE_ENV=production
```

---

### Option 2: Railway

**Time: 5 minutes | Cost: $5/month credit**

```bash
# Install Railway CLI
brew install railway

# Login
railway login

# Deploy backend
cd backend
railway up
railway variables set CORS_ORIGINS="https://your-frontend.railway.app"

# Deploy frontend
cd ../frontend
railway up
railway variables set NEXT_PUBLIC_API_URL="https://your-backend.railway.app"
```

---

### Option 3: Vercel (Frontend) + Render (Backend)

**Best Next.js performance**

**Backend on Render** (see Option 1)

**Frontend on Vercel:**
```bash
cd frontend
npm install -g vercel
vercel
vercel env add NEXT_PUBLIC_API_URL
# Enter your backend URL
vercel --prod
```

---

## 🔍 Pre-Deployment Checklist

Run this before deploying:

```bash
./deploy-check.sh
```

This checks:
- Docker is running
- All Dockerfiles exist
- Builds succeed
- Tests pass
- No sensitive files in git
- .gitignore configured

---

## 📝 Environment Variables

### Backend (.env)

```bash
APP_NAME=Hello API
APP_VERSION=1.0.0
HOST=0.0.0.0
PORT=8000
LOG_LEVEL=INFO
CORS_ORIGINS=http://localhost:3000,https://your-frontend-domain.com
```

### Frontend (.env.local for dev, .env.production for prod)

```bash
NEXT_PUBLIC_API_URL=http://localhost:8000  # or your backend URL
NODE_ENV=production  # for production only
```

---

## 🧪 Test Deployment

### Test Backend
```bash
curl https://your-backend-url.com/
curl https://your-backend-url.com/api/hello
```

### Test Frontend
Visit your frontend URL and check:
- Data loads from backend
- No console errors (F12)
- Works on mobile

---

## 🆘 Common Issues

### Frontend can't connect to backend
- Check `NEXT_PUBLIC_API_URL` is set correctly
- Verify backend is accessible
- Check CORS configuration

### CORS errors
- Add frontend URL to backend `CORS_ORIGINS`
- Include both http:// and https:// if needed
- Redeploy backend after updating

### Build fails
- Test Docker build locally: `docker build -t test ./backend`
- Check logs for specific errors
- Verify all dependencies in package.json/pyproject.toml

---

## 📚 Full Documentation

For detailed guides, see [GUIDE.md](./GUIDE.md)

For local development, see [Quickstart.md](../../Quickstart.md)

For project overview, see [README.md](../../README.md)

---

## 🚀 Quick Commands

```bash
# Local deployment
./deploy-local.sh

# Pre-deployment check
./deploy-check.sh

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Restart
docker-compose restart
```

---

Need help? Check the full [GUIDE.md](./GUIDE.md) guide!

