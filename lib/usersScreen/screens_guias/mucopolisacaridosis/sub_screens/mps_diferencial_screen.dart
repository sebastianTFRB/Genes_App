import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DiagnosticoDiferencialMpsScreen extends StatelessWidget {
  const DiagnosticoDiferencialMpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Diagnóstico Diferencial - Mucopolisacaridosis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
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
                          "assets/images/diferencial_mps.jpg",
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/diferencial_mps.jpg",
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
                  "Diagnóstico Diferencial",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "Debido a la naturaleza multisistémica de las mucopolisacaridosis, existen múltiples entidades clínicas que pueden compartir características similares. Es esencial realizar un diagnóstico diferencial adecuado para evitar retrasos en la identificación precisa del tipo de enfermedad de depósito lisosomal.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              const BulletPoint(
                "Síndrome de Hurler vs Hunter: similares en manifestaciones, pero Hunter (MPS II) no presenta opacidad corneal y es ligado a X.",
              ),
              const BulletPoint(
                "Displasias esqueléticas (ej. displasia espóndilo-epifisaria): comparten talla baja y alteraciones óseas, pero sin facies tosca ni compromiso multiorgánico.",
              ),
              const BulletPoint(
                "Síndrome de Morquio (MPS IV) vs acondroplasia: ambos con anomalías óseas severas, pero Morquio tiene compromiso valvular y otras manifestaciones sistémicas.",
              ),
              const BulletPoint(
                "Síndrome de Sanfilippo (MPS III) vs trastornos del espectro autista: ambos con alteraciones conductuales, pero MPS III presenta deterioro cognitivo progresivo y hallazgos físicos evidentes.",
              ),
              const BulletPoint(
                "Enfermedad de Gaucher o Niemann-Pick: enfermedades lisosomales con hepatoesplenomegalia, pero sin disostosis múltiple típica de MPS.",
              ),
              const BulletPoint(
                "Síndromes genéticos con rasgos faciales: como el Síndrome de Down, que puede compartir rasgos faciales, pero con cariotipo 47,XX+21/47,XY+21.",
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "La diferenciación adecuada se logra combinando la evaluación clínica experta con estudios de imagen, análisis enzimáticos, genéticos y bioquímicos. Un diagnóstico preciso es la base para brindar el tratamiento y seguimiento adecuados a cada paciente.",
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
