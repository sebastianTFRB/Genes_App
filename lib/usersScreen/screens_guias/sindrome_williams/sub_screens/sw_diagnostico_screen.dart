import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DiagnosticoScreen extends StatelessWidget {
  const DiagnosticoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Diagnóstico del Síndrome de Williams",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FadeIn(
                    duration: const Duration(milliseconds: 600),
                    child: Image.asset(
                      "assets/images/williams/williams-4.webp",
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "¿Cómo se diagnostica el Síndrome de Williams?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El diagnóstico se basa en la combinación de hallazgos clínicos sugestivos y pruebas genéticas confirmatorias. Una detección temprana permite iniciar un manejo adecuado y seguimiento integral.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 20),

              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: const Text(
                  "1. Evaluación Clínica Inicial",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              FadeInUp(
                duration: const Duration(milliseconds: 950),
                child: const Text(
                  "• Rasgos faciales característicos (rostro de duende).\n"
                  "• Historia de retraso del desarrollo y dificultades cognitivas.\n"
                  "• Hipercalcemia en la infancia.\n"
                  "• Alteraciones cardiovasculares: soplos, estenosis supravalvular aórtica, hipertensión.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 20),

              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: const Text(
                  "2. Pruebas Genéticas",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              FadeInUp(
                duration: const Duration(milliseconds: 1050),
                child: const Text(
                  "• FISH: Detecta deleciones específicas en la región 7q11.23.\n"
                  "• MLPA: Evalúa múltiples deleciones con mayor precisión.\n"
                  "• Microarrays CGH: Mayor resolución para confirmar el diagnóstico.\n"
                  "• Secuenciación genómica: Útil en casos atípicos o para diagnóstico diferencial.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1100),
                child: const Text(
                  "3. Asesoramiento Genético",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              FadeInUp(
                duration: const Duration(milliseconds: 1150),
                child: const Text(
                  "Una vez confirmado el diagnóstico, es clave brindar orientación a la familia sobre el pronóstico, manejo, implicaciones hereditarias y necesidad de evaluar otros miembros en caso de sospecha de mosaicismo o antecedentes similares.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: const Text(
                  "¿Cuándo sospechar del Síndrome de Williams?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              FadeInUp(
                duration: const Duration(milliseconds: 1250),
                child: const Text(
                  "• Niño con rasgos faciales distintivos y personalidad muy sociable.\n"
                  "• Presencia de soplo cardíaco desde la infancia.\n"
                  "• Retraso en el desarrollo psicomotor y lenguaje precozmente expresivo.\n"
                  "• Historia de hipercalcemia idiopática.\n"
                  "• Antecedentes familiares o hallazgos genéticos sospechosos.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
