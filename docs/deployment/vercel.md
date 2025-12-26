# Table of Contents
- [Deploy to Vercel (Frontend) + Render (Backend)](#deploy-to-vercel-frontend--render-backend)
- [Prerequisites](#prerequisites)
- [Why This Combination](#why-this-combination)
- [Step 1: Deploy Backend to Render](#step-1-deploy-backend-to-render)
- [Step 2: Deploy Frontend to Vercel](#step-2-deploy-frontend-to-vercel)
- [Step 3: Update CORS](#step-3-update-cors)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)
- [Cost](#cost)
- [Next Steps](#next-steps)

---

# Deploy to Vercel (Frontend) + Render (Backend)

**Platforms**: [Vercel](https://vercel.com) + [Render](https://render.com)  
**Difficulty**: ⭐⭐ Medium  
**Cost**: Free tiers available  
**Best for**: Optimal Next.js performance, production apps  
**Time to Deploy**: ~15 minutes

## Prerequisites

- GitHub account
- Vercel account (sign up at [vercel.com](https://vercel.com))
- Render account (sign up at [render.com](https://render.com))
- Code pushed to GitHub repository

## Why This Combination

**Vercel** is optimized for Next.js applications:
- Built by the creators of Next.js
- Best-in-class performance for frontend
- Global edge network
- Automatic preview deployments
- Generous free tier

**Render** hosts the backend:
- Easy Docker deployment
- Free tier available
- Automatic HTTPS
- Simple environment variable management

## Step 1: Deploy Backend to Render

Follow the complete [Render deployment guide](./render.md) to deploy your backend.

**Quick Summary:**
1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Create new Web Service
3. Connect GitHub repo
4. Configure:
   - Root Directory: `backend`
   - Runtime: Docker
5. Add environment variables
6. Deploy and copy backend URL

**Backend URL Example**: `https://hello-api-backend.onrender.com`

## Step 2: Deploy Frontend to Vercel

### 2.1 Install Vercel CLI

```bash
npm install -g vercel
```

### 2.2 Navigate to Frontend

```bash
cd frontend
```

### 2.3 Deploy to Vercel

```bash
vercel
```

Follow the prompts:
- **Set up and deploy**: Yes
- **Which scope**: Choose your account
- **Link to existing project**: No
- **Project name**: Accept default or enter custom name
- **Directory**: `./` (current directory)
- **Override settings**: No

Vercel will:
- Build your Next.js app
- Deploy to a preview URL
- Provide you with a deployment URL

### 2.4 Set Environment Variable

```bash
vercel env add NEXT_PUBLIC_API_URL
```

When prompted:
- **Value**: Enter your backend URL (e.g., `https://hello-api-backend.onrender.com`)
- **Environments**: Select `Production` (use spacebar to select, enter to confirm)

### 2.5 Deploy to Production

```bash
vercel --prod
```

This creates a production deployment with your environment variables.

**Copy your Vercel URL** (e.g., `https://your-app.vercel.app`)

## Step 3: Update CORS

Update your backend on Render to allow requests from Vercel:

1. Go to [Render Dashboard](https://dashboard.render.com/)
2. Select your backend service (e.g., `hello-api-backend`)
3. Go to "Environment"
4. Update `CORS_ORIGINS`:
   ```
   CORS_ORIGINS=https://your-app.vercel.app
   ```
   (Replace with your actual Vercel URL)
5. Save changes (Render will auto-redeploy)

## Verification

### Check Backend

```bash
curl https://hello-api-backend.onrender.com/
curl https://hello-api-backend.onrender.com/api/hello
```

### Check Frontend

Visit your Vercel URL: `https://your-app.vercel.app`

### Test with Script

```bash
./check-deployment.sh remote https://hello-api-backend.onrender.com https://your-app.vercel.app
```

## Troubleshooting

### Environment Variable Not Working

**Problem**: Frontend can't find `NEXT_PUBLIC_API_URL`

**Solutions**:
1. Ensure variable name starts with `NEXT_PUBLIC_`
2. Redeploy after adding variables: `vercel --prod`
3. Check Vercel dashboard → Project → Settings → Environment Variables
4. Verify variable is set for "Production" environment

### CORS Errors

**Problem**: Backend blocks requests from Vercel

**Solutions**:
1. Verify CORS_ORIGINS includes your Vercel URL
2. Include both with and without `www.` if using custom domain
3. Check browser console for exact CORS error
4. Ensure Render backend has redeployed after CORS update

### Build Fails on Vercel

**Problem**: Deployment fails during build

**Solutions**:
1. Check build logs in Vercel dashboard
2. Verify `package.json` has all dependencies
3. Test build locally: `npm run build`
4. Check Next.js version compatibility

### Custom Domain Issues

**Problem**: Custom domain not working

**Solutions**:
1. Verify DNS records are correct
2. Wait for DNS propagation (up to 48 hours)
3. Check Vercel dashboard for domain status
4. Update CORS_ORIGINS to include custom domain

## Cost

### Free Tier

**Vercel:**
- **Cost**: $0/month
- **Features**:
  - 100 GB bandwidth
  - Unlimited websites
  - Automatic HTTPS
  - Global edge network
  - Preview deployments
- **Best for**: Personal projects, small apps

**Render:**
- **Cost**: $0/month
- **Features**:
  - 750 hours/month
  - Services sleep after 15 min
- **Best for**: Low-traffic backends

**Total**: Free

### Paid Tier

**Vercel Pro:**
- **Cost**: $20/month
- **Features**:
  - 1 TB bandwidth
  - Team collaboration
  - Analytics
  - Password protection
  - Priority support

**Render:**
- **Cost**: $7/month
- **Features**:
  - Always-on service
  - Better performance

**Total**: $27/month

## Next Steps

### Add Custom Domain

**On Vercel:**
```bash
vercel domains add yourdomain.com
```

Or via dashboard:
1. Project → Settings → Domains
2. Add your domain
3. Update DNS records

**On Render:**
1. Backend service → Settings → Custom Domains
2. Add your API subdomain (e.g., `api.yourdomain.com`)
3. Update DNS records

### Enable Preview Deployments

Vercel automatically creates preview deployments for:
- Pull requests
- Branch pushes

Configure in: Project → Settings → Git

### Set Up Monitoring

- **Vercel Analytics**: Built-in (Pro plan)
- **Sentry**: For error tracking
- **LogRocket**: For session replay

### Team Collaboration

**Vercel:**
```bash
vercel teams:add
vercel teams:invite user@example.com
```

Or via dashboard: Settings → Team

## CLI Commands Reference

### Vercel CLI

```bash
# Login
vercel login

# Deploy preview
vercel

# Deploy production
vercel --prod

# Add environment variable
vercel env add

# List environment variables
vercel env ls

# Remove deployment
vercel rm deployment-url

# Add domain
vercel domains add yourdomain.com

# List domains
vercel domains ls

# Open project dashboard
vercel
```

## Useful Links

### Vercel
- [Vercel Dashboard](https://vercel.com/dashboard)
- [Vercel Documentation](https://vercel.com/docs)
- [Next.js on Vercel](https://nextjs.org/docs/deployment)
- [Vercel CLI Reference](https://vercel.com/docs/cli)

### Render
- [Render Dashboard](https://dashboard.render.com/)
- [Render Documentation](https://render.com/docs)

---

**Need Help?** Check the [troubleshooting section](#troubleshooting) or platform documentation.

**✅ Your app is now live with optimal Next.js performance! 🚀**

