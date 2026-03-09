# Django Package Template

A modern, minimal, and production-ready template for building and publishing reusable Django packages to PyPI.

[GitHub: ganiyevuz/django-package-template](https://github.com/ganiyevuz/django-package-template)

---

## Features

- Clean and minimal project structure for Django package development
- CI/CD via GitHub Actions for testing and automated PyPI publishing
- Modern dependency management with [uv](https://github.com/astral-sh/uv)
- Python 3.11-3.13 & Django 5.2+ support
- Fast linting and formatting with [ruff](https://github.com/astral-sh/ruff)
- Preconfigured pytest and coverage
- One-command release script
- Makefile with common development commands
- MIT License

---

## Quickstart

### 1. Create a New Package from Template

```bash
git clone https://github.com/ganiyevuz/django-package-template.git your-package-name
cd your-package-name

rm -rf .git
git init
git add .
git commit -m "Initial commit using Django package template"
```

### 2. Customize Metadata

Edit the following files:

* `pyproject.toml` - package name, version, author, dependencies
* `README.md` - your own documentation
* `LICENSE` - update copyright

Create your Django app inside `src/` (e.g. `src/your_package_name/`).

### 3. Set Up the Development Environment

```bash
# Install uv (if not installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Create virtual environment
uv venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate

# Install dependencies with dev tools
uv sync --group dev
```

### 4. Start Coding

Implement your Django package inside `src/your_package_name/`:

```text
src/
└── your_package_name/
    ├── __init__.py
    ├── apps.py
    ├── models.py
    ├── views.py
    ├── urls.py
    ├── admin.py
    ├── templates/
    └── static/
```

### 5. Use the Makefile

```bash
make install    # Install with dev dependencies
make lint       # Check code style with ruff
make format     # Format code with ruff
make test       # Run tests with pytest
make coverage   # Run tests with coverage
make dist       # Build distributable package
make release v=0.1.0  # Lint, test, bump version, tag, and push
make clean      # Clean build artifacts
```

---

## GitHub Actions: CI/CD

This template includes GitHub Actions for:

* Running linting and tests on pushes and PRs
* Testing across Python 3.11-3.13 and Django 5.2+
* Publishing to PyPI on version tag push (e.g., `v0.1.0`)

### PyPI Configuration (Trusted Publishing)

1. Go to [PyPI](https://pypi.org) and configure trusted publishing for your package
2. Add a publishing environment named `pypi` in your GitHub repo settings

### Release

```bash
# One-command release: lints, tests, bumps version, tags, and pushes
make release v=0.1.0

# If CI fails, run the same command again — it will prompt to replace the tag
make release v=0.1.0
```

---

## Project Structure

```text
django-package-template/
├── .github/workflows/    # GitHub Actions CI/CD
├── scripts/release.sh    # Release automation script
├── src/your_package/     # Your Django app/package
├── tests/                # Unit tests (create this)
├── pyproject.toml        # Project metadata and dependencies
├── Makefile              # Development commands
├── LICENSE               # MIT License
├── README.md             # This file
└── .gitignore
```

---

## Contributing

```bash
git checkout -b feature/my-feature
git commit -m "Add my feature"
git push origin feature/my-feature
```

Then open a Pull Request.

---

## License

Licensed under the MIT License. See [LICENSE](LICENSE) for details.
