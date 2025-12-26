# Table of Contents
- [Deployment Documentation Index](#deployment-documentation-index)
- [Getting Started](#getting-started)
- [Detailed Guides](#detailed-guides)
- [Helper Scripts](#helper-scripts)
- [Configuration Files](#configuration-files)
- [Quick Commands Reference](#quick-commands-reference)
- [Platform-Specific Guides](#platform-specific-guides)
- [Troubleshooting](#troubleshooting)
- [Deployment Workflow](#deployment-workflow)
- [Learning Path](#learning-path)
- [Security Checklist](#security-checklist)
- [Quick Links](#quick-links)
- [Recommended Reading Order](#recommended-reading-order)

---

# 📚 Deployment Documentation Index

Quick navigation to all deployment resources.

## 🚀 Getting Started

| Document | Purpose | Time to Read |
|----------|---------|--------------|
| **[SUMMARY.md](./SUMMARY.md)** | Start here! Overview of everything | 5 min |
| **[QUICK.md](./QUICK.md)** | Quick reference for common tasks | 2 min |
| **[Quickstart.md](../../Quickstart.md)** | Get running locally in 5 minutes | 5 min |

## 📖 Detailed Guides

| Document | Purpose | Time to Read |
|----------|---------|--------------|
| **[GUIDE.md](./GUIDE.md)** | Complete deployment guide (all platforms) | 20 min |
| **[README.md](../../README.md)** | Project overview and features | 10 min |

## 🛠️ Helper Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| **[deploy-local.sh](./deploy-local.sh)** | Deploy locally with Docker | `./deploy-local.sh` |
| **[deploy-check.sh](./deploy-check.sh)** | Pre-deployment verification | `./deploy-check.sh` |
| **[check-deployment.sh](./check-deployment.sh)** | Check deployment status | `./check-deployment.sh` |

## 📋 Configuration Files

### Docker
- **[docker-compose.yaml](./docker-compose.yaml)** - Local development
- **[docker-compose.prod.yaml](./docker-compose.prod.yaml)** - Production deployment
- **[backend/Dockerfile](./backend/Dockerfile)** - Backend container
- **[frontend/Dockerfile](./frontend/Dockerfile)** - Frontend container

### Environment Variables
- **[env.example](./env.example)** - Root environment variables
- **[backend/env.example](./backend/env.example)** - Backend variables
- **[frontend/env.local.example](./frontend/env.local.example)** - Frontend dev variables
- **[frontend/env.production.example](./frontend/env.production.example)** - Frontend prod variables

## 🎯 Quick Commands Reference

### Local Deployment
```bash
# One-command deploy
./deploy-local.sh

# Check if services are running
./check-deployment.sh

# Manual Docker Compose
docker-compose up --build

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Pre-Deployment
```bash
# Run all checks before deploying
./deploy-check.sh

# Test Docker builds
docker build -t test-backend ./backend
docker build -t test-frontend ./frontend

# Run backend tests
cd backend && make test
```

### Production Deployment
```bash
# Using production Docker Compose
docker-compose -f docker-compose.prod.yaml up -d

# Check remote deployment
./check-deployment.sh remote https://api.example.com https://example.com
```

## 🌐 Platform-Specific Guides

All in [GUIDE.md](./GUIDE.md):

1. **Render** - Easiest, free tier (Section 2.A)
2. **Railway** - Fast, $5/mo credit (Section 2.B)
3. **Vercel + Render** - Best Next.js performance (Section 2.C)
4. **DigitalOcean** - Managed platform (Section 2.D)
5. **AWS ECS/Fargate** - Enterprise-grade (Section 2.E)
6. **Fly.io** - Docker-focused (Section 2.F)

## 🔍 Troubleshooting

### Common Issues
See [DEPLOYMENT.md Section 6](./DEPLOYMENT.md#6-common-issues--solutions):
- Frontend can't connect to backend
- CORS errors
- Build failures
- Environment variables not working

### Getting Help
1. Check logs: `docker-compose logs -f`
2. Verify environment variables
3. Review [SUMMARY.md](./SUMMARY.md)
4. Check platform-specific documentation

## 📊 Deployment Workflow

```
1. Local Development
   ├── ./deploy-local.sh
   └── Test at http://localhost:3000

2. Pre-Deployment
   ├── ./deploy-check.sh
   └── Fix any issues

3. Choose Platform
   ├── Render (easiest)
   ├── Railway (fast)
   ├── Vercel + Render (best performance)
   └── Others (see DEPLOYMENT.md)

4. Deploy
   ├── Follow platform guide
   ├── Set environment variables
   └── Deploy both services

5. Verify
   ├── ./check-deployment.sh remote <backend-url> <frontend-url>
   └── Test in browser

6. Monitor
   ├── Set up uptime monitoring
   └── Configure error tracking
```

## 🎓 Learning Path

### Beginner
1. Read [SUMMARY.md](./SUMMARY.md)
2. Run `./deploy-local.sh`
3. Follow [Render guide](./DEPLOYMENT.md#option-a-render-easiest-free-tier)

### Intermediate
1. Read [GUIDE.md](./GUIDE.md)
2. Try multiple platforms
3. Set up custom domains
4. Configure CI/CD

### Advanced
1. AWS ECS/Fargate deployment
2. Kubernetes setup
3. Multi-region deployment
4. Advanced monitoring and scaling

## 🔐 Security Checklist

Before deploying to production:

- [ ] Run `./deploy-check.sh`
- [ ] Environment files not in git
- [ ] CORS configured properly
- [ ] HTTPS enabled
- [ ] Secrets stored securely
- [ ] Dependencies updated
- [ ] Tests passing

## 📞 Quick Links

### Documentation
- [Project README](../../README.md)
- [Quickstart Guide](../../Quickstart.md)
- [Deployment Summary](./SUMMARY.md)
- [Quick Deploy Guide](./QUICK.md)
- [Full Deployment Guide](./GUIDE.md)

### External Resources
- [Render Documentation](https://render.com/docs)
- [Railway Documentation](https://docs.railway.app/)
- [Vercel Documentation](https://vercel.com/docs)
- [Docker Documentation](https://docs.docker.com/)
- [Next.js Documentation](https://nextjs.org/docs)
- [FastAPI Documentation](https://fastapi.tiangolo.com/)

## 🎯 Recommended Reading Order

### For First-Time Deployment
1. [SUMMARY.md](./SUMMARY.md) - Overview
2. [QUICK.md](./QUICK.md) - Quick reference
3. [GUIDE.md](./GUIDE.md) - Platform guide

### For Local Development
1. [Quickstart.md](../../Quickstart.md) - Get started
2. [README.md](../../README.md) - Full documentation
3. Run `./deploy-local.sh`

### For Production Deployment
1. Run `./deploy-check.sh`
2. [GUIDE.md](./GUIDE.md) - Choose platform
3. Follow platform-specific guide
4. Run `./check-deployment.sh remote <urls>`

---

## 🚀 Ready to Deploy?

Start with [SUMMARY.md](./SUMMARY.md) for a complete overview!

**Quick Deploy**: `./deploy-local.sh` (local) or follow [Render guide](./DEPLOYMENT.md#option-a-render-easiest-free-tier) (cloud)

---

**Need Help?** Check [SUMMARY.md](./SUMMARY.md) for troubleshooting and support resources.

