# Quickstart Guide

Get your full-stack Hello World application running in under 5 minutes!

## 🚀 Fastest Way: Using Docker

### Prerequisites
- Install [Docker Desktop](https://www.docker.com/products/docker-desktop/)

### Steps

1. **Navigate to project directory**:
   ```bash
   cd /Users/nitishkumarharsoor/Documents/1.Learnings/1.Projects/4.Experiments/3.Website
   ```

2. **Start the application**:
   ```bash
   docker-compose up --build
   ```

3. **Open your browser**:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8000/docs

4. **Stop the application** (when done):
   ```bash
   docker-compose down
   ```

That's it! You should see a beautiful UI fetching data from the backend.

---

## 💻 Alternative: Local Development

### Prerequisites
- [Node.js 20+](https://nodejs.org/)
- [Python 3.12+](https://www.python.org/downloads/)
- [uv](https://github.com/astral-sh/uv) (Python package installer)

### Backend (Terminal 1)

```bash
# Navigate to backend
cd backend

# Install uv (if not installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install dependencies
make install

# Run the server
make run
```

Backend will start at http://localhost:8000

### Frontend (Terminal 2)

```bash
# Navigate to frontend
cd frontend

# Install dependencies
npm install

# Run the development server
npm run dev
```

Frontend will start at http://localhost:3000

---

## ✅ Verify It's Working

1. **Visit http://localhost:3000**
2. You should see:
   - "Hello from FastAPI! 🚀" message
   - Current timestamp
   - API version
   - Tech stack information

3. **Check API docs at http://localhost:8000/docs**

---

## 🆘 Quick Troubleshooting

### Port Already in Use?

**Backend (port 8000)**:
```bash
# Find and kill process
lsof -ti:8000 | xargs kill -9
```

**Frontend (port 3000)**:
```bash
# Find and kill process
lsof -ti:3000 | xargs kill -9
```

### Backend Not Starting?
```bash
cd backend
make clean
make install
make run
```

### Frontend Not Starting?
```bash
cd frontend
rm -rf node_modules
npm install
npm run dev
```

### Can't Connect Frontend to Backend?
- Make sure backend is running: Visit http://localhost:8000
- Check browser console for errors (F12)

---

## 🎯 What's Next?

Once everything is running:

1. **Explore the Code**:
   - Frontend: `frontend/src/app/page.tsx`
   - Backend: `backend/src/hello_api/infrastructure/api/main.py`

2. **Try Making Changes**:
   - Edit the message in `backend/src/hello_api/application/hello_service.py`
   - Modify the UI in `frontend/src/app/page.tsx`
   - Both have hot-reload enabled!

3. **Read the Full Documentation**: Check out [README.md](README.md) for detailed information

---

## 📝 Common Commands

### Docker
```bash
# Start services
docker-compose up

# Start in background
docker-compose up -d

# Stop services
docker-compose down

# View logs
docker-compose logs -f

# Rebuild containers
docker-compose up --build
```

### Backend (Local)
```bash
make install    # Install dependencies
make run        # Run server
make test       # Run tests
make lint       # Check code quality
make format     # Format code
make clean      # Clean cache files
```

### Frontend (Local)
```bash
npm install     # Install dependencies
npm run dev     # Development server
npm run build   # Production build
npm start       # Run production build
npm run lint    # Check code quality
```

---

Need help? Check the full [README.md](README.md) or open an issue!

Happy coding! 🚀

