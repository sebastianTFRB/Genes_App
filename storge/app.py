from flask import Flask, request, jsonify, send_file
import os
from datetime import datetime
from werkzeug.utils import secure_filename
from flask import send_from_directory

app = Flask(__name__)

# 📁 Carpeta donde se guardarán los archivos
UPLOAD_FOLDER = os.path.join(os.getcwd(), 'uploads')
os.makedirs(UPLOAD_FOLDER, exist_ok=True)

# 📌 Ruta para subir archivos
@app.route('/upload', methods=['POST'])
def upload_file():
    if 'file' not in request.files:
        return jsonify({'error': 'No se encontró archivo en la solicitud'}), 400

    file = request.files['file']
    if file.filename == '':
        return jsonify({'error': 'Nombre de archivo vacío'}), 400

    filename = secure_filename(file.filename)
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    full_filename = f"{timestamp}_{filename}"

    file.save(os.path.join(UPLOAD_FOLDER, full_filename))
    print(f"Archivo recibido: {full_filename}")

    return jsonify({'mensaje': 'Archivo subido correctamente', 'archivo': full_filename}), 200




@app.route('/upload/<filename>')

def descargar_archivo(filename):
    path_to_file = os.path.join(UPLOAD_FOLDER, filename)
    return send_file(path_to_file, mimetype='application/pdf', as_attachment=False)

# Ruta raíz para verificar que el servidor funciona
@app.route('/')
def home():
    return 'API de carga de archivos funcionando 🚀'

if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5001)

