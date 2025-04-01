import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class FenotipoDownScreen extends StatelessWidget {
  const FenotipoDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Fenotipo - Síndrome de Down",
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
                    onTap: () => _openImageFullScreen(
                      context,
                      "assets/images/down/Simone-Down-syndrome-1.webp",
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/down/Simone-Down-syndrome-1.webp",
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
                  "El fenotipo del Síndrome de Down es característico y puede ser reconocido desde el nacimiento. Estas características físicas ayudan a orientar el diagnóstico clínico y deben ser evaluadas cuidadosamente por el equipo médico.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),

              _buildFeatureCard(
                context,
                "Rostro y cabeza",
                "Rostro redondo, perfil plano, puente nasal deprimido y cuello corto con pliegue nucal.",
                "assets/images/down/Down-Syndrome-1.webp",
              ),
              _buildFeatureCard(
                context,
                "Ojos",
                "Fisuras palpebrales oblicuas, epicanto y manchitas de Brushfield en el iris.",
                "assets/images/down/Down-Syndrome-2.webp",
              ),
              _buildFeatureCard(
                context,
                "Lengua y boca",
                "Lengua protruyente y macroglosia aparente; boca pequeña con labios delgados.",
                "assets/images/down/Down-Syndrome-14.webp",
              ),
              _buildFeatureCard(
                context,
                "Manos",
                "Manos cortas y anchas con pliegue palmar único y dedos cortos.",
                "assets/images/down/Down-Syndrome-16.webp",
              ),
              _buildFeatureCard(
                context,
                "Tono muscular",
                "Hipotonía generalizada, especialmente evidente en el período neonatal.",
                "assets/images/down/Down-Syndrome-31.webp",
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
                  "Además de las características mencionadas, los pacientes con Síndrome de Down pueden presentar:",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 20),
              const BulletPoint("Talla baja en la infancia y adolescencia."),
              const BulletPoint("Articulaciones hiperlaxas o hipermovilidad articular."),
              const BulletPoint("Exceso de piel en la nuca, especialmente en neonatos."),
              const BulletPoint("Orejas pequeñas y de implantación baja."),
              const BulletPoint("Alteraciones dentales: erupción tardía, dientes pequeños."),

              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El reconocimiento de estos rasgos fenotípicos desde edades tempranas permite una sospecha clínica oportuna del Síndrome de Down, facilitando el abordaje diagnóstico y terapéutico integral.",
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
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
                      color: Colors.blue,
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
