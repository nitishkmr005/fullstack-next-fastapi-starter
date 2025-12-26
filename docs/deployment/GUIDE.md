# Deployment Guide

This guide provides multiple deployment options for your full-stack application (Next.js frontend + FastAPI backend).

## 📋 Table of Contents

1. [Local Docker Deployment](#1-local-docker-deployment)
2. [Cloud Deployment Options](#2-cloud-deployment-options)
   - [Render (Easiest)](#option-a-render-easiest-free-tier)
   - [Railway](#option-b-railway-easy-generous-free-tier)
   - [Vercel + Render](#option-c-vercel-frontend--render-backend)
   - [DigitalOcean App Platform](#option-d-digitalocean-app-platform)
   - [AWS ECS/Fargate](#option-e-aws-ecsfargate-production-grade)
   - [Fly.io](#option-f-flyio-docker-focused)
3. [Environment Variables Setup](#3-environment-variables-setup)
4. [Pre-Deployment Checklist](#4-pre-deployment-checklist)
5. [Post-Deployment Testing](#5-post-deployment-testing)

---

## 1. Local Docker Deployment

### Quick Start

```bash
# Navigate to project root
cd /Users/nitishkumarharsoor/Documents/1.Learnings/1.Projects/4.Experiments/3.Website

# Start both services
docker-compose up --build

# Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:8000
# API Docs: http://localhost:8000/docs
```

### Stop Services

```bash
docker-compose down

# Remove volumes as well
docker-compose down -v
```

---

## 2. Cloud Deployment Options

### Option A: Render (Easiest, Free Tier)

**Best for**: Quick deployments, side projects, prototypes

#### Step 1: Prepare Your Code

1. Push your code to GitHub (if not already):

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main
```

#### Step 2: Deploy Backend to Render

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure:
   - **Name**: `hello-api-backend`
   - **Region**: Choose closest to your users
   - **Branch**: `main`
   - **Root Directory**: `backend`
   - **Runtime**: `Docker`
   - **Instance Type**: `Free` (or paid for better performance)

5. Add Environment Variables:
   ```
   APP_NAME=Hello API
   APP_VERSION=1.0.0
   HOST=0.0.0.0
   PORT=8000
   LOG_LEVEL=INFO
   CORS_ORIGINS=https://your-frontend-url.onrender.com
   ```
   (You'll update `CORS_ORIGINS` after deploying frontend)

6. Click **"Create Web Service"**
7. Wait for deployment (5-10 minutes)
8. Copy your backend URL (e.g., `https://hello-api-backend.onrender.com`)

#### Step 3: Deploy Frontend to Render

1. Click **"New +"** → **"Web Service"** again
2. Select same repository
3. Configure:
   - **Name**: `hello-frontend`
   - **Region**: Same as backend
   - **Branch**: `main`
   - **Root Directory**: `frontend`
   - **Runtime**: `Docker`
   - **Instance Type**: `Free`

4. Add Environment Variables:
   ```
   NEXT_PUBLIC_API_URL=https://hello-api-backend.onrender.com
   NODE_ENV=production
   ```
   (Use the backend URL from Step 2)

5. Click **"Create Web Service"**
6. Wait for deployment

#### Step 4: Update CORS

1. Go back to backend service settings
2. Update `CORS_ORIGINS` environment variable:
   ```
   CORS_ORIGINS=https://your-frontend-url.onrender.com
   ```
3. Save and redeploy

✅ **Done!** Your app is now live on Render!

**Note**: Free tier services sleep after 15 minutes of inactivity. First request may be slow.

---

### Option B: Railway (Easy, Generous Free Tier)

**Best for**: Fast deployments, microservices, databases

#### Step 1: Install Railway CLI

```bash
# macOS
brew install railway

# npm (alternative)
npm install -g @railway/cli
```

#### Step 2: Login and Initialize

```bash
# Login to Railway
railway login

# Create new project
railway init
```

#### Step 3: Deploy Backend

```bash
cd backend

# Create Railway service
railway up

# Set environment variables
railway variables set APP_NAME="Hello API"
railway variables set APP_VERSION="1.0.0"
railway variables set HOST="0.0.0.0"
railway variables set PORT="8000"
railway variables set LOG_LEVEL="INFO"

# Get backend URL
railway domain
```

#### Step 4: Deploy Frontend

```bash
cd ../frontend

# Create new service in same project
railway up

# Set environment variables (use backend URL from previous step)
railway variables set NEXT_PUBLIC_API_URL="https://your-backend.railway.app"
railway variables set NODE_ENV="production"

# Get frontend URL
railway domain
```

#### Step 5: Update Backend CORS

```bash
cd ../backend
railway variables set CORS_ORIGINS="https://your-frontend.railway.app"
```

✅ **Done!** Your app is deployed on Railway!

---

### Option C: Vercel (Frontend) + Render (Backend)

**Best for**: Optimal Next.js performance, production apps

#### Deploy Backend to Render

Follow [Option A: Step 2](#step-2-deploy-backend-to-render) above.

#### Deploy Frontend to Vercel

1. Install Vercel CLI:
   ```bash
   npm install -g vercel
   ```

2. Navigate to frontend:
   ```bash
   cd frontend
   ```

3. Deploy:
   ```bash
   vercel
   ```

4. Follow prompts:
   - Link to existing project or create new
   - Configure settings (defaults are usually fine)

5. Set environment variable:
   ```bash
   vercel env add NEXT_PUBLIC_API_URL
   # Enter your backend URL: https://hello-api-backend.onrender.com
   # Select: Production
   ```

6. Redeploy to apply changes:
   ```bash
   vercel --prod
   ```

7. Update backend CORS with Vercel URL

✅ **Done!** Frontend on Vercel, Backend on Render!

---

### Option D: DigitalOcean App Platform

**Best for**: Simple deployments with managed infrastructure

#### Step 1: Create App

1. Go to [DigitalOcean App Platform](https://cloud.digitalocean.com/apps)
2. Click **"Create App"**
3. Connect GitHub repository
4. DigitalOcean will auto-detect your services

#### Step 2: Configure Services

**Backend Service:**
- **Resource Type**: Web Service
- **Source Directory**: `backend`
- **Dockerfile Path**: `backend/Dockerfile`
- **HTTP Port**: `8000`
- **Environment Variables**:
  ```
  APP_NAME=Hello API
  APP_VERSION=1.0.0
  HOST=0.0.0.0
  PORT=8000
  LOG_LEVEL=INFO
  ```

**Frontend Service:**
- **Resource Type**: Web Service
- **Source Directory**: `frontend`
- **Dockerfile Path**: `frontend/Dockerfile`
- **HTTP Port**: `3000`
- **Environment Variables**:
  ```
  NEXT_PUBLIC_API_URL=${backend.PUBLIC_URL}
  NODE_ENV=production
  ```

#### Step 3: Deploy

1. Click **"Next"** → Review → **"Create Resources"**
2. Wait for deployment (5-10 minutes)
3. Update backend CORS_ORIGINS with frontend URL

✅ **Done!** Deployed on DigitalOcean!

**Cost**: Starts at $5/month per service.

---

### Option E: AWS ECS/Fargate (Production-Grade)

**Best for**: Enterprise applications, scalability, full control

This is more complex and requires AWS experience. High-level steps:

1. **Push Docker images to ECR**:
   ```bash
   # Authenticate Docker to ECR
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.us-east-1.amazonaws.com
   
   # Build and push backend
   cd backend
   docker build -t hello-backend .
   docker tag hello-backend:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/hello-backend:latest
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/hello-backend:latest
   
   # Build and push frontend
   cd ../frontend
   docker build -t hello-frontend .
   docker tag hello-frontend:latest <account-id>.dkr.ecr.us-east-1.amazonaws.com/hello-frontend:latest
   docker push <account-id>.dkr.ecr.us-east-1.amazonaws.com/hello-frontend:latest
   ```

2. **Create ECS Cluster** via AWS Console or CLI

3. **Create Task Definitions** for backend and frontend

4. **Create Services** in ECS

5. **Set up Application Load Balancer**

6. **Configure Route53** for custom domains

**Alternative**: Use AWS Copilot CLI for simplified deployment:
```bash
copilot init
copilot deploy
```

---

### Option F: Fly.io (Docker-Focused)

**Best for**: Docker applications, edge computing, fast cold starts

#### Step 1: Install Fly CLI

```bash
# macOS
brew install flyctl

# Linux/WSL
curl -L https://fly.io/install.sh | sh
```

#### Step 2: Authenticate

```bash
flyctl auth login
```

#### Step 3: Deploy Backend

```bash
cd backend

# Initialize Fly app
flyctl launch --name hello-api-backend --region sjc

# Follow prompts, select:
# - No database
# - No Redis
# - Yes to deploy now

# Set environment variables
flyctl secrets set APP_NAME="Hello API"
flyctl secrets set APP_VERSION="1.0.0"
flyctl secrets set LOG_LEVEL="INFO"

# Get backend URL
flyctl info
```

#### Step 4: Deploy Frontend

```bash
cd ../frontend

# Initialize Fly app
flyctl launch --name hello-frontend --region sjc

# Set environment variables
flyctl secrets set NEXT_PUBLIC_API_URL="https://hello-api-backend.fly.dev"
flyctl secrets set NODE_ENV="production"
```

#### Step 5: Update Backend CORS

```bash
cd ../backend
flyctl secrets set CORS_ORIGINS="https://hello-frontend.fly.dev"
```

✅ **Done!** Deployed on Fly.io!

---

## 3. Environment Variables Setup

### Backend (.env)

Create `backend/.env` file:

```bash
# Application Configuration
APP_NAME=Hello API
APP_VERSION=1.0.0

# Server Configuration
HOST=0.0.0.0
PORT=8000

# Logging
LOG_LEVEL=INFO

# CORS (comma-separated list of allowed origins)
# For local development:
CORS_ORIGINS=http://localhost:3000,http://127.0.0.1:3000

# For production (update with your actual frontend URL):
# CORS_ORIGINS=https://your-frontend-domain.com,http://localhost:3000
```

### Frontend (.env.local for development)

Create `frontend/.env.local` file:

```bash
# API URL for local development
NEXT_PUBLIC_API_URL=http://localhost:8000
```

### Frontend (.env.production for production)

Create `frontend/.env.production` file:

```bash
# API URL for production (update with your actual backend URL)
NEXT_PUBLIC_API_URL=https://your-backend-api.com
```

---

## 4. Pre-Deployment Checklist

Before deploying to production:

- [ ] Test app locally with Docker Compose
- [ ] All tests passing (`cd backend && make test`)
- [ ] Environment variables configured correctly
- [ ] CORS origins updated for production domains
- [ ] Code pushed to GitHub/GitLab (if using git-based deployment)
- [ ] Removed any hardcoded localhost URLs
- [ ] Health check endpoints working (`/` for backend)
- [ ] API documentation accessible (`/docs`)
- [ ] `.env` files not committed to git (add to `.gitignore`)

---

## 5. Post-Deployment Testing

After deployment, verify:

### Test Backend

```bash
# Health check
curl https://your-backend-url.com/

# API endpoint
curl https://your-backend-url.com/api/hello

# API docs
# Visit: https://your-backend-url.com/docs
```

### Test Frontend

1. Visit your frontend URL
2. Check browser console (F12) for errors
3. Verify data loads from backend
4. Test on mobile devices
5. Check different browsers

### Test CORS

```bash
# From browser console on frontend domain:
fetch('https://your-backend-url.com/api/hello')
  .then(r => r.json())
  .then(console.log)
  .catch(console.error)
```

---

## 6. Common Issues & Solutions

### Issue: Frontend can't connect to backend

**Solution**:
1. Check `NEXT_PUBLIC_API_URL` is set correctly
2. Verify backend is accessible: `curl https://your-backend-url.com/`
3. Check CORS configuration in backend
4. Check browser console for CORS errors

### Issue: CORS errors in browser

**Solution**:
1. Add frontend URL to backend `CORS_ORIGINS`
2. Ensure both http:// and https:// are included if needed
3. Redeploy backend after updating CORS

### Issue: Render free tier apps sleeping

**Solution**:
1. Upgrade to paid tier ($7/month)
2. Use a cron job to ping your app every 10 minutes
3. Use a service like UptimeRobot for monitoring

### Issue: Build fails on cloud platform

**Solution**:
1. Check Dockerfile syntax
2. Verify all dependencies in `package.json` or `pyproject.toml`
3. Check build logs for specific errors
4. Test Docker build locally: `docker build -t test .`

### Issue: Environment variables not working

**Solution**:
1. Ensure `NEXT_PUBLIC_` prefix for frontend env vars
2. Redeploy after changing environment variables
3. Check platform-specific env var documentation
4. Use platform's secret management for sensitive data

---

## 7. Deployment Comparison

| Platform | Difficulty | Cost | Best For | Pros | Cons |
|----------|-----------|------|----------|------|------|
| **Render** | Easy | Free tier available | Quick projects | Easy setup, auto-deploy from Git | Free tier sleeps |
| **Railway** | Easy | $5/month credit | Microservices | Fast, great DX, databases | Limited free tier |
| **Vercel** | Easy | Free tier available | Next.js apps | Best Next.js performance | Backend needs separate hosting |
| **DigitalOcean** | Medium | $5/month per service | Balanced | Good performance, predictable pricing | No free tier |
| **AWS ECS** | Hard | Pay-as-you-go | Enterprise | Highly scalable, full control | Complex, steep learning curve |
| **Fly.io** | Medium | Free tier available | Docker apps | Fast, edge computing | Smaller community |

---

## 8. Recommended Approach

**For Development/Learning**:
- Local: Docker Compose
- Cloud: Render (easiest free option)

**For Production (Small-Medium Apps)**:
- Vercel (frontend) + Render/Railway (backend)
- Or DigitalOcean App Platform (all-in-one)

**For Production (Large/Enterprise Apps)**:
- AWS ECS/Fargate
- Or Kubernetes on any cloud provider

---

## 9. Custom Domain Setup

After deployment, you can add custom domains:

### Render
1. Go to service settings → Custom Domain
2. Add your domain
3. Update DNS records as instructed

### Vercel
```bash
vercel domains add yourdomain.com
```

### Railway
```bash
railway domain yourdomain.com
```

### Update CORS
After adding custom domain, update backend `CORS_ORIGINS` to include your new domain.

---

## 10. Monitoring & Logs

### Render
- Logs available in dashboard
- Set up email/Slack alerts

### Railway
```bash
railway logs
```

### Vercel
```bash
vercel logs
```

### General Monitoring
- Use [UptimeRobot](https://uptimerobot.com/) for uptime monitoring
- Use [Sentry](https://sentry.io/) for error tracking
- Use [LogRocket](https://logrocket.com/) for frontend monitoring

---

## 11. Continuous Deployment

Most platforms support auto-deploy from Git:

1. **Render**: Automatically deploys on push to main branch
2. **Vercel**: Automatically deploys on push (preview for branches, production for main)
3. **Railway**: Automatically deploys on push
4. **Fly.io**: Set up GitHub Actions for auto-deploy

### Example GitHub Action for Fly.io

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Fly.io

on:
  push:
    branches: [main]

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --remote-only
        working-directory: ./backend
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}

  deploy-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: superfly/flyctl-actions/setup-flyctl@master
      - run: flyctl deploy --remote-only
        working-directory: ./frontend
        env:
          FLY_API_TOKEN: ${{ secrets.FLY_API_TOKEN }}
```

---

## Need Help?

- Check platform-specific documentation
- Review logs for error messages
- Test locally first with Docker Compose
- Verify environment variables are set correctly
- Check CORS configuration

Happy deploying! 🚀

