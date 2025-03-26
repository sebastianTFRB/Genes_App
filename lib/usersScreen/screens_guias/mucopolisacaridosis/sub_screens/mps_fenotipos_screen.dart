import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FenotipoMpsScreen extends StatelessWidget {
  const FenotipoMpsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Fenotipo - Mucopolisacaridosis",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown,
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
                      "assets/images/fenotipo_mps.jpg",
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/fenotipo_mps.jpg",
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
                  "Características Faciales y Corporales",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "El fenotipo en las Mucopolisacaridosis incluye una combinación de rasgos faciales toscos, talla baja, deformidades esqueléticas y compromiso multiorgánico progresivo. Estas características suelen volverse más evidentes con el tiempo, permitiendo orientar la sospecha clínica desde etapas tempranas.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              _buildFeatureCard(
                context,
                "Facies tosca",
                "Frente prominente, labios gruesos, nariz ancha con puente nasal deprimido, mejillas llenas.",
                "assets/images/facies_mps.jpg",
              ),
              _buildFeatureCard(
                context,
                "Talla baja",
                "Talla baja desproporcionada, más evidente con el crecimiento.",
                "assets/images/talla_baja_mps.jpg",
              ),
              _buildFeatureCard(
                context,
                "Deformidades óseas",
                "Cifosis, escoliosis, genu valgo y disostosis múltiple.",
                "assets/images/oseas_mps.jpg",
              ),
              _buildFeatureCard(
                context,
                "Rigidez articular",
                "Pérdida progresiva de movilidad, contracturas y limitación de la extensión.",
                "assets/images/rigidez_mps.jpg",
              ),
              _buildFeatureCard(
                context,
                "Hepatoesplenomegalia",
                "Aumento de tamaño del hígado y bazo palpable al examen físico.",
                "assets/images/hepatomegalia_mps.jpg",
              ),
              const SizedBox(height: 30),
              FadeInLeft(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Otras características fenotípicas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: const Text(
                  "Además de los rasgos faciales y físicos clásicos, los pacientes con MPS pueden presentar:",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              const BulletPoint("Cuello corto y ancho."),
              const BulletPoint("Hernias umbilicales o inguinales."),
              const BulletPoint("Piel engrosada o áspera."),
              const BulletPoint("Hipertricosis (exceso de vello)."),
              const BulletPoint("Tórax en quilla o pectus excavatum."),
              const BulletPoint("Cabello grueso y rizado en algunos casos."),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El reconocimiento del fenotipo característico en las mucopolisacaridosis permite iniciar un estudio diagnóstico temprano, especialmente ante la presencia de múltiples hallazgos físicos inexplicables. Esto es esencial para la derivación oportuna a genética médica y el inicio de un enfoque terapéutico integral.",
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

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    String imagePath,
  ) {
    return FadeInRight(
      duration: const Duration(milliseconds: 800),
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.white, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _openImageFullScreen(context, imagePath),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                child: Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
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
