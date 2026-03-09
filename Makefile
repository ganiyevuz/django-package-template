.PHONY: help venv install lint format test coverage dist publish release example clean

help: ## Show available commands
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-12s %s\n", $$1, $$2}'

venv: ## Create virtual environment
	uv venv

install: ## Install with dev dependencies
	uv sync --group dev

lint: ## Check code style
	uv run ruff check .
	uv run ruff format --check .

format: ## Format code
	uv run ruff check --fix .
	uv run ruff format .

test: ## Run tests
	uv run pytest

coverage: ## Run tests with coverage
	uv run pytest --cov

dist: clean ## Build package
	uv build

publish: dist ## Publish to PyPI
	uv publish

example: ## Create example Django project
	@./scripts/create_example_project.sh

release: lint test ## Release a version (usage: make release v=0.2.0)
	@./scripts/release.sh $(v)

clean: ## Remove build artifacts
	rm -rf build/ dist/ *.egg-info
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name '*.py[co]' -delete
