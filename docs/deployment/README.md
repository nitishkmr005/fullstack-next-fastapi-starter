# Table of Contents
- [Deployment Guide](#deployment-guide)
- [Quick Start](#quick-start)
  - [Local Deployment](#local-deployment-1-minute)
  - [Cloud Deployment](#cloud-deployment-render-10-minutes)
- [Platform Guides](#platform-guides)
- [Platform Comparison](#platform-comparison)
- [Pre-Deployment](#pre-deployment)
- [Post-Deployment](#post-deployment)
- [Troubleshooting](#troubleshooting)
- [Helper Scripts](#helper-scripts)

---

# Deployment Guide

Welcome! Your full-stack application is **100% ready for deployment**. This guide will help you deploy in minutes.

## Quick Start

### Local Deployment (1 minute)

Deploy and test locally with Docker:

```bash
./deploy-local.sh
```

**Access your app:**
- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs

**Verify deployment:**
```bash
./check-deployment.sh
```

**Complete guide:** [local.md](./local.md)

---

### Cloud Deployment: Render (10 minutes)

**Easiest platform for beginners** - Free tier, no credit card required.

#### Step 1: Push to GitHub

```bash
git init
git add .
git commit -m "Ready for deployment"
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main
```

#### Step 2: Deploy Backend

1. Go to [render.com](https://render.com) and sign up
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Configure:
   - **Name**: `hello-api-backend`
   - **Root Directory**: `backend`
   - **Runtime**: `Docker`
   - **Instance Type**: `Free`
5. Add Environment Variables:
   ```
   APP_NAME=Hello API
   APP_VERSION=1.0.0
   HOST=0.0.0.0
   PORT=8000
   LOG_LEVEL=INFO
   CORS_ORIGINS=https://your-frontend-url.onrender.com
   ```
6. Click **"Create Web Service"**
7. **Copy your backend URL** (e.g., `https://hello-api-backend.onrender.com`)

#### Step 3: Deploy Frontend

1. Click **"New +"** → **"Web Service"** again
2. Select same repository
3. Configure:
   - **Name**: `hello-frontend`
   - **Root Directory**: `frontend`
   - **Runtime**: `Docker`
   - **Instance Type**: `Free`
4. Add Environment Variables:
   ```
   NEXT_PUBLIC_API_URL=https://hello-api-backend.onrender.com
   NODE_ENV=production
   ```
5. Click **"Create Web Service"**
6. **Copy your frontend URL** (e.g., `https://hello-frontend.onrender.com`)

#### Step 4: Update CORS

1. Go back to backend service settings
2. Update `CORS_ORIGINS` environment variable:
   ```
   CORS_ORIGINS=https://hello-frontend.onrender.com
   ```
3. Save (Render will auto-redeploy)

#### Step 5: Verify

```bash
./check-deployment.sh remote https://hello-api-backend.onrender.com https://hello-frontend.onrender.com
```

🎉 **Done!** Your app is live on Render!

**Complete Render guide:** [render.md](./render.md)

---

## Platform Guides

Choose the platform that best fits your needs:

### 🚀 [Render](./render.md)
**Best for beginners**
- ⭐ Difficulty: Easy
- 💰 Cost: Free tier available
- ⏱️ Time: ~10 minutes
- ✨ Features:
  - No credit card required for free tier
  - Automatic HTTPS and deployments
  - Simple dashboard interface
  - Services sleep after 15 min (free tier)

**When to choose**: First deployment, learning, side projects

---

### 🚂 [Railway](./railway.md)
**Fast and developer-friendly**
- ⭐ Difficulty: Easy
- 💰 Cost: $5 free credit
- ⏱️ Time: ~5 minutes
- ✨ Features:
  - Excellent CLI and dashboard
  - Great for databases
  - No sleeping (always on)
  - Fast deployments

**When to choose**: Need databases, prefer CLI, microservices

---

### ▲ [Vercel + Render](./vercel.md)
**Optimal Next.js performance**
- ⭐⭐ Difficulty: Medium
- 💰 Cost: Free tiers available
- ⏱️ Time: ~15 minutes
- ✨ Features:
  - Best Next.js performance
  - Global edge network
  - Automatic preview deployments
  - Built by Next.js creators

**When to choose**: Production apps, need best performance

---

### 🌊 [DigitalOcean](./digitalocean.md)
**Balanced and predictable**
- ⭐⭐ Difficulty: Medium
- 💰 Cost: $10/month (no free tier)
- ⏱️ Time: ~15 minutes
- ✨ Features:
  - Simple managed platform
  - Predictable pricing
  - Good documentation
  - Auto-scaling available

**When to choose**: Want managed infrastructure, predictable costs

---

### 🪰 [Fly.io](./flyio.md)
**Docker-focused with edge computing**
- ⭐⭐ Difficulty: Medium
- 💰 Cost: Free tier available
- ⏱️ Time: ~10 minutes
- ✨ Features:
  - Excellent for Docker apps
  - Edge computing capabilities
  - Fast cold starts
  - Global distribution

**When to choose**: Docker apps, global distribution, edge computing

---

### 💻 [Local Deployment](./local.md)
**Development and testing**
- ⭐ Difficulty: Easy
- 💰 Cost: Free
- ⏱️ Time: 1-5 minutes
- ✨ Features:
  - One-command deployment
  - Hot reload for development
  - No external dependencies
  - Perfect for testing

**When to choose**: Development, testing, learning

---

## Platform Comparison

### Cost Comparison (Monthly)

| Platform | Free Tier | Paid Tier | Database | Total (Paid) |
|----------|-----------|-----------|----------|--------------|
| **Render** | ✅ Free (sleeps) | $7/service | Add-on | $14/mo |
| **Railway** | $5 credit | Usage-based | Included | $10-20/mo |
| **Vercel + Render** | ✅ Both free | $20 + $7 | Add-on | $27/mo |
| **DigitalOcean** | ❌ None | $5/service | $15/mo | $25/mo |
| **Fly.io** | ✅ Free tier | Usage-based | Add-on | $5-10/mo |
| **Local** | ✅ Free | - | - | Free |

### Feature Comparison

| Feature | Render | Railway | Vercel | DigitalOcean | Fly.io | Local |
|---------|--------|---------|--------|--------------|--------|-------|
| **Free Tier** | ✅ | ✅ | ✅ | ❌ | ✅ | ✅ |
| **Auto-Deploy** | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Custom Domains** | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| **Databases** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ |
| **CLI Tool** | ❌ | ✅ | ✅ | ✅ | ✅ | ✅ |
| **Edge Network** | ❌ | ❌ | ✅ | ❌ | ✅ | ❌ |
| **Docker Support** | ✅ | ✅ | ❌ | ✅ | ✅ | ✅ |
| **Always On** | Paid | ✅ | ✅ | ✅ | ✅ | ✅ |

### Best Platform For...

- **First deployment**: Render (easiest, free)
- **Speed**: Railway (fastest deployment)
- **Next.js optimization**: Vercel
- **Databases**: Railway or DigitalOcean
- **Docker apps**: Fly.io
- **Predictable costs**: DigitalOcean
- **Edge computing**: Fly.io or Vercel
- **Development**: Local

## Pre-Deployment

### 1. Test Locally First

Always test locally before deploying to cloud:

```bash
# Deploy locally
./deploy-local.sh

# Verify everything works
./check-deployment.sh
```

See [local.md](./local.md) for complete guide.

### 2. Run Pre-Deployment Checks

```bash
./deploy-check.sh
```

This verifies:
- ✅ Docker is running
- ✅ Dockerfiles exist
- ✅ Docker builds succeed
- ✅ Backend tests pass
- ✅ .gitignore is configured
- ✅ No sensitive files in git

### 3. Prepare Your Code

```bash
# Check git status
git status

# Commit all changes
git add .
git commit -m "Ready for deployment"

# Push to GitHub (required for most platforms)
git push origin main
```

## Post-Deployment

### 1. Verify Deployment

**Test Backend:**
```bash
curl https://your-backend-url.com/
curl https://your-backend-url.com/api/hello
```

**Test Frontend:**
- Visit your frontend URL in browser
- Check data loads from backend
- Open browser console (F12) - verify no errors
- Test on mobile device

**Use helper script:**
```bash
./check-deployment.sh remote <backend-url> <frontend-url>
```

### 2. Set Up Monitoring

**Uptime Monitoring:**
- [UptimeRobot](https://uptimerobot.com/) - Free, monitors uptime
- [Pingdom](https://www.pingdom.com/) - Advanced monitoring

**Error Tracking:**
- [Sentry](https://sentry.io/) - Free tier, tracks errors
- [Rollbar](https://rollbar.com/) - Error tracking & analysis

**Logging:**
- Platform-specific dashboards
- [Papertrail](https://www.papertrail.com/) - Log aggregation

### 3. Add Custom Domain

Most platforms support custom domains:

1. Go to platform dashboard
2. Add custom domain (e.g., `yourdomain.com`)
3. Update DNS records as instructed
4. Update `CORS_ORIGINS` to include new domain

See individual platform guides for specific instructions.

### 4. Enable Auto-Deploy

Most platforms auto-deploy by default when you push to main branch.

**Configure:**
- Branch to deploy from (usually `main`)
- Enable/disable preview deployments
- Set deployment notifications

## Troubleshooting

### Frontend Can't Connect to Backend

**Symptoms:**
- "Failed to fetch data from API" error
- CORS errors in browser console

**Solutions:**
1. Verify `NEXT_PUBLIC_API_URL` is set correctly
2. Check backend is accessible: `curl https://your-backend-url.com/`
3. Verify CORS_ORIGINS includes your frontend URL
4. Check browser console (F12) for specific errors

### Build Fails

**Symptoms:**
- Deployment fails during build phase

**Solutions:**
1. Check platform logs for specific error
2. Test build locally: `docker build -t test ./backend`
3. Verify all dependencies in `package.json` or `pyproject.toml`
4. Check Docker available memory/resources

### Environment Variables Not Working

**Symptoms:**
- App uses default values instead of configured ones

**Solutions:**
1. Ensure `NEXT_PUBLIC_` prefix for frontend variables
2. Redeploy after changing environment variables
3. Verify variable names (case-sensitive)
4. Check platform-specific env var documentation

### Services Sleeping (Free Tier)

**Symptoms:**
- First request after inactivity is very slow

**Solutions:**
1. Upgrade to paid tier (usually $7-14/month)
2. Use uptime monitoring to ping every 10 minutes
3. Accept cold start delay for free hosting

## Helper Scripts

All scripts are in the project root:

### Deploy Locally
```bash
./deploy-local.sh
```
One-command local deployment with health checks.

### Check Deployment Status
```bash
# Local
./check-deployment.sh

# Remote
./check-deployment.sh remote <backend-url> <frontend-url>
```
Verifies backend and frontend are accessible.

### Pre-Deployment Checks
```bash
./deploy-check.sh
```
Runs comprehensive pre-deployment verification.

### Docker Commands
```bash
# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and restart
docker-compose up --build
```

## Next Steps

After successful deployment:

1. **Set up monitoring** - Track uptime and errors
2. **Add custom domain** - Use your own domain name
3. **Configure CI/CD** - Automate deployments
4. **Add database** - PostgreSQL, MongoDB, Redis
5. **Implement authentication** - User login/signup
6. **Scale as needed** - Upgrade plans for more traffic
7. **Add more features** - Expand your application

---

## Quick Reference

**Deploy Locally:**
```bash
./deploy-local.sh
```

**Deploy to Render (Easiest):**
1. Push code to GitHub
2. Connect repo on Render
3. Deploy backend → Copy URL
4. Deploy frontend with backend URL
5. Update backend CORS

**Check Deployment:**
```bash
./check-deployment.sh remote <backend-url> <frontend-url>
```

**Platform Guides:**
- [render.md](./render.md) - Easiest (free tier)
- [railway.md](./railway.md) - Fast (CLI-based)
- [vercel.md](./vercel.md) - Best Next.js performance
- [digitalocean.md](./digitalocean.md) - Managed platform
- [flyio.md](./flyio.md) - Edge computing
- [local.md](./local.md) - Local Docker

---

**Need help?** Check individual platform guides for detailed troubleshooting.

**Ready to deploy?** Start with [Render](#cloud-deployment-render-10-minutes) or [Local](#local-deployment-1-minute)! 🚀
