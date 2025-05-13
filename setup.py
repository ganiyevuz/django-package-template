"""
Django package setup configuration.

This is a minimal backward compatibility wrapper for older tools.
Most configuration is in pyproject.toml following PEP 621 standards.
"""

import os
from setuptools import setup, find_packages

# Allow setup.py to be run from any path
os.chdir(os.path.normpath(os.path.join(os.path.abspath(__file__), os.pardir)))

# Read README for long_description
with open("README.md", encoding="utf-8") as f:
    long_description = f.read()

setup(
    # Package name (should be changed by the user)
    name="django-package-name",
    # Simple flag to include non-python files found by MANIFEST.in
    include_package_data=True,
    # Package discovery using setuptools
    packages=find_packages(exclude=["tests*"]),
    # README as PyPI description
    long_description=long_description,
    long_description_content_type="text/markdown",
)
