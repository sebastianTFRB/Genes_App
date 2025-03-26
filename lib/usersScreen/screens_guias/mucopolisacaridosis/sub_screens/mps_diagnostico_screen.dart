import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DiagnosticoMpsScreen extends StatelessWidget {
  const DiagnosticoMpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Diagnóstico - Mucopolisacaridosis",
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
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Center(
                  child: GestureDetector(
                    onTap:
                        () => _openImageFullScreen(
                          context,
                          "assets/images/diagnostico_mps.jpg",
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/diagnostico_mps.jpg",
                        height: 220,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInLeft(
                duration: const Duration(milliseconds: 600),
                child: const Text(
                  "Diagnóstico de las Mucopolisacaridosis",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "El diagnóstico de las MPS se basa en la sospecha clínica por la presencia de signos característicos y se confirma con estudios bioquímicos y moleculares. Una evaluación completa permite establecer el tipo específico de MPS, lo cual es clave para orientar el tratamiento y el pronóstico.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              const BulletPoint(
                "Historia clínica detallada con énfasis en signos físicos, desarrollo y antecedentes familiares.",
              ),
              const BulletPoint(
                "Evaluación física completa buscando rasgos fenotípicos y signos multiorgánicos.",
              ),
              const BulletPoint(
                "Radiografías óseas: evidencian disostosis múltiple y alteraciones esqueléticas específicas.",
              ),
              const BulletPoint(
                "Análisis de orina para detectar excreción elevada de glicosaminoglicanos (GAGs).",
              ),
              const BulletPoint(
                "Estudios enzimáticos en leucocitos o fibroblastos para identificar la enzima deficiente.",
              ),
              const BulletPoint(
                "Pruebas genéticas moleculares para confirmar el tipo de MPS y asesorar a la familia.",
              ),
              const BulletPoint(
                "Tamizaje en hermanos o familiares cercanos si hay diagnóstico confirmado en el entorno familiar.",
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El diagnóstico temprano es crucial para iniciar a tiempo terapias específicas, como el reemplazo enzimático, y prevenir complicaciones irreversibles. El trabajo conjunto entre pediatría, genética, y especialistas es esencial para una atención integral.",
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openImageFullScreen(BuildContext context, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageView(imagePath: imagePath),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imagePath;

  const FullScreenImageView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Vista de imagen"),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 1,
          maxScale: 4,
          child: Image.asset(imagePath),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
