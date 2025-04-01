import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ManejoMpsScreen extends StatelessWidget {
  const ManejoMpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Manejo - Mucopolisacaridosis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.teal,
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
                          "assets/images/muco/12.webp",
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/muco/12.webp",
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
                  "Manejo y Tratamiento",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "El tratamiento de las mucopolisacaridosis debe ser integral, enfocado tanto en el tratamiento específico como en el manejo sintomático de las manifestaciones multisistémicas. La atención multidisciplinaria es fundamental para mejorar la calidad de vida del paciente.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              const BulletPoint(
                "Terapia de reemplazo enzimático (TRE): disponible para MPS I, II, IVA y VI. Administra la enzima faltante por vía intravenosa semanalmente.",
              ),
              const BulletPoint(
                "Trasplante de células hematopoyéticas: opción en MPS I (Hurler) en etapas tempranas, especialmente si hay compromiso neurológico.",
              ),
              const BulletPoint(
                "Fisioterapia y rehabilitación: mejora la movilidad, previene contracturas y optimiza la funcionalidad física.",
              ),
              const BulletPoint(
                "Cirugías ortopédicas, cardiacas o de vía aérea según complicaciones estructurales.",
              ),
              const BulletPoint(
                "Manejo respiratorio: incluye oxigenoterapia, CPAP en apnea del sueño y tratamiento de infecciones respiratorias.",
              ),
              const BulletPoint(
                "Soporte psicológico y educativo: apoyo emocional, adaptación escolar y entrenamiento para cuidadores.",
              ),
              const BulletPoint(
                "Asesoría genética para padres y familiares, especialmente en planificación familiar y diagnóstico prenatal.",
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Aunque las MPS no tienen cura definitiva, un manejo temprano y continuo puede reducir significativamente el deterioro funcional, prolongar la esperanza de vida y favorecer una mejor inclusión social del paciente.",
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
