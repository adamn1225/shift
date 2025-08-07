# Bash `shift` Command Conflict - SOLVED ✅

## Problem
When you run `shift --help`, you get:
```
-bash: shift: -h: numeric argument required
```

## Why This Happens
- `shift` is a **bash builtin command** used to shift positional parameters
- Bash prioritizes builtin commands over external commands
- Your `shift` tool is correctly installed but hidden by the bash builtin

## Solutions (in order of preference)

### 1. Use `shift-convert` (RECOMMENDED)
```bash
shift-convert document.docx --to pdf
shift-convert --help
```

### 2. Use full path to bypass builtin
```bash
/home/bender/.local/bin/shift document.docx --to pdf
/home/bender/.local/bin/shift --help
```

### 3. Check which command you're using
```bash
which shift                    # Shows: built-in shell function
which shift-convert           # Shows: /home/bender/.local/bin/shift-convert
type shift                    # Shows: shift is a shell builtin
```

## Quick Test
```bash
# This works:
shift-convert sample_document.txt --to html --output test.html

# This also works (full path):
/home/bender/.local/bin/shift sample_document.txt --to html --output test.html

# This gives the bash error:
shift --help  # ❌ bash builtin
```

## All Your Tools Work Fine
```bash
shift-convert --help          # Document converter
shift-compress --help         # PDF compressor  
shift-pages --help           # Page manager
shift-edit --help            # PDF editor
shift-ocr --help             # OCR extractor
```

The tools are installed correctly - it's just a naming conflict with bash.

**Bottom line: Use `shift-convert` and you're all set! 🚀**
