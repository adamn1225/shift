#!/usr/bin/env python3
"""
Simple web interface for Shift document converter
For deployment to cloud platforms with HTTP endpoints
"""

from flask import Flask, request, send_file, jsonify
import tempfile
import os
from pathlib import Path
import sys
from doc_converter import DocumentConverter

app = Flask(__name__)
app.config['MAX_CONTENT_LENGTH'] = 50 * 1024 * 1024  # 50MB max file size

@app.route('/')
def index():
    return '''
    <!DOCTYPE html>
    <html>
    <head>
        <title>Shift Document Converter</title>
        <style>
            body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
            .upload-area { border: 2px dashed #ccc; padding: 40px; text-align: center; margin: 20px 0; }
            .upload-area:hover { border-color: #007bff; }
            button { background: #007bff; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
            button:hover { background: #0056b3; }
            select, input { padding: 8px; margin: 5px; border: 1px solid #ddd; border-radius: 4px; }
        </style>
    </head>
    <body>
        <h1>🔄 Shift Document Converter</h1>
        <p>Convert between PDF, Word, HTML, Markdown, and Text formats</p>
        
        <form action="/convert" method="post" enctype="multipart/form-data">
            <div class="upload-area">
                <input type="file" name="file" required accept=".pdf,.docx,.html,.md,.txt">
                <p>Choose a file to convert</p>
            </div>
            
            <label>Convert to:</label>
            <select name="to_format" required>
                <option value="pdf">PDF</option>
                <option value="docx">Word Document</option>
                <option value="html">HTML</option>
                <option value="md">Markdown</option>
                <option value="text">Plain Text</option>
            </select>
            
            <br><br>
            <button type="submit">Convert Document</button>
        </form>
        
        <hr>
        <h3>API Usage</h3>
        <code>POST /api/convert</code> with file and to_format parameters
    </body>
    </html>
    '''

@app.route('/convert', methods=['POST'])
def convert_file():
    try:
        if 'file' not in request.files:
            return "No file uploaded", 400
        
        file = request.files['file']
        to_format = request.form.get('to_format')
        
        if file.filename == '':
            return "No file selected", 400
        
        if not to_format:
            return "No target format specified", 400
        
        # Save uploaded file to temp directory
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            input_file = temp_path / file.filename
            file.save(input_file)
            
            # Determine output filename
            output_filename = f"{input_file.stem}.{to_format}"
            output_file = temp_path / output_filename
            
            # Convert using DocumentConverter
            converter = DocumentConverter()
            success = converter.convert(input_file, output_file, to_format=to_format)
            
            if success and output_file.exists():
                return send_file(
                    output_file,
                    as_attachment=True,
                    download_name=output_filename
                )
            else:
                return "Conversion failed", 500
                
    except Exception as e:
        return f"Error: {str(e)}", 500

@app.route('/api/convert', methods=['POST'])
def api_convert():
    """API endpoint for programmatic access"""
    try:
        if 'file' not in request.files:
            return jsonify({'error': 'No file uploaded'}), 400
        
        file = request.files['file']
        to_format = request.form.get('to_format') or request.json.get('to_format')
        
        if not to_format:
            return jsonify({'error': 'No target format specified'}), 400
        
        # Process conversion (same logic as above)
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            input_file = temp_path / file.filename
            file.save(input_file)
            
            output_filename = f"{input_file.stem}.{to_format}"
            output_file = temp_path / output_filename
            
            converter = DocumentConverter()
            success = converter.convert(input_file, output_file, to_format=to_format)
            
            if success and output_file.exists():
                return send_file(
                    output_file,
                    as_attachment=True,
                    download_name=output_filename
                )
            else:
                return jsonify({'error': 'Conversion failed'}), 500
                
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/health')
def health_check():
    return jsonify({'status': 'healthy', 'service': 'shift-converter'})

@app.route('/formats')
def supported_formats():
    """Return supported conversion formats"""
    converter = DocumentConverter()
    conversions = converter.get_supported_conversions()
    
    return jsonify({
        'supported_conversions': conversions,
        'input_formats': list(set([conv[0] for conv in conversions])),
        'output_formats': list(set([conv[1] for conv in conversions]))
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port, debug=False)
