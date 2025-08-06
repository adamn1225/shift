#!/bin/bash
"""
Global Setup Script for PDF Tools
This script makes all PDF tools available globally by creating symbolic links.
"""

# Get the absolute path of the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_PYTHON="$SCRIPT_DIR/.venv/bin/python"

# Check if virtual environment exists
if [ ! -f "$VENV_PYTHON" ]; then
    echo "❌ Virtual environment not found at $SCRIPT_DIR/.venv"
    echo "Please run 'python -m venv .venv && source .venv/bin/activate && pip install -r requirements.txt' first"
    exit 1
fi

# Check if running with sudo for system-wide installation
if [ "$EUID" -eq 0 ]; then
    # System-wide installation (requires sudo)
    BIN_DIR="/usr/local/bin"
    echo "🔧 Installing PDF tools system-wide to $BIN_DIR"
else
    # User installation
    BIN_DIR="$HOME/.local/bin"
    echo "🔧 Installing PDF tools for user to $BIN_DIR"
    
    # Create user bin directory if it doesn't exist
    mkdir -p "$BIN_DIR"
    
    # Add to PATH in .bashrc if not already there
    if ! grep -q "$BIN_DIR" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# Add user local bin to PATH" >> "$HOME/.bashrc"
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
        echo "✅ Added $BIN_DIR to PATH in .bashrc"
    fi
fi

# Create wrapper scripts for each tool
create_wrapper() {
    local tool_name=$1
    local script_path=$2
    local wrapper_path="$BIN_DIR/$tool_name"
    
    echo "📦 Installing $tool_name..."
    
    cat > "$wrapper_path" << EOF
#!/bin/bash
# Auto-generated wrapper for $tool_name
# Preserve current working directory for relative paths

# Convert relative input paths to absolute paths
args=()
for arg in "\$@"; do
    # Check if this looks like a file path (ends with common extensions and doesn't start with -)
    if [[ "\$arg" =~ \.(md|html|pdf|docx|txt|css)$ ]] && [[ ! "\$arg" =~ ^- ]] && [[ ! "\$arg" =~ ^/ ]]; then
        # Convert to absolute path if file exists in current directory
        if [ -f "\$arg" ]; then
            args+=("\$(realpath "\$arg")")
        else
            args+=("\$arg")
        fi
    else
        args+=("\$arg")
    fi
done

cd "$SCRIPT_DIR"
exec "$VENV_PYTHON" "$script_path" "\${args[@]}"
EOF
    
    chmod +x "$wrapper_path"
    echo "✅ $tool_name installed to $wrapper_path"
}

# Install each tool
echo "🚀 Setting up PDF Tools for global access..."
echo

# Check which tools exist and install them
if [ -f "$SCRIPT_DIR/pdf_outlook_attachable.py" ]; then
    create_wrapper "pdf-compress" "$SCRIPT_DIR/pdf_outlook_attachable.py"
fi

if [ -f "$SCRIPT_DIR/pdf_page_manager.py" ]; then
    create_wrapper "pdf-pages" "$SCRIPT_DIR/pdf_page_manager.py"
fi

if [ -f "$SCRIPT_DIR/pdf_editor.py" ]; then
    create_wrapper "pdf-editor" "$SCRIPT_DIR/pdf_editor.py"
fi

if [ -f "$SCRIPT_DIR/doc_converter.py" ]; then
    create_wrapper "doc-convert" "$SCRIPT_DIR/doc_converter.py"
fi

echo
echo "🎉 Installation complete!"
echo
echo "Available commands:"
echo "  pdf-compress    - Compress PDFs for email (pdf_outlook_attachable.py)"
echo "  pdf-pages       - Analyze and remove PDF pages (pdf_page_manager.py)"
echo "  doc-convert     - Convert between document formats (doc_converter.py)"

if [ -f "$SCRIPT_DIR/pdf_editor.py" ]; then
    echo "  pdf-editor      - Advanced PDF editing (pdf_editor.py)"
fi

echo
if [ "$EUID" -ne 0 ]; then
    echo "📝 Note: You may need to restart your terminal or run 'source ~/.bashrc' for the commands to be available."
    echo "🔍 Commands installed to: $BIN_DIR"
else
    echo "🔍 Commands installed to: $BIN_DIR"
fi

echo
echo "📚 Usage examples:"
echo "  pdf-compress large_file.pdf"
echo "  pdf-pages document.pdf --analyze"
echo "  pdf-pages document.pdf --remove 1,3,5"
echo "  doc-convert document.docx --to pdf"
echo "  doc-convert report.md --to html --css style.css"
