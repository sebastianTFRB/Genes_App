import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FenotipoWilliamsScreen extends StatelessWidget {
  const FenotipoWilliamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Fenotipo - Síndrome de Williams",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.greenAccent.shade400,
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
                          "assets/images/williams/WS2.png",
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/williams/WS2.png",
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
                  "El fenotipo del Síndrome de Williams incluye una combinación de rasgos físicos, faciales y del desarrollo que, aunque varían en intensidad, son lo suficientemente distintivos como para guiar la sospecha clínica inicial. Este conjunto de características tiende a hacerse más evidente con la edad, por lo cual su reconocimiento temprano es fundamental en la atención pediátrica y general.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),

              _buildFeatureCard(
                context,
                "Rostro de duende",
                "Frente amplia, nariz corta y respingada, labios gruesos, boca grande con comisuras caídas.",
                "assets/images/williams/WS3.webp",
              ),
              _buildFeatureCard(
                context,
                "Ojos",
                "Iris estrellado especialmente en niños con ojos claros, con pliegue epicántico leve.",
                "assets/images/williams/WS4.jpeg",
              ),
              _buildFeatureCard(
                context,
                "Dientes",
                "Hipodoncia, maloclusión dental y esmalte deficiente.",
                "assets/images/williams/WS5.jpg",
              ),
              _buildFeatureCard(
                context,
                "Cabello",
                "Ondulado, fino y de textura suave.",
                "assets/images/williams/WS6.jpg",
              ),
              _buildFeatureCard(
                context,
                "Talla",
                "Baja en relación a la edad, visible en los controles pediátricos.",
                "assets/images/williams/WS7.webp",
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
                  "Además de los rasgos faciales y corporales clásicos, el paciente con Síndrome de Williams puede presentar otras características relevantes, especialmente a medida que crece:",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              const BulletPoint("Hipotonía muscular en la infancia."),
              const BulletPoint(
                "Tendencia a contracturas articulares o rigidez en la adolescencia.",
              ),
              const BulletPoint("Hipermovilidad articular en extremidades."),
              const BulletPoint("Hernias umbilicales o inguinales."),
              const BulletPoint("Tórax en quilla o excavatum."),
              const BulletPoint("Presencia de piel suave y laxa."),

              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "La identificación temprana del fenotipo característico permite orientar el diagnóstico clínico del Síndrome de Williams incluso antes de realizar pruebas genéticas. Reconocer estos signos facilita la derivación oportuna al especialista, el tamizaje de comorbilidades (especialmente cardiovasculares) y el inicio de un manejo multidisciplinario integral.",
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
                      color: Colors.green,
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
