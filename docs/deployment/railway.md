# Table of Contents
- [Deploy to Railway](#deploy-to-railway)
- [Prerequisites](#prerequisites)
- [Step 1: Install Railway CLI](#step-1-install-railway-cli)
- [Step 2: Login and Initialize](#step-2-login-and-initialize)
- [Step 3: Deploy Backend](#step-3-deploy-backend)
- [Step 4: Deploy Frontend](#step-4-deploy-frontend)
- [Step 5: Update Backend CORS](#step-5-update-backend-cors)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Cost](#cost)
- [Next Steps](#next-steps)

---

# Deploy to Railway

**Platform**: [Railway](https://railway.app)  
**Difficulty**: ⭐ Easy  
**Cost**: $5/month credit (free to start)  
**Best for**: Fast deployments, microservices, databases  
**Time to Deploy**: ~5 minutes

## Prerequisites

- GitHub account
- Railway account (sign up at [railway.app](https://railway.app))
- Code pushed to GitHub repository

## Step 1: Install Railway CLI

### macOS
```bash
brew install railway
```

### npm (alternative, works on all platforms)
```bash
npm install -g @railway/cli
```

### Verify Installation
```bash
railway --version
```

## Step 2: Login and Initialize

### Login to Railway
```bash
railway login
```

This will open a browser window for authentication.

### Create New Project
```bash
cd /path/to/your/project
railway init
```

Follow the prompts to create a new project.

## Step 3: Deploy Backend

### Navigate to Backend Directory
```bash
cd backend
```

### Deploy Backend Service
```bash
railway up
```

Railway will:
- Detect your Dockerfile
- Build the container
- Deploy automatically

### Set Environment Variables
```bash
railway variables set APP_NAME="Hello API"
railway variables set APP_VERSION="1.0.0"
railway variables set HOST="0.0.0.0"
railway variables set PORT="8000"
railway variables set LOG_LEVEL="INFO"
```

### Get Backend URL
```bash
railway domain
```

This will generate a public URL like: `https://your-backend.railway.app`

**Copy this URL** - you'll need it for the frontend.

## Step 4: Deploy Frontend

### Navigate to Frontend Directory
```bash
cd ../frontend
```

### Create New Service in Same Project
```bash
railway up
```

### Set Environment Variables
```bash
# Use your actual backend URL from Step 3
railway variables set NEXT_PUBLIC_API_URL="https://your-backend.railway.app"
railway variables set NODE_ENV="production"
```

### Get Frontend URL
```bash
railway domain
```

This will generate a public URL like: `https://your-frontend.railway.app`

## Step 5: Update Backend CORS

Now update the backend with the frontend URL:

```bash
cd ../backend
railway variables set CORS_ORIGINS="https://your-frontend.railway.app"
```

Railway will automatically redeploy your backend.

## Verification

### Check Backend

```bash
# Test backend health
curl https://your-backend.railway.app/

# Test API endpoint
curl https://your-backend.railway.app/api/hello
```

### Check Frontend

Visit your frontend URL in a browser: `https://your-frontend.railway.app`

### Test with Script

```bash
./check-deployment.sh remote https://your-backend.railway.app https://your-frontend.railway.app
```

## Troubleshooting

### CLI Not Working

**Problem**: `railway` command not found

**Solutions**:
1. Ensure Railway CLI is installed: `railway --version`
2. Try npm installation: `npm install -g @railway/cli`
3. Restart terminal after installation

### Build Fails

**Problem**: Deployment fails during build

**Solutions**:
1. Check logs: `railway logs`
2. Verify Dockerfile is correct
3. Test build locally: `docker build -t test .`
4. Check Railway dashboard for detailed error messages

### Environment Variables Not Applied

**Problem**: Variables don't seem to work

**Solutions**:
1. List current variables: `railway variables`
2. Verify variable names (no typos)
3. Redeploy after setting variables: `railway up --detach`
4. Check Railway dashboard for variable status

### Services Can't Communicate

**Problem**: Frontend can't reach backend

**Solutions**:
1. Verify `NEXT_PUBLIC_API_URL` is set correctly
2. Check CORS_ORIGINS includes frontend URL
3. Ensure both services are in the same project
4. Check browser console for specific errors

## Cost

### Free Trial
- **Cost**: $0 to start
- **Credit**: $5 free credit (no credit card required)
- **Features**: Full platform access
- **Usage**: Pay-as-you-go after credit runs out

### Pricing After Free Credit
- **Base**: $5/month minimum
- **Resource-based pricing**:
  - CPU: ~$0.000463/minute
  - Memory: ~$0.000231/GB/minute
  - Bandwidth: Free
- **Typical cost**: $10-20/month for both services
- **No sleeping**: Services always on

### Developer Plan
- **Cost**: $20/month
- **Features**:
  - $20 in included usage
  - Team collaboration
  - Priority support
  - Custom domains

## Next Steps

### View Deployment Status

```bash
# Check service status
railway status

# View logs
railway logs

# Open Railway dashboard
railway open
```

### Add Database

Railway offers managed databases:

```bash
# Add PostgreSQL
railway add --plugin postgresql

# Add Redis
railway add --plugin redis

# Add MongoDB
railway add --plugin mongodb
```

### Set Up Custom Domain

1. Go to Railway dashboard
2. Select your service
3. Click "Settings" → "Domains"
4. Add your custom domain
5. Update DNS records as instructed

```bash
# Or via CLI
railway domain add yourdomain.com
```

### Enable Auto-Deploy from GitHub

1. Go to Railway dashboard
2. Select your service
3. Click "Settings" → "Service"
4. Connect GitHub repository
5. Choose branch to deploy from

Auto-deploy will trigger on every push to the selected branch.

### Team Collaboration

```bash
# Invite team members
railway team:invite user@example.com

# List team members
railway team:list
```

## CLI Commands Reference

```bash
# Login
railway login

# Initialize project
railway init

# Deploy
railway up

# View logs
railway logs
railway logs --follow  # Stream logs

# Set variables
railway variables set KEY=value

# List variables
railway variables

# Get service URL
railway domain

# Open dashboard
railway open

# Check status
railway status

# Link to existing project
railway link <project-id>

# Unlink from project
railway unlink
```

## Useful Links

- [Railway Dashboard](https://railway.app/dashboard)
- [Railway Documentation](https://docs.railway.app/)
- [Railway CLI Reference](https://docs.railway.app/develop/cli)
- [Railway Pricing](https://railway.app/pricing)
- [Railway Status](https://status.railway.app/)

---

**Need Help?** Check the [troubleshooting section](#troubleshooting) or [Railway documentation](https://docs.railway.app/).

**✅ Your app is now live on Railway! 🚀**

