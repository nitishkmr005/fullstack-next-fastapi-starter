"""Pytest configuration and fixtures for testing."""

import pytest
from fastapi.testclient import TestClient

from hello_api.infrastructure.api.main import app


@pytest.fixture
def client():
    """Create a test client for the FastAPI application.
    
    Returns:
        TestClient: A test client instance for making requests to the API.
    """
    return TestClient(app)

