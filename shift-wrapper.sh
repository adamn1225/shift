#!/bin/bash
# Wrapper script to call shift command without bash builtin conflict

# Force use of external shift command
exec "$(which -a shift | grep -v builtin | head -1)" "$@"
