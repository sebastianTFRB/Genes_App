import 'package:flutter/material.dart';
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
    'Peso al nacer/edad gestacional_0': 0,
    'SEXO': 0,
    'CARACTERISTICAS FACIALES': 0,
    'ESTENOSIS SUPRAVALVULAR AORTICA': 0,
    'DÉFICIT COGNITIVO': 0,
  };

  final List<Map<String, String>> campos = [
    {'key': 'TALLA/EDAD (ACTUAL)_0', 'label': 'Talla/Edad (Actual)'},
    {'key': 'Peso al nacer/edad gestacional_0', 'label': 'Peso al nacer/edad gestacional'},
    {'key': 'SEXO', 'label': 'Sexo'},
    {'key': 'CARACTERISTICAS FACIALES', 'label': 'Características Faciales'},
    {'key': 'ESTENOSIS SUPRAVALVULAR AORTICA', 'label': 'Estenosis Supravalvular Aortica'},
    {'key': 'DÉFICIT COGNITIVO', 'label': 'Déficit Cognitivo'},
  ];

  final Map<String, String> infoTexts = {
    'TALLA/EDAD (ACTUAL)_0': 'Evaluar la proporción entre la talla y la edad del paciente. Valorar desviaciones significativas.',
    'Peso al nacer/edad gestacional_0': 'Importancia de evaluar el peso al nacer para identificar posibles riesgos tempranos.',
    'SEXO': 'Seleccione el sexo del paciente, ya que ciertas características pueden variar.',
    'CARACTERISTICAS FACIALES': 'Observar y registrar características faciales distintivas del síndrome de Williams.',
    'ESTENOSIS SUPRAVALVULAR AORTICA': 'Verificar presencia de estenosis supravalvular aórtica, común en pacientes con síndrome de Williams.',
    'DÉFICIT COGNITIVO': 'Evaluar posibles déficits cognitivos asociados con el síndrome.',
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
      appBar: AppBar(
        title: const Text("Predictividad Williams"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (int index = 0; index < campos.length; index++)
                _buildCard(campos[index], index == _currentCardIndex, index),
              const SizedBox(height: 20),
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
