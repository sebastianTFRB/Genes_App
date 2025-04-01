import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DiagnosticoDiferencialDownScreen extends StatelessWidget {
  const DiagnosticoDiferencialDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Diagnóstico Diferencial",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeIn(
                duration: const Duration(milliseconds: 600),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/down/Down-Syndrome-16.webp",
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),

              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "Diagnóstico Diferencial del Síndrome de Down",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Aunque el fenotipo del Síndrome de Down suele ser característico, existen otras condiciones genéticas con características clínicas superpuestas que deben considerarse en el diagnóstico diferencial, especialmente en etapas neonatales o en casos de mosaicismo.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 25),
              _buildDifferential(
                title: "1. Síndrome de Noonan",
                description:
                    "- Facies similares: hipertelorismo, cuello corto, implantación baja de orejas.\n"
                    "- Cardiopatías congénitas (estenosis pulmonar).\n"
                    "- Genética distinta: mutaciones en genes como PTPN11, SOS1, KRAS.",
              ),
              _buildDifferential(
                title: "2. Trisomía 18 (Síndrome de Edwards)",
                description:
                    "- Retraso del crecimiento intrauterino, puños cerrados, malformaciones cardíacas y del sistema nervioso central.\n"
                    "- Alta tasa de mortalidad en el primer año.\n"
                    "- Cariotipo revela trisomía del cromosoma 18.",
              ),
              _buildDifferential(
                title: "3. Síndrome de Williams",
                description:
                    "- Facies diferentes: rostro de duende, boca grande, nariz corta.\n"
                    "- Personalidad extremadamente sociable y lenguaje fluido.\n"
                    "- Deleción 7q11.23 confirmada genéticamente.",
              ),
              _buildDifferential(
                title: "4. Trastornos del espectro autista (TEA)",
                description:
                    "- En algunos casos con discapacidad intelectual e hipotonía.\n"
                    "- Presencia de estereotipias, aislamiento social y dificultades en la comunicación.\n"
                    "- No presentan alteración cromosómica típica.",
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: const Text(
                  "Conclusión",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: const Text(
                  "El diagnóstico diferencial del Síndrome de Down debe apoyarse en un examen físico detallado y pruebas genéticas. La confirmación por cariotipo sigue siendo el estándar de oro para diferenciarlo de otras patologías congénitas y síndromes con características similares.",
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

  Widget _buildDifferential({
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: FadeInUp(
        duration: const Duration(milliseconds: 1000),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
