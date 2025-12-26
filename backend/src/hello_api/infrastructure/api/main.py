"""FastAPI application entry point.

This module sets up the FastAPI application with CORS middleware,
routes, and endpoint handlers.
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from loguru import logger

from hello_api.application.hello_service import HelloService
from hello_api.domain.models import HelloResponse


# Initialize FastAPI app
app = FastAPI(
    title="Hello API",
    description="A simple FastAPI application demonstrating Clean Architecture",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Configure CORS for local development
# Allow frontend running on localhost:3000 to access the API
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
        "http://127.0.0.1:3000",
        "http://frontend:3000"  # Docker service name
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Initialize service
hello_service = HelloService(api_version="1.0.0")


@app.on_event("startup")
async def startup_event():
    """Log application startup."""
    logger.info("Starting Hello API application")
    logger.info("API documentation available at /docs")


@app.on_event("shutdown")
async def shutdown_event():
    """Log application shutdown."""
    logger.info("Shutting down Hello API application")


@app.get("/", tags=["Health"])
async def root():
    """Root endpoint for health check.
    
    Returns:
        dict: A simple health status message.
    """
    return {
        "status": "healthy",
        "message": "Hello API is running!",
        "docs": "/docs"
    }


@app.get("/api/hello", response_model=HelloResponse, tags=["Hello"])
async def hello() -> HelloResponse:
    """Hello endpoint that returns a greeting message.
    
    This endpoint demonstrates a simple API call that returns a structured
    response with a message, timestamp, and version information.
    
    Returns:
        HelloResponse: A response containing greeting message, timestamp, and version.
    """
    logger.info("Hello endpoint called")
    response = hello_service.generate_hello_response()
    return response


if __name__ == "__main__":
    import uvicorn
    
    logger.info("Starting server with uvicorn")
    uvicorn.run(
        "hello_api.infrastructure.api.main:app",
        host="0.0.0.0",
        port=8000,
        reload=True
    )

