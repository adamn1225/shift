# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

a = Analysis(
    ['cli.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('*.css', '.'),
        ('requirements.txt', '.'),
    ],
    hiddenimports=[
        'shift_converter',
        'pdf_compressor', 
        'pdf_editor',
        'pdf_page_manager',
        'pdf_ocr',
        'image_compressor',
        'pypdf',
        'fpdf',
        'markdown',
        'bs4',
        'docx',
        'pdfkit',
        'html2text',
        'PIL',
        'fitz',  # PyMuPDF
        'pytesseract',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='shift',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon=None,  # Add icon='shift.ico' if you have an icon
)
