"""End-to-end tests for the Hello API.

This module contains integration tests that verify the complete functionality
of the API endpoints.
"""

import pytest
from datetime import datetime


def test_root_endpoint(client):
    """Test the root health check endpoint.
    
    Args:
        client: The test client fixture.
    """
    response = client.get("/")
    
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "healthy"
    assert "message" in data
    assert "docs" in data


def test_hello_endpoint(client):
    """Test the /api/hello endpoint.
    
    Args:
        client: The test client fixture.
    """
    response = client.get("/api/hello")
    
    assert response.status_code == 200
    data = response.json()
    
    # Verify response structure
    assert "message" in data
    assert "timestamp" in data
    assert "version" in data
    
    # Verify data types and values
    assert isinstance(data["message"], str)
    assert len(data["message"]) > 0
    assert data["version"] == "1.0.0"
    
    # Verify timestamp is valid
    timestamp = datetime.fromisoformat(data["timestamp"].replace("Z", "+00:00"))
    assert isinstance(timestamp, datetime)


def test_api_docs_available(client):
    """Test that API documentation is accessible.
    
    Args:
        client: The test client fixture.
    """
    # Test OpenAPI docs
    response = client.get("/docs")
    assert response.status_code == 200
    
    # Test ReDoc
    response = client.get("/redoc")
    assert response.status_code == 200
    
    # Test OpenAPI schema
    response = client.get("/openapi.json")
    assert response.status_code == 200
    schema = response.json()
    assert "openapi" in schema
    assert "info" in schema


def test_cors_headers(client):
    """Test that CORS headers are properly set.
    
    Args:
        client: The test client fixture.
    """
    response = client.options(
        "/api/hello",
        headers={
            "Origin": "http://localhost:3000",
            "Access-Control-Request-Method": "GET"
        }
    )
    
    # CORS headers should be present
    assert "access-control-allow-origin" in response.headers

