import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DiagnosticoDownScreen extends StatelessWidget {
  const DiagnosticoDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Diagnóstico del Síndrome de Down",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
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
                      "assets/images/diagnostico_down.jpg",
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
                  "¿Cómo se diagnostica el Síndrome de Down?",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El diagnóstico del Síndrome de Down se basa en la observación clínica de características físicas típicas y se confirma con estudios genéticos. La identificación precoz permite una atención médica integral desde el nacimiento.",
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
                  "• Rasgos físicos sugestivos como hipotonía, pliegue palmar único, cuello corto, entre otros.\n"
                  "• Historia de retraso en el desarrollo psicomotor.\n"
                  "• Identificación prenatal de translucencia nucal aumentada o marcadores ecográficos.",
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
                  "• Cariotipo estándar: identifica trisomía 21 libre, translocación o mosaicismo.\n"
                  "• FISH: prueba rápida para confirmar trisomía 21 en neonatos.\n"
                  "• Microarrays o MLPA: en casos complejos o con sospecha de otras alteraciones.\n"
                  "• Pruebas prenatales: ADN fetal libre, biopsia corial o amniocentesis para confirmación.",
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
                  "Es fundamental brindar información clara y apoyo emocional a la familia. También se recomienda realizar cariotipo a los padres si se confirma una translocación cromosómica, para evaluar riesgo de recurrencia en futuros embarazos.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: const Text(
                  "¿Cuándo sospechar del Síndrome de Down?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 6),
              FadeInUp(
                duration: const Duration(milliseconds: 1250),
                child: const Text(
                  "• Recién nacido con fenotipo característico e hipotonía.\n"
                  "• Hallazgos prenatales como translucencia nucal aumentada.\n"
                  "• Historia familiar de síndrome de Down o anomalías cromosómicas.\n"
                  "• Presencia de cardiopatía congénita al nacimiento.",
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
