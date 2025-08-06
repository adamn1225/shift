#!/usr/bin/env python3
"""
Setup script for Shift - Universal Document Converter
"""

from setuptools import setup, find_packages
import os

# Read requirements from requirements.txt
def read_requirements():
    with open('requirements.txt', 'r') as f:
        return [line.strip() for line in f if line.strip() and not line.startswith('#')]

# Read README for long description
def read_readme():
    if os.path.exists('README.md'):
        with open('README.md', 'r', encoding='utf-8') as f:
            return f.read()
    return "Universal document format converter"

setup(
    name="shift",
    version="1.0.0",
    description="Universal document format converter",
    long_description=read_readme(),
    long_description_content_type="text/markdown",
    author="Your Name",
    author_email="your.email@example.com",
    url="https://github.com/yourusername/shift",
    py_modules=["doc_converter"],
    install_requires=[
        "pypdf>=5.9.0",
        "fpdf2>=2.8.0", 
        "markdown>=3.8.0",
        "beautifulsoup4>=4.13.0",
        "python-docx>=1.2.0",
        "docx2python>=3.5.0",
        "pdfkit>=1.0.0",
        "html2text>=2025.4.0",
        "Pillow>=11.0.0",
    ],
    entry_points={
        'console_scripts': [
            'shift=doc_converter:main',
        ],
    },
    classifiers=[
        "Development Status :: 4 - Beta",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License", 
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.8",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Topic :: Text Processing",
        "Topic :: Utilities",
    ],
    python_requires=">=3.8",
    package_data={
        '': ['*.css'],
    },
    include_package_data=True,
)
