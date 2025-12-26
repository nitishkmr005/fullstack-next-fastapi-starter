# Table of Contents
- [Deploy to Render](#deploy-to-render)
- [Prerequisites](#prerequisites)
- [Step 1: Prepare Your Code](#step-1-prepare-your-code)
- [Step 2: Deploy Backend](#step-2-deploy-backend)
- [Step 3: Deploy Frontend](#step-3-deploy-frontend)
- [Step 4: Update CORS](#step-4-update-cors)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Cost](#cost)
- [Next Steps](#next-steps)

---

# Deploy to Render

**Platform**: [Render](https://render.com)  
**Difficulty**: ⭐ Easy  
**Cost**: Free tier available  
**Best for**: Quick deployments, side projects, prototypes  
**Time to Deploy**: ~10 minutes

## Prerequisites

- GitHub account
- Render account (sign up at [render.com](https://render.com))
- Code pushed to GitHub repository

## Step 1: Prepare Your Code

Push your code to GitHub if not already done:

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/yourusername/your-repo.git
git push -u origin main
```

## Step 2: Deploy Backend

### 2.1 Create Web Service

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Click **"New +"** → **"Web Service"**
3. Connect your GitHub repository
4. Select your repository from the list

### 2.2 Configure Backend Service

Configure the following settings:

- **Name**: `hello-api-backend` (or your preferred name)
- **Region**: Choose closest to your users (e.g., Oregon, Frankfurt)
- **Branch**: `main`
- **Root Directory**: `backend`
- **Runtime**: `Docker`
- **Instance Type**: `Free` (or paid for better performance)

### 2.3 Add Environment Variables

Click on "Advanced" and add the following environment variables:

```
APP_NAME=Hello API
APP_VERSION=1.0.0
HOST=0.0.0.0
PORT=8000
LOG_LEVEL=INFO
CORS_ORIGINS=https://your-frontend-url.onrender.com
```

**Note**: You'll update `CORS_ORIGINS` after deploying the frontend in Step 4.

### 2.4 Create Service

1. Click **"Create Web Service"**
2. Wait for deployment (5-10 minutes)
3. Once deployed, **copy your backend URL**
   - Example: `https://hello-api-backend.onrender.com`
   - You'll need this for the frontend deployment

## Step 3: Deploy Frontend

### 3.1 Create Another Web Service

1. Click **"New +"** → **"Web Service"** again
2. Select the same repository

### 3.2 Configure Frontend Service

Configure the following settings:

- **Name**: `hello-frontend` (or your preferred name)
- **Region**: Same as backend for better performance
- **Branch**: `main`
- **Root Directory**: `frontend`
- **Runtime**: `Docker`
- **Instance Type**: `Free`

### 3.3 Add Environment Variables

Click on "Advanced" and add:

```
NEXT_PUBLIC_API_URL=https://hello-api-backend.onrender.com
NODE_ENV=production
```

**Important**: Use your actual backend URL from Step 2.4!

### 3.4 Create Service

1. Click **"Create Web Service"**
2. Wait for deployment (5-10 minutes)
3. Once deployed, **copy your frontend URL**
   - Example: `https://hello-frontend.onrender.com`

## Step 4: Update CORS

Now that you have both URLs, update the backend CORS configuration:

1. Go to your backend service in Render dashboard
2. Click on "Environment" in the left sidebar
3. Find the `CORS_ORIGINS` environment variable
4. Update it with your actual frontend URL:
   ```
   CORS_ORIGINS=https://hello-frontend.onrender.com
   ```
5. Click "Save Changes"
6. Render will automatically redeploy your backend

## Verification

### Check Backend

1. Visit your backend URL: `https://hello-api-backend.onrender.com`
2. You should see a health check response
3. Visit API docs: `https://hello-api-backend.onrender.com/docs`

### Check Frontend

1. Visit your frontend URL: `https://hello-frontend.onrender.com`
2. The app should load and display data from the backend
3. Open browser console (F12) to check for errors

### Test with Script

```bash
./check-deployment.sh remote https://hello-api-backend.onrender.com https://hello-frontend.onrender.com
```

## Troubleshooting

### Frontend Can't Connect to Backend

**Problem**: Frontend shows "Failed to fetch data from API"

**Solutions**:
1. Verify `NEXT_PUBLIC_API_URL` is set correctly in frontend environment variables
2. Check backend is accessible by visiting the URL directly
3. Verify CORS_ORIGINS includes your frontend URL
4. Check browser console for specific error messages

### Services Sleeping (Free Tier)

**Problem**: First request after inactivity is very slow

**Explanation**: Free tier services sleep after 15 minutes of inactivity

**Solutions**:
1. Upgrade to paid tier ($7/month per service)
2. Use a service like [UptimeRobot](https://uptimerobot.com/) to ping your app every 10 minutes
3. Accept the cold start delay for free hosting

### Build Fails

**Problem**: Deployment fails during build

**Solutions**:
1. Check build logs in Render dashboard
2. Verify Dockerfile syntax is correct
3. Test build locally: `docker build -t test ./backend`
4. Ensure all dependencies are in `package.json` or `pyproject.toml`

### Environment Variables Not Working

**Problem**: App doesn't use configured environment variables

**Solutions**:
1. Ensure variables are saved in Render dashboard
2. Service needs to redeploy after env var changes
3. For frontend, variable names must start with `NEXT_PUBLIC_`
4. Check for typos in variable names

## Cost

### Free Tier
- **Cost**: $0/month
- **Features**:
  - 750 hours/month of free usage
  - Services sleep after 15 minutes of inactivity
  - Shared CPU and memory
  - Cold starts on first request
- **Best for**: Personal projects, prototypes, learning

### Paid Tier
- **Cost**: $7/month per service ($14 total for frontend + backend)
- **Features**:
  - Always-on services (no sleeping)
  - Faster performance
  - More CPU and memory
  - Custom domains
  - Auto-scaling available
- **Best for**: Production apps, client projects

## Next Steps

### Add Custom Domain

1. Go to your service settings in Render
2. Click "Custom Domains"
3. Add your domain name
4. Update DNS records as instructed by Render
5. Update CORS_ORIGINS to include custom domain

### Set Up Monitoring

- **Uptime Monitoring**: [UptimeRobot](https://uptimerobot.com/)
- **Error Tracking**: [Sentry](https://sentry.io/)
- **Logs**: Available in Render dashboard

### Enable Auto-Deploy

Render automatically deploys on git push to main branch by default.

To disable:
1. Go to service settings
2. Scroll to "Auto-Deploy"
3. Toggle off if you want manual deployments

### Add Database (Optional)

Render offers managed databases:
1. PostgreSQL
2. Redis
3. MongoDB (via partner)

See Render documentation for database setup.

---

## Quick Reference

```bash
# Check deployment status
./check-deployment.sh remote <backend-url> <frontend-url>

# View service logs in terminal
# Not directly available - use Render dashboard

# Redeploy manually
# Go to service → Manual Deploy → Deploy latest commit
```

## Useful Links

- [Render Dashboard](https://dashboard.render.com/)
- [Render Documentation](https://render.com/docs)
- [Render Pricing](https://render.com/pricing)
- [Render Status Page](https://status.render.com/)

---

**Need Help?** Check the [troubleshooting section](#troubleshooting) or [Render documentation](https://render.com/docs).

**✅ Your app is now live on Render! 🚀**

