import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CardiopulmonarMpsScreen extends StatelessWidget {
  const CardiopulmonarMpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Cardiopulmonar - Mucopolisacaridosis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,
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
                          "assets/images/muco/9.webp",
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/muco/9.webp",
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
                  "Compromiso Cardiopulmonar",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "Las mucopolisacaridosis pueden afectar el corazón y los pulmones de forma progresiva. El depósito de glicosaminoglicanos en tejidos blandos, válvulas cardiacas y vías respiratorias genera síntomas que requieren vigilancia médica continua. La afectación respiratoria suele ser temprana y persistente, mientras que la cardíaca puede pasar desapercibida inicialmente.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              const BulletPoint(
                "Engrosamiento valvular mitral y aórtico, con insuficiencia progresiva.",
              ),
              const BulletPoint("Cardiomiopatía hipertrófica o restrictiva."),
              const BulletPoint("Hipertrofia ventricular izquierda."),
              const BulletPoint("Arritmias en etapas avanzadas."),
              const BulletPoint(
                "Apnea del sueño por obstrucción de la vía aérea superior.",
              ),
              const BulletPoint(
                "Infecciones respiratorias frecuentes (sinusitis, otitis, neumonía).",
              ),
              const BulletPoint(
                "Ruidos respiratorios anormales: estridor, ronquidos, sibilancias.",
              ),
              const BulletPoint(
                "Tórax estrecho y rigidez costal que limita la expansión pulmonar.",
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El seguimiento por cardiología y neumología es indispensable. Las evaluaciones con ecocardiograma, electrocardiograma, estudios del sueño y espirometría permiten detectar complicaciones precozmente. La atención temprana mejora el pronóstico y reduce el riesgo de insuficiencia cardíaca o respiratoria.",
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
