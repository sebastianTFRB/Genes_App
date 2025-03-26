import numpy as np
import pandas as pd
import tensorflow as tf
from flask import Flask, request, jsonify
from sklearn.preprocessing import OneHotEncoder
import joblib

#modelo2.keras//
#modelo3.keras
#modelo4.keras

# 📌 Cargar el modelo previamente entrenado
model = tf.keras.models.load_model("mod855.keras")

# 📌 Definir las características esperadas (las 60 columnas usadas en el modelo)
feature_names = [
    'TALLA/EDAD (ACTUAL)_0', 'TALLA/EDAD (ACTUAL)_Alto', 'TALLA/EDAD (ACTUAL)_Bajo', 'TALLA/EDAD (ACTUAL)_Normal',
    'Peso al nacer/edad gestacional_0', 'Peso al nacer/edad gestacional_Adecuado', 
    'Peso al nacer/edad gestacional_Alto', 'Peso al nacer/edad gestacional_Bajo',
    'SEXO', 'PESO', 'EDAD', 'BAJO PESO AL NACER', 'TALLA/EDAD (ACTUAL).1', 'PESO/EDAD (ACTUAL)',
    'RDPM / DISCAPACIDAD INTELECTUAL', 'CARACTERISTICAS FACIALES', 'DEPRESION BITEMPORAL',
    'CEJAS ARQUEADAS', 'PLIEGUE EPICANTICO', 'PATRON ESTELAR DEL IRIS', 'PUENTE NASAL DEPRIMIDO',
    'NARIZ CORTA NARINAS ANTEVERTIDAS', 'PUNTA NASAL ANCHA O BULBOSA', 'MEJILLAS PROMINENTES',
    'REGION MALAR PLANA', 'FILTRUM LARGO', 'LABIOS GRUESOS', 'DIENTES PEQUEÑOS O ESPACIADOS',
    'PALADAR ALTO Y OJIVAL', 'BOCA AMPLIA', 'PABELLONES AURICULARES GRANDES', 'CARDIOPATIA CONGENITA',
    'ESTENOSIS SUPRAVALVULAR AORTICA', 'ESTENOSIS PULMONAR', 'OTRA CARDIOPATIA', 'OTRAS ALTERACIONES',
    'VOZ DISFONICA', 'TRASTORNO TIROIDEO', 'TRASTORNO DE LA REFRACCION', 'HERNIA', 'ORQUIDOPEXIA',
    'SINOSTOSIS RADIOCUBITAL', 'HIPERLAXITUD ARTICULAR', 'ANTECEDENTE DE ORQUIDOPEXIA', 'ESCOLIOSIS',
    'HIPERCALCEMIA', 'RETRASO EN EL DESARROLLO PSICOMOTOR', 'DÉFICIT COGNITIVO', 'PERSONALIDAD SOCIAL EXTREMA',
    'TRASTORNOS DEL APRENDIZAJE', 'ANSIEDAD O FOBIAS (Sonidos fuertes, lugares cerrados, separación, etc.)', 'PROBLEMAS DEL SUEÑO (Insomnio, despertares nocturnos)', 'GENÉTICA CONFIRMADA (Deleción 7q11.23 / Sin análisis)',
    'ESTUDIO MOLECULAR CONFIRMATORIO', 'HIPOACUSIA', 'HIPERSENSIBILIDAD AUDITIVA (HIPERACUSIA)', 'ALTERACIONES VISUALES (Miopía, astigmatismo, estrabismo)',
    'ALTERACIONES HORMONALES (Pubertad tardía, alteraciones tiroideas adicionales)', 'DIABETES INFANTIL O INTOLERANCIA A LA GLUCOSA', 'DÉFICIT DE CRECIMIENTO'
]
# 📌 Iniciar la aplicación Flask
app = Flask(__name__)

@app.route('/')
def home():
    return "API para predicción del Síndrome de Williams funcionando correctamente 🚀"

# 📌 Definir el endpoint para recibir datos desde Flutter
@app.route('/predict', methods=['POST'])
def predict():
    
    try:
        # 📌 Obtener datos en formato JSON
        data = request.json

        # 📌 Convertir los datos a un DataFrame asegurando el orden de las características
        input_data = pd.DataFrame([data], columns=feature_names)

        # 📌 Convertir a numpy array para la predicción
        input_array = input_data.values.astype(float)

        # 📌 Realizar la predicción
        prediction = model.predict(input_array)
        predicted_probability = float(prediction[0][0])
        print("predxt 2", predicted_probability)

        # 📌 Definir un umbral para clasificación binaria
        threshold = 0.5
        diagnosis = "Positivo para Síndrome de Williams" if predicted_probability >= threshold else "Negativo para Síndrome de Williams"

        # 📌 Retornar la predicción como JSON
        return jsonify({
            "probabilidad": predicted_probability,
            "diagnostico": diagnosis,
            
            #"probabilidad desde data": predicted_probability2,
           
            #"input  data": str(input_data) ,
            #"input aray": str(input_array) ,
            
            
            
        })

    except Exception as e:
        return jsonify({"error": str(e)})

# 📌 Ejecutar la API
if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
