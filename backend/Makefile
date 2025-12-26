.PHONY: install dev run test lint format clean help

# Default target
.DEFAULT_GOAL := help

# Python and project settings
PYTHON := python3
UV := uv
SRC_DIR := src
TEST_DIR := tests

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'

install: ## Install production dependencies using uv
	@echo "Installing dependencies with uv..."
	$(UV) pip install -e .

dev: ## Install development dependencies
	@echo "Installing development dependencies..."
	$(UV) pip install -e ".[dev]"

run: ## Run the FastAPI application
	@echo "Starting FastAPI server..."
	$(UV) run uvicorn hello_api.infrastructure.api.main:app --host 0.0.0.0 --port 8000 --reload

test: dev ## Run tests
	@echo "Running tests..."
	PYTHONPATH=src $(UV) run pytest $(TEST_DIR) -v

lint: ## Run linting with ruff
	@echo "Running ruff linter..."
	$(UV) run ruff check $(SRC_DIR)

format: ## Format code with ruff
	@echo "Formatting code..."
	$(UV) run ruff format $(SRC_DIR)
	$(UV) run ruff check --fix $(SRC_DIR)

clean: ## Clean up cache files and build artifacts
	@echo "Cleaning up..."
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".pytest_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name ".ruff_cache" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete
	@echo "Clean complete!"

setup: install ## Initial setup (install dependencies)
	@echo "Setup complete! Run 'make run' to start the server."

