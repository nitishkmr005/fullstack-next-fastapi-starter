"""Domain models for the Hello API.

This module contains Pydantic models that represent the core data structures
of the application. These models are used for request/response validation
and serialization.
"""

from datetime import datetime
from pydantic import BaseModel, Field


class HelloResponse(BaseModel):
    """Response model for the hello endpoint.
    
    Attributes:
        message: A greeting message from the API.
        timestamp: The time when the response was generated.
        version: The API version.
    """
    
    message: str = Field(..., description="The greeting message")
    timestamp: datetime = Field(..., description="Response generation timestamp")
    version: str = Field(default="1.0.0", description="API version")
    
    class Config:
        """Pydantic configuration."""
        json_schema_extra = {
            "example": {
                "message": "Hello from FastAPI!",
                "timestamp": "2025-12-26T10:00:00",
                "version": "1.0.0"
            }
        }

