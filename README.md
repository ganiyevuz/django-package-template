# Django Package Template

A clean, minimal template for creating Django packages ready for publishing on PyPI. This template provides the foundational structure and configuration files needed to develop, test, and publish Django packages efficiently.

## Features

- Minimal, ready-to-use project structure for Django package development
- GitHub Actions workflow for automated testing and PyPI publishing
- Modern dependency management with uv
- Support for Python 3.10+ and Django 4.2+
- Pre-configured Makefile with common development commands
- MIT License template
- Modern packaging with pyproject.toml for dependencies and metadata



## How to Use This Template

### 1. Create Your Package Repository

```bash
# Clone this template repository
git clone https://github.com/yourusername/django-package-template.git your-package-name
cd your-package-name

# Remove the existing git repository and initialize a new one
rm -rf .git
git init
git add .
git commit -m "Initial commit using Django package template"
```

### 2. Customize Package Information

Edit the following files to update package information:

- **setup.py**: Change package name, author, version, description, etc.
- **pyproject.toml**: Update target Python versions and dependencies
- **README.md**: Replace with your package's documentation
- **LICENSE**: Update the copyright information if needed

### 3. Set Up Your Development Environment

```bash
# Install uv if not already installed
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create and activate virtual environment
uv venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install package with development dependencies
uv install -e ".[dev]"
```

### 4. Implement Your Package

1. Create your package directory with a name matching your project
2. Implement your Django app functionality following Django's app structure

   ```text
   your_package_name/
   ├── __init__.py        # Package initialization
   ├── apps.py            # Django app configuration
   ├── models.py          # Data models
   ├── views.py           # Views
   ├── admin.py           # Admin interface
   ├── urls.py            # URL routing
   ├── static/            # Static files
   └── templates/         # HTML templates
   ```

3. Add tests in the `tests` directory
4. Update documentation

### 5. Development Workflow

Use the included Makefile for common tasks:

```bash
# Run tests
make test

# Check code coverage
make coverage

# Lint code
make lint

# Build package
make dist

# Install package locally
make install

# Clean build artifacts
make clean
```

### 6. Set Up GitHub Actions for CI/CD

1. Push your code to GitHub
2. Configure PyPI credentials as repository secrets:
   - `PYPI_USERNAME`
   - `PYPI_PASSWORD`

### 7. Release to PyPI

```bash
# Create and tag a new release
git tag -a v0.1.0 -m "First release"
git push origin v0.1.0
```

GitHub Actions will automatically build and publish your package to PyPI when you push a new tag.

## Project Structure

```text
django-package-template/
├── .github/workflows/   # GitHub Actions workflows
├── tests/               # Package tests
├── .gitignore           # Git ignore patterns
├── LICENSE              # MIT License
├── MANIFEST.in          # Package manifest
├── Makefile             # Development commands
├── pyproject.toml       # Project metadata and dependencies
├── README.md            # Package documentation
├── setup.cfg            # Additional package configuration
└── setup.py             # Backward compatibility wrapper
```

## Contributing to This Template

If you have suggestions for improving this template:

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-improvement`
3. Commit your changes: `git commit -m 'Add some amazing improvement'`
4. Push to the branch: `git push origin feature/amazing-improvement`
5. Open a Pull Request

## License

This template is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
