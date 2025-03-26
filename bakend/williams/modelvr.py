import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split, KFold
from sklearn.preprocessing import OneHotEncoder
from imblearn.over_sampling import SMOTE
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Dropout
from tensorflow.keras.regularizers import l2
from tensorflow.keras.callbacks import EarlyStopping
import pickle



# Guardar el OneHotEncoder en un archivo


data_path = "prueba.xlsx"
dataset = pd.read_excel(data_path)


dataset['TALLA/EDAD (ACTUAL)'] = dataset['TALLA/EDAD (ACTUAL)'].astype(str)
dataset['Peso al nacer/edad gestacional'] = dataset['Peso al nacer/edad gestacional'].astype(str)


categorical_cols = ['TALLA/EDAD (ACTUAL)', 'Peso al nacer/edad gestacional']
binary_cols = dataset.columns.drop(['CASOS', 'TALLA/EDAD (ACTUAL)', 'Peso al nacer/edad gestacional', 'Sospecha_WS'])

onehotencoder = OneHotEncoder()
categorical_data = onehotencoder.fit_transform(dataset[categorical_cols]).toarray()

# Guardar el OneHotEncoder en un archivo
with open('onehotencoder.pkl', 'wb') as f:
    pickle.dump(onehotencoder, f)

# 📌 **Concatenar datos categóricos codificados con datos binarios directamente**
X = np.concatenate((categorical_data, dataset[binary_cols].values), axis=1)

# 📌 **Variable objetivo**
y = dataset['Sospecha_WS'].values

# 📌 **Aumentar datos con SMOTE (Si la cantidad de datos es baja)**
smote = SMOTE(sampling_strategy='minority', random_state=42)
X_resampled, y_resampled = smote.fit_resample(X, y)

# 📌 **Dividir el conjunto de datos en entrenamiento y prueba (Asegurando Variabilidad con `stratify=y`)**
X_train, X_test, y_train, y_test = train_test_split(X_resampled, y_resampled, test_size=0.2, stratify=y_resampled, random_state=42)

# 📌 **Validación Cruzada con `KFold` (5 divisiones)**
kf = KFold(n_splits=5, shuffle=True, random_state=42)

for train_index, val_index in kf.split(X_train):
    X_train_fold, X_val_fold = X_train[train_index], X_train[val_index]
    y_train_fold, y_val_fold = y_train[train_index], y_train[val_index]

    # 📌 **Construir la red neuronal con Regularización L2 y Dropout**
    model = Sequential([
        Dense(32, activation='relu', kernel_regularizer=l2(0.01), input_shape=(X_train.shape[1],)),
        Dropout(0.5),
        Dense(16, activation='relu', kernel_regularizer=l2(0.01)),
        Dropout(0.5),
        Dense(1, activation='sigmoid')
    ])

    # 📌 **Compilar el modelo**
    model.compile(optimizer='adam', loss='binary_crossentropy', metrics=['accuracy'])


    early_stopping = EarlyStopping(monitor='val_loss', patience=2, restore_best_weights=True)

    history = model.fit(X_train_fold, y_train_fold, epochs=50, batch_size=10, validation_data=(X_val_fold, y_val_fold), callbacks=[early_stopping])


loss, accuracy = model.evaluate(X_test, y_test)
print(f'Accuracy: {accuracy*100:.2f}%')

# 📌 **Guardar el modelo en formato .keras recomendado**
model.save("mod855.keras")


new_data = np.random.rand(1, X_train.shape[1])  # Datos simulados
prediction = model.predict(new_data)
print("Predicción del modelo en datos nuevos:", prediction)

print("")
plt.plot(history.history['accuracy'], label='Entrenamiento')
plt.plot(history.history['val_accuracy'], label='Validación')
plt.title('Precisión del Modelo')
plt.xlabel('Épocas')
plt.ylabel('Precisión')
plt.legend()
plt.show()


# 📌 **Imprimir el número de muestras en cada conjunto**
print(f"Número total de datos (original): {X.shape[0]}")
print(f"Número total de datos (después de SMOTE): {X_resampled.shape[0]}")
print(f"Número de datos en entrenamiento: {X_train.shape[0]}")
print(f"Número de datos en prueba: {X_test.shape[0]}")

# 📌 **Contar cantidad de características**
number_of_features = X.shape[1]
number_of_features2 = X_train.shape[1]
print(f"El número total de características después del preprocesamiento es: {number_of_features} , {number_of_features2}")


