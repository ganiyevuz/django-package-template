#!/usr/bin/env bash
set -euo pipefail

EXAMPLE_DIR="example"

if [ -d "$EXAMPLE_DIR" ]; then
    echo "Error: '$EXAMPLE_DIR/' already exists. Remove it first to recreate."
    exit 1
fi

# Detect the package name from src/
PACKAGE_NAME=$(find src -mindepth 1 -maxdepth 1 -type d ! -name '__pycache__' | head -1 | xargs basename 2>/dev/null || true)
if [ -z "$PACKAGE_NAME" ]; then
    echo "Error: no package directory found under src/"
    echo "Create your package first: mkdir -p src/your_package_name"
    exit 1
fi

echo "Creating example project for package: $PACKAGE_NAME"

mkdir -p "$EXAMPLE_DIR"

# settings.py
cat > "$EXAMPLE_DIR/settings.py" << EOF
from pathlib import Path

BASE_DIR = Path(__file__).resolve().parent

SECRET_KEY = "example-secret-key-not-for-production"

DEBUG = True

ALLOWED_HOSTS = ["*"]

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "$PACKAGE_NAME",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
]

ROOT_URLCONF = "urls"

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}

STATIC_URL = "static/"

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"
EOF

# urls.py
cat > "$EXAMPLE_DIR/urls.py" << 'EOF'
from django.contrib import admin
from django.urls import path

urlpatterns = [
    path("admin/", admin.site.urls),
]
EOF

# manage.py
cat > "$EXAMPLE_DIR/manage.py" << 'EOF'
#!/usr/bin/env python
import os
import sys
from pathlib import Path

def main():
    # Add src/ to path so the package is importable
    sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))
    os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")
    from django.core.management import execute_from_command_line
    execute_from_command_line(sys.argv)

if __name__ == "__main__":
    main()
EOF

echo ""
echo "Example project created in '$EXAMPLE_DIR/'."
echo ""
echo "Usage:"
echo "  cd $EXAMPLE_DIR"
echo "  uv run python manage.py migrate"
echo "  uv run python manage.py createsuperuser"
echo "  uv run python manage.py runserver"