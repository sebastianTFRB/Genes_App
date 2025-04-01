import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CardiovascularDownScreen extends StatelessWidget {
  const CardiovascularDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Cardiovascular - Síndrome de Down",
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
                          "assets/images/down/Grace-DS.webp",
                        ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/down/Grace-DS.webp",
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
                  "Anomalías Cardiovasculares",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "Las cardiopatías congénitas son una de las principales causas de morbilidad y mortalidad en el Síndrome de Down. Su detección precoz y manejo oportuno son fundamentales para mejorar el pronóstico y calidad de vida del paciente.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),

              _buildCardiopathCard(
                context,
                "Canal auriculoventricular común",
                "Es la malformación cardíaca más frecuente en el Síndrome de Down. Consiste en un defecto en el tabique que separa las cavidades cardíacas y afecta tanto las válvulas mitral como tricúspide.",
                "assets/images/canal_av.jpg",
              ),
              _buildCardiopathCard(
                context,
                "Comunicación interventricular o interauricular",
                "Defectos del tabique que separa las cavidades cardíacas, generando flujo anómalo de sangre y riesgo de insuficiencia cardíaca si no se corrige.",
                "assets/images/civ_cia.jpg",
              ),
              _buildCardiopathCard(
                context,
                "Persistencia del conducto arterioso (PCA)",
                "Ocurre cuando el vaso que conecta la aorta con la arteria pulmonar permanece abierto después del nacimiento.",
                "assets/images/pca.jpg",
              ),
              _buildCardiopathCard(
                context,
                "Estenosis de válvula pulmonar",
                "Estrechamiento de la válvula que regula el flujo de sangre del corazón hacia los pulmones.",
                "assets/images/estenosis_pulmonar.jpg",
              ),
              _buildCardiopathCard(
                context,
                "Hipertensión pulmonar",
                "Puede desarrollarse secundaria a cardiopatías no tratadas, con riesgo de daño vascular irreversible.",
                "assets/images/hipertension_pulmonar.jpg",
              ),

              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El tamizaje con ecocardiograma debe realizarse en todos los recién nacidos con Síndrome de Down, idealmente en las primeras semanas de vida. El seguimiento cardiológico periódico es esencial para detectar complicaciones tempranas y planificar intervenciones quirúrgicas si son necesarias.",
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

  Widget _buildCardiopathCard(
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
                      color: Colors.redAccent,
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
