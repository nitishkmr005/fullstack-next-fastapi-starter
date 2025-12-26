# Table of Contents
- [Deploy to Fly.io](#deploy-to-flyio)
- [Prerequisites](#prerequisites)
- [Step 1: Install Fly CLI](#step-1-install-fly-cli)
- [Step 2: Authenticate](#step-2-authenticate)
- [Step 3: Deploy Backend](#step-3-deploy-backend)
- [Step 4: Deploy Frontend](#step-4-deploy-frontend)
- [Step 5: Update CORS](#step-5-update-cors)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Cost](#cost)
- [Next Steps](#next-steps)

---

# Deploy to Fly.io

**Platform**: [Fly.io](https://fly.io)  
**Difficulty**: ⭐⭐ Medium  
**Cost**: Free tier available  
**Best for**: Docker applications, edge computing, fast cold starts  
**Time to Deploy**: ~10 minutes

## Prerequisites

- Fly.io account (sign up at [fly.io](https://fly.io))
- Code pushed to GitHub (optional, can deploy locally)
- Credit card required for validation (free tier available)

## Step 1: Install Fly CLI

### macOS
```bash
brew install flyctl
```

### Linux/WSL
```bash
curl -L https://fly.io/install.sh | sh
```

### Windows (PowerShell)
```powershell
iwr https://fly.io/install.ps1 -useb | iex
```

### Verify Installation
```bash
flyctl version
```

## Step 2: Authenticate

```bash
flyctl auth login
```

This opens a browser window for authentication.

## Step 3: Deploy Backend

### Navigate to Backend
```bash
cd backend
```

### Initialize Fly App
```bash
flyctl launch --name hello-api-backend --region sjc
```

**Options**:
- `--name`: Your app name (must be unique globally)
- `--region`: Choose closest region (sjc=San Jose, lhr=London, etc.)

When prompted:
- **Would you like to set up a Postgresql database?**: No
- **Would you like to set up an Upstash Redis database?**: No
- **Would you like to deploy now?**: Yes

Fly.io will:
- Detect your Dockerfile
- Create `fly.toml` configuration
- Build and deploy

### Set Environment Variables
```bash
flyctl secrets set APP_NAME="Hello API"
flyctl secrets set APP_VERSION="1.0.0"
flyctl secrets set LOG_LEVEL="INFO"
```

### Get Backend URL
```bash
flyctl info
```

Look for the "Hostname" field: `hello-api-backend.fly.dev`

**Copy this URL** for the frontend configuration.

## Step 4: Deploy Frontend

### Navigate to Frontend
```bash
cd ../frontend
```

### Initialize Fly App
```bash
flyctl launch --name hello-frontend --region sjc
```

Use the same region as the backend for better performance.

### Set Environment Variables
```bash
flyctl secrets set NEXT_PUBLIC_API_URL="https://hello-api-backend.fly.dev"
flyctl secrets set NODE_ENV="production"
```

### Get Frontend URL
```bash
flyctl info
```

Hostname: `hello-frontend.fly.dev`

## Step 5: Update CORS

Update backend with frontend URL:

```bash
cd ../backend
flyctl secrets set CORS_ORIGINS="https://hello-frontend.fly.dev"
```

Fly.io will automatically redeploy the backend.

## Verification

### Check Backend

```bash
curl https://hello-api-backend.fly.dev/
curl https://hello-api-backend.fly.dev/api/hello
```

### Check Frontend

Visit: `https://hello-frontend.fly.dev`

### Test with Script

```bash
./check-deployment.sh remote https://hello-api-backend.fly.dev https://hello-frontend.fly.dev
```

## Troubleshooting

### App Name Already Taken

**Problem**: Name is globally unique and already exists

**Solution**:
```bash
flyctl launch --name your-unique-name-12345 --region sjc
```

### Build Fails

**Solutions**:
1. Check logs: `flyctl logs`
2. Test Docker build locally
3. Verify Dockerfile syntax
4. Check fly.toml configuration

### Secrets Not Working

**Solutions**:
1. List secrets: `flyctl secrets list`
2. Verify secret names (case-sensitive)
3. Redeploy after setting secrets
4. Check app logs for issues

### App Not Responding

**Solutions**:
1. Check app status: `flyctl status`
2. View logs: `flyctl logs`
3. Ensure app is scaled up: `flyctl scale count 1`
4. Check region availability: `flyctl platform regions`

## Cost

### Free Tier

**Included Free**:
- Up to 3 shared-cpu-1x 256mb VMs
- 160GB outbound data transfer
- No credit card required for free tier

**Perfect for**:
- Small apps
- Personal projects
- Testing/staging

### Paid Usage

**Resource Pricing**:
- **CPU**: ~$0.0000022/sec
- **Memory**: ~$0.0000001/MB/sec
- **Bandwidth**: $0.02/GB after free tier

**Example Monthly Cost**:
- Small app: $5-10/month
- Medium app: $20-30/month

### Calculator

Use [Fly.io pricing calculator](https://fly.io/docs/about/pricing/) to estimate costs.

## Next Steps

### Add Custom Domain

```bash
# Add domain
flyctl certs add yourdomain.com

# Check certificate status
flyctl certs show yourdomain.com
```

Update DNS:
```
Type: A
Name: @
Value: (IP from flyctl ips list)

Type: AAAA
Name: @
Value: (IPv6 from flyctl ips list)
```

### Scale Your App

```bash
# Scale to 2 instances
flyctl scale count 2

# Scale VM size
flyctl scale vm shared-cpu-2x

# Scale memory
flyctl scale memory 512
```

### Add Persistent Storage

```bash
# Create volume
flyctl volumes create data --size 10

# Update fly.toml
[mounts]
  source = "data"
  destination = "/data"
```

### Set Up Auto-Deploy

Create `.github/workflows/fly.yml`:

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

Get API token: `flyctl auth token`

### View Metrics

```bash
# App status
flyctl status

# Real-time logs
flyctl logs

# App dashboard
flyctl dashboard
```

## CLI Commands Reference

```bash
# Deploy
flyctl deploy

# View logs
flyctl logs
flyctl logs --follow  # Stream logs

# App info
flyctl info
flyctl status

# List apps
flyctl apps list

# Set secrets
flyctl secrets set KEY=value

# List secrets
flyctl secrets list

# Scale
flyctl scale count 2
flyctl scale vm shared-cpu-2x
flyctl scale memory 512

# SSH into app
flyctl ssh console

# Open dashboard
flyctl dashboard

# Destroy app
flyctl apps destroy app-name
```

## Useful Links

- [Fly.io Dashboard](https://fly.io/dashboard)
- [Fly.io Documentation](https://fly.io/docs/)
- [CLI Reference](https://fly.io/docs/flyctl/)
- [Pricing](https://fly.io/docs/about/pricing/)
- [Status Page](https://status.flyio.net/)
- [Regions List](https://fly.io/docs/reference/regions/)

---

**Need Help?** Check the [troubleshooting section](#troubleshooting) or [Fly.io documentation](https://fly.io/docs/).

**✅ Your app is now live on Fly.io! 🚀**

