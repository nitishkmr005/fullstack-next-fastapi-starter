# Table of Contents
- [START HERE - Deployment Guide](#start-here---deployment-guide)
- [Quick Start](#quick-start-choose-one)
  - [Option 1: Deploy Locally](#option-1-deploy-locally-1-minute)
  - [Option 2: Deploy to Cloud](#option-2-deploy-to-cloud-10-minutes)
- [Local Deployment](#local-deployment)
- [Cloud Deployment](#cloud-deployment)
  - [Render Quick Deploy](#render-quick-deploy-10-minutes)
- [Documentation](#documentation)
- [Helper Scripts](#helper-scripts)
- [Other Deployment Options](#other-deployment-options)
- [Pre-Deployment Checklist](#pre-deployment-checklist)
- [Troubleshooting](#troubleshooting)
- [What's Been Set Up](#whats-been-set-up)
- [Recommended Path](#recommended-path)
- [Next Steps](#next-steps)
- [Need Help](#need-help)

---

# 🎯 START HERE - Deployment Guide

Welcome! Your full-stack application is **100% ready for deployment**. This guide will get you started in minutes.

## ⚡ Quick Start (Choose One)

### Option 1: Deploy Locally (1 minute)
```bash
./deploy-local.sh
```
Then visit http://localhost:3000

### Option 2: Deploy to Cloud (10 minutes)
Follow the [Render Quick Guide](#render-quick-deploy-10-minutes) below

---

## 🏠 Local Deployment

### Step 1: Run the deployment script
```bash
cd /Users/nitishkumarharsoor/Documents/1.Learnings/1.Projects/4.Experiments/3.Website
./deploy-local.sh
```

### Step 2: Access your app
- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **API Docs**: http://localhost:8000/docs

### Step 3: Verify it's working
```bash
./check-deployment.sh
```

That's it! ✅

---

## ☁️ Cloud Deployment

### Render Quick Deploy (10 minutes)

**Prerequisites**: GitHub account, Render account (free)

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
   (You'll update CORS_ORIGINS after deploying frontend)
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
   (Use your backend URL from Step 2)
5. Click **"Create Web Service"**
6. **Copy your frontend URL** (e.g., `https://hello-frontend.onrender.com`)

#### Step 4: Update CORS
1. Go back to backend service settings
2. Update `CORS_ORIGINS` environment variable:
   ```
   CORS_ORIGINS=https://hello-frontend.onrender.com
   ```
3. Save and wait for redeploy

#### Step 5: Verify
```bash
./check-deployment.sh remote https://hello-api-backend.onrender.com https://hello-frontend.onrender.com
```

🎉 **Done!** Your app is live!

---

## 📚 Documentation

### Quick Reference
- **[QUICK.md](./QUICK.md)** - Quick commands and tips
- **[INDEX.md](./INDEX.md)** - Navigation guide

### Detailed Guides
- **[SUMMARY.md](./SUMMARY.md)** - Complete overview
- **[GUIDE.md](./GUIDE.md)** - All platforms (Render, Railway, Vercel, AWS, etc.)

### Project Info
- **[../../README.md](../../README.md)** - Project overview
- **[../../Quickstart.md](../../Quickstart.md)** - Local development

---

## 🛠️ Helper Scripts

```bash
# Deploy locally
./deploy-local.sh

# Check if deployment is working
./check-deployment.sh                    # Local
./check-deployment.sh remote <urls>      # Remote

# Pre-deployment verification
./deploy-check.sh

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

---

## 🌐 Other Deployment Options

Your app can be deployed to many platforms. See [GUIDE.md](./GUIDE.md) for:

- **Railway** - 5 minutes, $5/mo credit
- **Vercel + Render** - Best Next.js performance
- **DigitalOcean** - $10/mo, managed platform
- **Fly.io** - Docker-focused, edge computing
- **AWS ECS** - Enterprise-grade, scalable

---

## 🔍 Pre-Deployment Checklist

Run this before deploying to production:

```bash
./deploy-check.sh
```

This verifies:
- ✅ Docker is running
- ✅ All files exist
- ✅ Builds succeed
- ✅ Tests pass
- ✅ No sensitive data in git

---

## 🐛 Troubleshooting

### Frontend can't connect to backend
1. Check `NEXT_PUBLIC_API_URL` is set correctly
2. Verify backend is accessible
3. Update CORS configuration

### CORS errors
1. Add frontend URL to backend `CORS_ORIGINS`
2. Redeploy backend

### Build fails
1. Check logs for errors
2. Test locally: `docker build -t test ./backend`
3. Verify dependencies

**Full troubleshooting guide**: [GUIDE.md - Troubleshooting](./GUIDE.md#common-issues--solutions)

---

## 📊 What's Been Set Up

✅ **Code Changes**
- Frontend uses environment variables for API URL
- Backend supports environment-based CORS
- Health checks configured

✅ **Docker Configuration**
- Local development: `docker-compose.yaml`
- Production: `docker-compose.prod.yaml`
- Optimized Dockerfiles for both services

✅ **Documentation**
- 6 comprehensive guides
- 3 helper scripts
- Environment variable templates

✅ **Ready for Deployment**
- All platforms supported
- Step-by-step guides
- Automated verification

---

## 🎯 Recommended Path

### First Time?
1. ✅ Deploy locally: `./deploy-local.sh`
2. ✅ Test it works: `./check-deployment.sh`
3. ✅ Deploy to Render (follow guide above)
4. ✅ Verify: `./check-deployment.sh remote <urls>`

### Production Ready?
1. ✅ Run pre-deployment check: `./deploy-check.sh`
2. ✅ Choose platform: [GUIDE.md](./GUIDE.md)
3. ✅ Follow platform guide
4. ✅ Set up monitoring
5. ✅ Configure custom domain

---

## 🚀 Next Steps

After deployment:

1. **Set up monitoring** - UptimeRobot, Sentry
2. **Add custom domain** - Use your own domain
3. **Configure CI/CD** - Automate deployments
4. **Add features** - Database, authentication, etc.
5. **Scale** - Upgrade to paid tiers as needed

---

## 📞 Need Help?

1. Check [SUMMARY.md](./SUMMARY.md)
2. Review [GUIDE.md](./GUIDE.md)
3. Check platform documentation
4. Review logs: `docker-compose logs -f`

---

## 🎉 You're All Set!

Your application is fully configured and ready to deploy!

**Choose your path:**
- 🏠 **Local**: `./deploy-local.sh`
- ☁️ **Cloud**: Follow [Render guide](#render-quick-deploy-10-minutes) above
- 📚 **Learn More**: See [INDEX.md](./INDEX.md)

Happy deploying! 🚀

---

**Quick Links:**
- [Full Deployment Guide](./GUIDE.md)
- [Quick Reference](./QUICK.md)
- [Documentation Index](./INDEX.md)
- [Project README](../../README.md)