categorical_feature_names = onehotencoder.get_feature_names_out(categorical_cols)
total_feature_names = np.concatenate((categorical_feature_names, binary_cols))
print("Nombres de todas las características después del preprocesamiento y codificación:")
print(total_feature_names)

print(pd.Series(y).value_counts())  # Para ver el balance de clases antes de SMOTE
print("precision")


###prediccion
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

data = {
  "TALLA/EDAD (ACTUAL)_0": 0,
  "TALLA/EDAD (ACTUAL)_Alto": 0,
  "TALLA/EDAD (ACTUAL)_Bajo": 1,
  "TALLA/EDAD (ACTUAL)_Normal": 0,
  "Peso al nacer/edad gestacional_0": 0,
  "Peso al nacer/edad gestacional_Adecuado": 0,
  "Peso al nacer/edad gestacional_Alto": 1,
  "Peso al nacer/edad gestacional_Bajo": 0,
  "SEXO": 1,
  "PESO": 70,
  "EDAD": 25,
  "BAJO PESO AL NACER": 0,
  "TALLA/EDAD (ACTUAL).1": 1,
  "PESO/EDAD (ACTUAL)": 0,
  "RDPM / DISCAPACIDAD INTELECTUAL": 0,
  "CARACTERISTICAS FACIALES": 1,
  "DEPRESION BITEMPORAL": 0,
  "CEJAS ARQUEADAS": 1,
  "PLIEGUE EPICANTICO": 0,
  "PATRON ESTELAR DEL IRIS": 1,
  "PUENTE NASAL DEPRIMIDO": 0,
  "NARIZ CORTA NARINAS ANTEVERTIDAS": 1,
  "PUNTA NASAL ANCHA O BULBOSA": 0,
  "MEJILLAS PROMINENTES": 0,
  "REGION MALAR PLANA": 1,
  "FILTRUM LARGO": 0,
  "LABIOS GRUESOS": 1,
  "DIENTES PEQUEÑOS O ESPACIADOS": 0,
  "PALADAR ALTO Y OJIVAL": 1,
  "BOCA AMPLIA": 0,
  "PABELLONES AURICULARES GRANDES": 1,
  "CARDIOPATIA CONGENITA": 0,
  "ESTENOSIS SUPRAVALVULAR AORTICA": 1,
  "ESTENOSIS PULMONAR": 0,
  "OTRA CARDIOPATIA": 1,
  "OTRAS ALTERACIONES": 0,
  "VOZ DISFONICA": 1,
  "TRASTORNO TIROIDEO": 0,
  "TRASTORNO DE LA REFRACCION": 1,
  "HERNIA": 0,
  "ORQUIDOPEXIA": 1,
  "SINOSTOSIS RADIOCUBITAL": 0,
  "HIPERLAXITUD ARTICULAR": 1,
  "ANTECEDENTE DE ORQUIDOPEXIA": 0,
  "ESCOLIOSIS": 1,
  "HIPERCALCEMIA": 0,
  "RETRASO EN EL DESARROLLO PSICOMOTOR": 1,
  "DÉFICIT COGNITIVO": 0,
  "PERSONALIDAD SOCIAL EXTREMA": 1,
  "TRASTORNOS DEL APRENDIZAJE": 0,
  "ANSIEDAD O FOBIAS (Sonidos fuertes, lugares cerrados, separación, etc.)": 1,
  "PROBLEMAS DEL SUEÑO (Insomnio, despertares nocturnos)": 0,
  "GENÉTICA CONFIRMADA (Deleción 7q11.23 / Sin análisis)": 1,
  "ESTUDIO MOLECULAR CONFIRMATORIO": 0,
  "HIPOACUSIA": 1,
  "HIPERSENSIBILIDAD AUDITIVA (HIPERACUSIA)": 0,
  "ALTERACIONES VISUALES (Miopía, astigmatismo, estrabismo)": 1,
  "ALTERACIONES HORMONALES (Pubertad tardía, alteraciones tiroideas adicionales)": 0,
  "DIABETES INFANTIL O INTOLERANCIA A LA GLUCOSA": 1,
  "DÉFICIT DE CRECIMIENTO": 0
}

# 📌 Convertir los datos a un DataFrame asegurando el orden de las características
input_data = pd.DataFrame([data], columns=feature_names)

# 📌 Convertir a numpy array para la predicción
input_array = input_data.values.astype(float)

# 📌 Realizar la predicción
prediction = model.predict(input_array)


prediction=(prediction>0.5)
print(prediction)