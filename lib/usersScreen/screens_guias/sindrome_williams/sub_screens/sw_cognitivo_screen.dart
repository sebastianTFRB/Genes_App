import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CognitivoConductualScreen extends StatelessWidget {
  const CognitivoConductualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Perfil Cognitivo y Conductual",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purpleAccent,
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
                    duration: const Duration(milliseconds: 400),
                    child: Image.asset(
                      "assets/images/cognitivo_sindrome_williams.jpg",
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Características Cognitivas y Conductuales",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: const Text(
                  "El perfil cognitivo y conductual del Síndrome de Williams es único. A pesar de tener discapacidad intelectual leve o moderada, presentan un lenguaje expresivo notable y una sociabilidad inusual, caracterizada por una marcada apertura emocional y afectiva hacia los demás.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: const Text(
                  "Aspectos clave por área:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 1100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBullet(
                      "Atención: dificultades en atención sostenida y selectiva.",
                    ),
                    _buildBullet(
                      "Memoria: buena memoria auditiva a corto plazo, dificultades en memoria de trabajo y espacial.",
                    ),
                    _buildBullet(
                      "Lenguaje: fluido, expresivo, con buena entonación. Preservación del vocabulario social.",
                    ),
                    _buildBullet(
                      "Funciones ejecutivas: dificultades en planificación, organización y control de impulsos.",
                    ),
                    _buildBullet(
                      "Sociabilidad: alta, buscan interacción constante y muestran gran empatía emocional.",
                    ),
                    _buildBullet(
                      "Desinhibición social y escasa percepción del peligro.",
                    ),
                    _buildBullet(
                      "Trastornos de ansiedad, fobias específicas y sensibilidad auditiva (hiperacusia).",
                    ),
                    _buildBullet(
                      "Dificultades académicas, especialmente en matemáticas y escritura. La lectura oral puede estar mejor preservada.",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: const Text(
                  "Importancia del acompañamiento",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: const Text(
                  "El seguimiento con neuropsicología, psicopedagogía y psiquiatría es esencial para fomentar el desarrollo global y el bienestar emocional del paciente. La inclusión escolar con adaptaciones curriculares, acompañamiento en habilidades sociales y un entorno estructurado contribuyen significativamente a su calidad de vida.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
