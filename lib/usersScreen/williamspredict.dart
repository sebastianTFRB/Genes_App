import 'package:flutter/material.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Widget to display information for each question
class QuestionInfo extends StatelessWidget {
  final String infoText;

  const QuestionInfo({Key? key, required this.infoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        infoText,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}

// Main screen for Williams syndrome predictions
class Williamspredict extends StatefulWidget {
  const Williamspredict({super.key});

  @override
  State<Williamspredict> createState() => _WilliamspredictState();
}

class _WilliamspredictState extends State<Williamspredict> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController(); // Scroll controller
  final Map<String, int> _formData = {
    'TALLA/EDAD (ACTUAL)_0': 0,
    'TALLA/EDAD (ACTUAL)_Alto': 0,
    'TALLA/EDAD (ACTUAL)_Bajo': 0,
    'TALLA/EDAD (ACTUAL)_Normal': 0,
    'Peso al nacer/edad gestacional_0': 0,
    'Peso al nacer/edad gestacional_Adecuado': 0,
    'Peso al nacer/edad gestacional_Alto': 0,
    'Peso al nacer/edad gestacional_Bajo': 0,
    'SEXO': 0,
    'PESO': 0,
    'EDAD': 0,
    'BAJO PESO AL NACER': 0,
    'TALLA/EDAD (ACTUAL).1': 0,
    'PESO/EDAD (ACTUAL)': 0,
    'RDPM / DISCAPACIDAD INTELECTUAL': 0,
    'CARACTERISTICAS FACIALES': 0,
    'DEPRESION BITEMPORAL': 0,
    'CEJAS ARQUEADAS': 0,
    'PLIEGUE EPICANTICO': 0,
    'PATRON ESTELAR DEL IRIS': 0,
    'PUENTE NASAL DEPRIMIDO': 0,
    'NARIZ CORTA NARINAS ANTEVERTIDAS': 0,
    'PUNTA NASAL ANCHA O BULBOSA': 0,
    'MEJILLAS PROMINENTES': 0,
    'REGION MALAR PLANA': 0,
    'FILTRUM LARGO': 0,
    'LABIOS GRUESOS': 0,
    'DIENTES PEQUEÑOS O ESPACIADOS': 0,
    'PALADAR ALTO Y OJIVAL': 0,
    'BOCA AMPLIA': 0,
    'PABELLONES AURICULARES GRANDES': 0,
    'CARDIOPATIA CONGENITA': 0,
    'ESTENOSIS SUPRAVALVULAR AORTICA': 0,
    'ESTENOSIS PULMONAR': 0,
    'OTRA CARDIOPATIA': 0,
    'OTRAS ALTERACIONES': 0,
    'VOZ DISFONICA': 0,
    'TRASTORNO TIROIDEO': 0,
    'TRASTORNO DE LA REFRACCION': 0,
    'HERNIA': 0,
    'ORQUIDOPEXIA': 0,
    'SINOSTOSIS RADIOCUBITAL': 0,
    'HIPERLAXITUD ARTICULAR': 0,
    'ANTECEDENTE DE ORQUIDOPEXIA': 0,
    'ESCOLIOSIS': 0,
    'HIPERCALCEMIA': 0,
    'RETRASO EN EL DESARROLLO PSICOMOTOR': 0,
    'DÉFICIT COGNITIVO': 0,
    'PERSONALIDAD SOCIAL EXTREMA': 0,
    'TRASTORNOS DEL APRENDIZAJE': 0,
    'ANSIEDAD O FOBIAS (Sonidos fuertes, lugares cerrados, separación, etc.)': 0,
    'PROBLEMAS DEL SUEÑO (Insomnio, despertares nocturnos)': 0,
    'GENÉTICA CONFIRMADA (Deleción 7q11.23 / Sin análisis)': 0,
    'ESTUDIO MOLECULAR CONFIRMATORIO': 0,
    'HIPOACUSIA': 0,
    'HIPERSENSIBILIDAD AUDITIVA (HIPERACUSIA)': 0,
    'ALTERACIONES VISUALES (Miopía, astigmatismo, estrabismo)': 0,
    'ALTERACIONES HORMONALES (Pubertad tardía, alteraciones tiroideas adicionales)': 0,
    'DIABETES INFANTIL O INTOLERANCIA A LA GLUCOSA': 0,
    'DÉFICIT DE CRECIMIENTO': 0,
  };

  final List<Map<String, String>> campos = [
    {'label': 'TALLA/EDAD (ACTUAL)_0', 'key': 'TALLA/EDAD (ACTUAL)_0'},
    {'label': 'TALLA/EDAD (ACTUAL)_Alto', 'key': 'TALLA/EDAD (ACTUAL)_Alto'},
    {'label': 'TALLA/EDAD (ACTUAL)_Bajo', 'key': 'TALLA/EDAD (ACTUAL)_Bajo'},
    {'label': 'TALLA/EDAD (ACTUAL)_Normal', 'key': 'TALLA/EDAD (ACTUAL)_Normal'},
    {'label': 'Peso al nacer/edad gestacional_0', 'key': 'Peso al nacer/edad gestacional_0'},
    {'label': 'Peso al nacer/edad gestacional_Adecuado', 'key': 'Peso al nacer/edad gestacional_Adecuado'},
    {'label': 'Peso al nacer/edad gestacional_Alto', 'key': 'Peso al nacer/edad gestacional_Alto'},
    {'label': 'Peso al nacer/edad gestacional_Bajo', 'key': 'Peso al nacer/edad gestacional_Bajo'},
    {'label': 'SEXO', 'key': 'SEXO'},
    {'label': 'PESO', 'key': 'PESO'},
    {'label': 'EDAD', 'key': 'EDAD'},
    {'label': 'BAJO PESO AL NACER', 'key': 'BAJO PESO AL NACER'},
    {'label': 'TALLA/EDAD (ACTUAL).1', 'key': 'TALLA/EDAD (ACTUAL).1'},
    {'label': 'PESO/EDAD (ACTUAL)', 'key': 'PESO/EDAD (ACTUAL)'},
    {'label': 'RDPM / DISCAPACIDAD INTELECTUAL', 'key': 'RDPM / DISCAPACIDAD INTELECTUAL'},
    {'label': 'CARACTERISTICAS FACIALES', 'key': 'CARACTERISTICAS FACIALES'},
    {'label': 'DEPRESION BITEMPORAL', 'key': 'DEPRESION BITEMPORAL'},
    {'label': 'CEJAS ARQUEADAS', 'key': 'CEJAS ARQUEADAS'},
    {'label': 'PLIEGUE EPICANTICO', 'key': 'PLIEGUE EPICANTICO'},
    {'label': 'PATRON ESTELAR DEL IRIS', 'key': 'PATRON ESTELAR DEL IRIS'},
    {'label': 'PUENTE NASAL DEPRIMIDO', 'key': 'PUENTE NASAL DEPRIMIDO'},
    {'label': 'NARIZ CORTA NARINAS ANTEVERTIDAS', 'key': 'NARIZ CORTA NARINAS ANTEVERTIDAS'},
    {'label': 'PUNTA NASAL ANCHA O BULBOSA', 'key': 'PUNTA NASAL ANCHA O BULBOSA'},
    {'label': 'MEJILLAS PROMINENTES', 'key': 'MEJILLAS PROMINENTES'},
    {'label': 'REGION MALAR PLANA', 'key': 'REGION MALAR PLANA'},
    {'label': 'FILTRUM LARGO', 'key': 'FILTRUM LARGO'},
    {'label': 'LABIOS GRUESOS', 'key': 'LABIOS GRUESOS'},
    {'label': 'DIENTES PEQUEÑOS O ESPACIADOS', 'key': 'DIENTES PEQUEÑOS O ESPACIADOS'},
    {'label': 'PALADAR ALTO Y OJIVAL', 'key': 'PALADAR ALTO Y OJIVAL'},
    {'label': 'BOCA AMPLIA', 'key': 'BOCA AMPLIA'},
    {'label': 'PABELLONES AURICULARES GRANDES', 'key': 'PABELLONES AURICULARES GRANDES'},
    {'label': 'CARDIOPATIA CONGENITA', 'key': 'CARDIOPATIA CONGENITA'},
    {'label': 'ESTENOSIS SUPRAVALVULAR AORTICA', 'key': 'ESTENOSIS SUPRAVALVULAR AORTICA'},
    {'label': 'ESTENOSIS PULMONAR', 'key': 'ESTENOSIS PULMONAR'},
    {'label': 'OTRA CARDIOPATIA', 'key': 'OTRA CARDIOPATIA'},
    {'label': 'OTRAS ALTERACIONES', 'key': 'OTRAS ALTERACIONES'},
    {'label': 'VOZ DISFONICA', 'key': 'VOZ DISFONICA'},
    {'label': 'TRASTORNO TIROIDEO', 'key': 'TRASTORNO TIROIDEO'},
    {'label': 'TRASTORNO DE LA REFRACCION', 'key': 'TRASTORNO DE LA REFRACCION'},
    {'label': 'HERNIA', 'key': 'HERNIA'},
    {'label': 'ORQUIDOPEXIA', 'key': 'ORQUIDOPEXIA'},
    {'label': 'SINOSTOSIS RADIOCUBITAL', 'key': 'SINOSTOSIS RADIOCUBITAL'},
    {'label': 'HIPERLAXITUD ARTICULAR', 'key': 'HIPERLAXITUD ARTICULAR'},
    {'label': 'ANTECEDENTE DE ORQUIDOPEXIA', 'key': 'ANTECEDENTE DE ORQUIDOPEXIA'},
    {'label': 'ESCOLIOSIS', 'key': 'ESCOLIOSIS'},
    {'label': 'HIPERCALCEMIA', 'key': 'HIPERCALCEMIA'},
    {'label': 'RETRASO EN EL DESARROLLO PSICOMOTOR', 'key': 'RETRASO EN EL DESARROLLO PSICOMOTOR'},
    {'label': 'DÉFICIT COGNITIVO', 'key': 'DÉFICIT COGNITIVO'},
    {'label': 'PERSONALIDAD SOCIAL EXTREMA', 'key': 'PERSONALIDAD SOCIAL EXTREMA'},
    {'label': 'TRASTORNOS DEL APRENDIZAJE', 'key': 'TRASTORNOS DEL APRENDIZAJE'},
    {'label': 'ANSIEDAD O FOBIAS', 'key': 'ANSIEDAD O FOBIAS (Sonidos fuertes, lugares cerrados, separación, etc.)'},
    {'label': 'PROBLEMAS DEL SUEÑO', 'key': 'PROBLEMAS DEL SUEÑO (Insomnio, despertares nocturnos)'},
    {'label': 'GENÉTICA CONFIRMADA', 'key': 'GENÉTICA CONFIRMADA (Deleción 7q11.23 / Sin análisis)'},
    {'label': 'ESTUDIO MOLECULAR CONFIRMATORIO', 'key': 'ESTUDIO MOLECULAR CONFIRMATORIO'},
    {'label': 'HIPOACUSIA', 'key': 'HIPOACUSIA'},
    {'label': 'HIPERSENSIBILIDAD AUDITIVA', 'key': 'HIPERSENSIBILIDAD AUDITIVA (HIPERACUSIA)'},
    {'label': 'ALTERACIONES VISUALES', 'key': 'ALTERACIONES VISUALES (Miopía, astigmatismo, estrabismo)'},
    {'label': 'ALTERACIONES HORMONALES', 'key': 'ALTERACIONES HORMONALES (Pubertad tardía, alteraciones tiroideas adicionales)'},
    {'label': 'DIABETES INFANTIL', 'key': 'DIABETES INFANTIL O INTOLERANCIA A LA GLUCOSA'},
    {'label': 'DÉFICIT DE CRECIMIENTO', 'key': 'DÉFICIT DE CRECIMIENTO'},
  ];

  final Map<String, String> infoTexts = {
    
    'TALLA/EDAD (ACTUAL)_0': 'Evaluar la proporción entre la talla y la edad del paciente. Valorar desviaciones significativas.',
    'Peso al nacer/edad gestacional_0': 'Importancia de evaluar el peso al nacer para identificar posibles riesgos tempranos.',
    'SEXO': 'Seleccione el sexo del paciente, ya que ciertas características pueden variar.',
    'CARACTERISTICAS FACIALES': 'Observar y registrar características faciales distintivas del síndrome de Williams.',
    'DÉFICIT COGNITIVO': 'Evaluar posibles déficits cognitivos asociados con el síndrome.',
    // Continúa agregando más claves y descripciones como necesites
    'TALLA/EDAD (ACTUAL)_Alto': 'Indica una estatura superior a la media para la edad del paciente.',
    'TALLA/EDAD (ACTUAL)_Bajo': 'Indica una estatura inferior a la media para la edad del paciente.',
    'TALLA/EDAD (ACTUAL)_Normal': 'Estatura dentro del rango normal para la edad del paciente.',
    'Peso al nacer/edad gestacional_Adecuado': 'Peso al nacer proporcional a la edad gestacional.',
    'Peso al nacer/edad gestacional_Alto': 'Peso al nacer superior al promedio para la edad gestacional.',
    'Peso al nacer/edad gestacional_Bajo': 'Peso al nacer inferior al promedio para la edad gestacional.',
    'PESO': 'Registrar el peso actual del paciente.',
    'EDAD': 'Registrar la edad actual del paciente.',
    'BAJO PESO AL NACER': 'Indicar si el paciente tuvo un peso bajo al nacer.',
    'TALLA/EDAD (ACTUAL).1': 'Información adicional sobre la talla en relación con la edad.',
    'PESO/EDAD (ACTUAL)': 'Evaluar el peso en relación con la edad actual del paciente.',
    'RDPM / DISCAPACIDAD INTELECTUAL': 'Revisar retraso en el desarrollo psicomotor y/o presencia de discapacidad intelectual.',
    'DEPRESION BITEMPORAL': 'Verificar si hay depresión en las sienes, un signo físico posible.',
    'CEJAS ARQUEADAS': 'Identificar si las cejas presentan una forma arqueada distintiva.',
    'PLIEGUE EPICANTICO': 'Presencia de pliegues en la esquina interna de los ojos.',
    'PATRON ESTELAR DEL IRIS': 'Buscar patrones inusuales en el iris del ojo.',
    'PUENTE NASAL DEPRIMIDO': 'Observar si el puente nasal es más bajo de lo normal.',
    'NARIZ CORTA NARINAS ANTEVERTIDAS': 'Nariz visualmente corta con narinas que apuntan hacia adelante.',
    'PUNTA NASAL ANCHA O BULBOSA': 'Nariz con punta ancha o bulbosa.',
    'MEJILLAS PROMINENTES': 'Cheques visiblemente destacadas.',
    'REGION MALAR PLANA': 'Plano en la región de los pómulos.',
    'FILTRUM LARGO': 'Distancia inusualmente larga entre la nariz y el labio superior.',
    'LABIOS GRUESOS': 'Labios más gruesos de lo habitual.',
    'DIENTES PEQUEÑOS O ESPACIADOS': 'Dientes anormalmente pequeños o con espacios entre ellos.',
    'PALADAR ALTO Y OJIVAL': 'Paladar inusualmente alto y en forma de arco.',
    'BOCA AMPLIA': 'Anomalía caracterizada por una boca más ancha de lo normal.',
    'PABELLONES AURICULARES GRANDES': 'Orejas más grandes de lo normal.',
    'CARDIOPATIA CONGENITA': 'Presencia de una condición cardíaca presente desde el nacimiento.',
    'ESTENOSIS SUPRAVALVULAR AORTICA': 'Estrechamiento de la válvula aórtica del corazón.',
    'ESTENOSIS PULMONAR': 'Estrechamiento de la válvula pulmonar que afecta el flujo sanguíneo al pulmón.',
    'OTRA CARDIOPATIA': 'Cualquier otra condición cardíaca no especificada anteriormente.',
    'OTRAS ALTERACIONES': 'Cualquier otra alteración no especificada en las categorías anteriores.',
    'VOZ DISFONICA': 'Anomalías en el tono o la calidad de la voz.',
    'TRASTORNO TIROIDEO': 'Problemas relacionados con la glándula tiroides.',
    'TRASTORNO DE LA REFRACCION': 'Irregularidades en la refracción ocular como la miopía o el astigmatismo.',
    'HERNIA': 'Presencia de hernia.',
    'ORQUIDOPEXIA': 'Cirugía para corregir testículos no descendidos.',
    'SINOSTOSIS RADIOCUBITAL': 'Fusión anormal de los huesos del antebrazo.',
    'HIPERLAXITUD ARTICULAR': 'Movilidad articular excesiva.',
    'ANTECEDENTE DE ORQUIDOPEXIA': 'Indicar si se ha realizado previamente una orquidopexia.',
    'ESCOLIOSIS': 'Presencia de curvatura anormal en la columna vertebral.',
    'HIPERCALCEMIA': 'Niveles elevados de calcio en sangre.',
    'RETRASO EN EL DESARROLLO PSICOMOTOR': 'Retardo en alcanzar hitos del desarrollo motor y cognitivo.',
    'PERSONALIDAD SOCIAL EXTREMA': 'Tendencia a comportamientos extremadamente sociables o retraídos.',
    'TRASTORNOS DEL APRENDIZAJE': 'Dificultades con habilidades específicas de aprendizaje.',
    'ANSIEDAD O FOBIAS': 'Presencia de ansiedad significativa o fobias específicas.',
    'PROBLEMAS DEL SUEÑO': 'Dificultades para iniciar o mantener el sueño.',
    'GENÉTICA CONFIRMADA': 'Confirmación genética de una condición específica, como una deleción en el cromosoma.',
    'ESTUDIO MOLECULAR CONFIRMATORIO': 'Pruebas adicionales para confirmar diagnósticos a nivel molecular.',
    'HIPOACUSIA': 'Reducción en la capacidad auditiva.',
    'HIPERSENSIBILIDAD AUDITIVA': 'Sensibilidad excesiva a los sonidos.',
    'ALTERACIONES VISUALES': 'Problemas visuales como la miopía, el astigmatismo o el estrabismo.',
    'ALTERACIONES HORMONALES': 'Problemas con la regulación hormonal, incluyendo la pubertad tardía o problemas tiroideos.',
    'DIABETES INFANTIL O INTOLERANCIA A LA GLUCOSA': 'Presencia de diabetes o problemas con el manejo de la glucosa.',
    'DÉFICIT DE CRECIMIENTO': 'Crecimiento por debajo de lo esperado para la edad y condiciones genéticas.'

  };

  String? resultado;
  double? probabilidad;
  int _currentCardIndex = 0;

  Future<void> _enviarFormulario() async {
    const url = 'http://10.162.67.75:5000/predict'; // Change this to your local IP
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(_formData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          resultado = data['diagnostico'];
          probabilidad = data['probabilidad'];
        });
      } else {
        setState(() => resultado = 'Error en la predicción');
      }
    } catch (e) {
      setState(() => resultado = 'Error de conexión: $e');
    }
  }

  void _setAnswer(String key, int value) {
    setState(() {
      _formData[key] = value;
      if (_currentCardIndex < _keys.length - 1) {
        _currentCardIndex++;
        _scrollToNextQuestion();
      }
    });
  }

  final List<GlobalKey> _keys = List.generate(100, (index) => GlobalKey());

  void _scrollToNextQuestion() {
    final context = _keys[_currentCardIndex].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        alignment: 0.5,
      );
    }
  }

  Widget _buildCard(Map<String, String> campo, bool isActive, int index) {
    String respuesta = _formData[campo['key']!] == 1 ? 'Sí' : (_formData[campo['key']!] == 0 ? 'No' : '');
    String infoText = infoTexts[campo['key']] ?? "No hay información disponible";

    return AnimatedContainer(
      key: _keys[index],
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      height: isActive ? 280 : 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isActive ? Colors.blueAccent : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              campo['label']!,
              style: TextStyle(
                fontSize: 20,
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isActive) ...[
              QuestionInfo(infoText: infoText),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    heroTag: "yesBtn$index",
                    onPressed: () => _setAnswer(campo['key']!, 1),
                    child: const Icon(Icons.check),
                    backgroundColor: Colors.green,
                    elevation: 5,
                  ),
                  const SizedBox(width: 30),
                  FloatingActionButton(
                    heroTag: "noBtn$index",
                    onPressed: () => _setAnswer(campo['key']!, 0),
                    child: const Icon(Icons.close),
                    backgroundColor: Colors.red,
                    elevation: 5,
                  ),
                ],
              ),
            ],
            if (!isActive && respuesta.isNotEmpty) ...[
              const SizedBox(height: 15),
              Text(
                'Respuesta: $respuesta',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ],
        ),
      ),
    );
  }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: "Predictividad Williams",
        backgroundColor: Colors.blueAccent,
        color: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (int index = 0; index < campos.length; index++)
                _buildCard(campos[index], index == _currentCardIndex, index),
              ElevatedButton(
                onPressed: () {
                  _enviarFormulario();  // Siempre activo, sin verificación
                },
                child: const Text("Enviar Predicción"),
              ),
              if (resultado != null) ...[
                const SizedBox(height: 20),
                Text("Resultado: $resultado", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (probabilidad != null)
                  Text("Probabilidad: ${(probabilidad! * 100).toStringAsFixed(2)}%"),
              ],
            ],
          ),
        ),
      ),
    );
  }

}
