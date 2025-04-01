import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class NeurologicoMpsScreen extends StatelessWidget {
  const NeurologicoMpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Neurológico - Mucopolisacaridosis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple,
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
                    onTap: () => _openImageFullScreen(
                      context,
                      "assets/images/muco/8.webp",
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/muco/8.webp",
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
                  "Manifestaciones Neurológicas",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "Las mucopolisacaridosis afectan progresivamente el sistema nervioso central y periférico, especialmente en los subtipos con mayor compromiso neurológico como MPS I (Hurler), MPS II severa (Hunter), y MPS III (Sanfilippo). Estas manifestaciones pueden presentarse desde los primeros años de vida y empeorar con el tiempo.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              const BulletPoint("Retraso global del desarrollo psicomotor."),
              const BulletPoint("Discapacidad intelectual progresiva, especialmente en MPS III."),
              const BulletPoint("Convulsiones en etapas avanzadas."),
              const BulletPoint("Hidrocefalia comunicante o por obstrucción de flujo.",),
              const BulletPoint("Compresión medular cervical por engrosamiento de ligamentos y vértebras."),
              const BulletPoint("Alteraciones en la audición (conductiva o neurosensorial)."),
              const BulletPoint("Trastornos del sueño y cambios conductuales en etapas avanzadas."),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "La progresión neurológica varía según el tipo de MPS. Algunos pacientes pueden conservar habilidades cognitivas estables si reciben diagnóstico y tratamiento temprano, mientras que otros evolucionan rápidamente hacia deterioro severo. El seguimiento por neuropediatría, fisioterapia, fonoaudiología y psicología es fundamental para mantener la mejor calidad de vida posible.",
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
