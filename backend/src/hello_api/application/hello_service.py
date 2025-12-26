"""Hello service containing business logic.

This module implements the core business logic for generating hello messages.
It is independent of any infrastructure concerns like HTTP or databases.
"""

from datetime import datetime
from loguru import logger

from hello_api.domain.models import HelloResponse


class HelloService:
    """Service class for handling hello-related business logic.
    
    This service is responsible for generating greeting messages according
    to business rules.
    """
    
    def __init__(self, api_version: str = "1.0.0"):
        """Initialize the HelloService.
        
        Args:
            api_version: The version of the API to include in responses.
        """
        self.api_version = api_version
        logger.info(f"HelloService initialized with version {api_version}")
    
    def generate_hello_response(self) -> HelloResponse:
        """Generate a hello response with current timestamp.
        
        Returns:
            HelloResponse: A response object containing the greeting message,
                          timestamp, and API version.
        """
        logger.debug("Generating hello response")
        
        response = HelloResponse(
            message="Hello from FastAPI! 🚀",
            timestamp=datetime.now(),
            version=self.api_version
        )
        
        logger.info(f"Hello response generated at {response.timestamp}")
        return response

