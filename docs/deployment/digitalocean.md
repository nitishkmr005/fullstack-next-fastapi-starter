# Table of Contents
- [Deploy to DigitalOcean App Platform](#deploy-to-digitalocean-app-platform)
- [Prerequisites](#prerequisites)
- [Step 1: Create App](#step-1-create-app)
- [Step 2: Configure Services](#step-2-configure-services)
- [Step 3: Deploy](#step-3-deploy)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Cost](#cost)
- [Next Steps](#next-steps)

---

# Deploy to DigitalOcean App Platform

**Platform**: [DigitalOcean App Platform](https://www.digitalocean.com/products/app-platform)  
**Difficulty**: ⭐⭐ Medium  
**Cost**: $10/month (no free tier)  
**Best for**: Simple deployments with managed infrastructure  
**Time to Deploy**: ~15 minutes

## Prerequisites

- GitHub account
- DigitalOcean account (sign up at [digitalocean.com](https://www.digitalocean.com))
- Code pushed to GitHub repository
- Credit card required (no free tier, but $200 credit for new accounts available)

## Step 1: Create App

1. Go to [DigitalOcean App Platform](https://cloud.digitalocean.com/apps)
2. Click **"Create App"**
3. Choose **"GitHub"** as source
4. Authorize DigitalOcean to access your GitHub
5. Select your repository
6. DigitalOcean will auto-detect both services

## Step 2: Configure Services

### Backend Service Configuration

DigitalOcean should auto-detect the backend. Configure:

**Resource Type**: Web Service  
**Source Directory**: `backend`  
**Dockerfile Path**: `backend/Dockerfile`  
**HTTP Port**: `8000`  

**Environment Variables**:
```
APP_NAME=Hello API
APP_VERSION=1.0.0
HOST=0.0.0.0
PORT=8000
LOG_LEVEL=INFO
CORS_ORIGINS=${frontend.PUBLIC_URL}
```

**Note**: `${frontend.PUBLIC_URL}` is a DigitalOcean variable that references your frontend URL.

**Instance Size**: Basic ($5/month)

### Frontend Service Configuration

Configure the frontend:

**Resource Type**: Web Service  
**Source Directory**: `frontend`  
**Dockerfile Path**: `frontend/Dockerfile`  
**HTTP Port**: `3000`  

**Environment Variables**:
```
NEXT_PUBLIC_API_URL=${backend.PUBLIC_URL}
NODE_ENV=production
```

**Note**: `${backend.PUBLIC_URL}` references your backend URL automatically.

**Instance Size**: Basic ($5/month)

## Step 3: Deploy

1. Review your configuration
2. Click **"Next"** → **"Create Resources"**
3. Wait for deployment (5-10 minutes)
4. Both services will deploy simultaneously

Once deployed, DigitalOcean provides:
- Backend URL: `https://your-app-backend-xxxxx.ondigitalocean.app`
- Frontend URL: `https://your-app-xxxxx.ondigitalocean.app`

## Verification

### Check Backend

```bash
curl https://your-app-backend-xxxxx.ondigitalocean.app/
curl https://your-app-backend-xxxxx.ondigitalocean.app/api/hello
```

### Check Frontend

Visit your frontend URL in a browser.

### Test with Script

```bash
./check-deployment.sh remote <backend-url> <frontend-url>
```

## Troubleshooting

### Build Fails

**Solutions**:
1. Check build logs in DigitalOcean dashboard
2. Verify Dockerfile paths are correct
3. Test builds locally with Docker
4. Check resource limits

### Environment Variables Not Working

**Solutions**:
1. Verify variable references like `${backend.PUBLIC_URL}`
2. Redeploy after changing variables
3. Check component names match references

### Services Can't Communicate

**Solutions**:
1. Verify environment variable references
2. Check CORS configuration
3. Ensure both services are in same app

## Cost

### Pricing

**Basic Plan** (most common):
- **Backend**: $5/month
- **Frontend**: $5/month
- **Total**: $10/month

**Professional Plan**:
- **Backend**: $12/month
- **Frontend**: $12/month
- **Total**: $24/month
- **Features**: More CPU/RAM, autoscaling

### Additional Costs

- **Bandwidth**: Free up to limits
- **Databases**: From $15/month (if added)
- **Domains**: Free custom domains

### New Account Credit

DigitalOcean often offers $200 credit for 60 days for new accounts.

## Next Steps

### Add Custom Domain

1. Go to your app in DigitalOcean dashboard
2. Click **"Settings"** → **"Domains"**
3. Add your domain
4. Update DNS records:
   ```
   Type: CNAME
   Name: www (or @)
   Value: your-app.ondigitalocean.app
   ```
5. Update CORS_ORIGINS if needed

### Set Up Alerts

1. Go to **"Settings"** → **"Alerts"**
2. Configure:
   - CPU usage alerts
   - Memory usage alerts
   - HTTP error rate alerts
3. Add email/Slack notifications

### Enable Auto-Deploy

Auto-deploy is enabled by default:
- Pushes to main branch trigger deployments
- Pull requests create preview deployments

To configure:
1. Go to **"Settings"** → **"App-Level"**
2. Choose deployment branch
3. Enable/disable auto-deploy

### Add Database

DigitalOcean offers managed databases:

1. Go to **"Create"** → **"Databases"**
2. Choose:
   - PostgreSQL
   - MySQL
   - MongoDB
   - Redis
3. Select plan (starts at $15/month)
4. Connect to your app via environment variables

### Scale Your App

**Manual Scaling**:
1. Go to component settings
2. Change instance size
3. Save and redeploy

**Auto-Scaling** (Professional plan):
1. Enable auto-scaling
2. Set min/max instances
3. Configure scaling rules

### View Logs

```bash
# Real-time logs in dashboard
# Or use doctl CLI

# Install doctl
brew install doctl

# Authenticate
doctl auth init

# View logs
doctl apps logs <app-id> --type run --follow
```

## CLI Commands (doctl)

```bash
# Install
brew install doctl  # macOS
snap install doctl  # Linux

# Authenticate
doctl auth init

# List apps
doctl apps list

# Get app info
doctl apps get <app-id>

# View logs
doctl apps logs <app-id>

# Create app from spec
doctl apps create --spec app.yaml

# Update app
doctl apps update <app-id> --spec app.yaml
```

## Useful Links

- [DigitalOcean Dashboard](https://cloud.digitalocean.com/)
- [App Platform Documentation](https://docs.digitalocean.com/products/app-platform/)
- [doctl CLI Documentation](https://docs.digitalocean.com/reference/doctl/)
- [Pricing Calculator](https://www.digitalocean.com/pricing/calculator)
- [DigitalOcean Status](https://status.digitalocean.com/)

---

**Need Help?** Check the [troubleshooting section](#troubleshooting) or [DigitalOcean documentation](https://docs.digitalocean.com/products/app-platform/).

**✅ Your app is now live on DigitalOcean! 🚀**

