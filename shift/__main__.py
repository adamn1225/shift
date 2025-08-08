#!/usr/bin/env python3

if __name__ == '__main__':
    import sys
    import os
    
    # Add parent directory to path to import shift_converter
    sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
    
    from shift_converter import main
    main()
