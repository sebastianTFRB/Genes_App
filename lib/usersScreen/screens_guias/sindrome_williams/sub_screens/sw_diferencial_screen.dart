import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class DiagnosticoDiferencialScreen extends StatelessWidget {
  const DiagnosticoDiferencialScreen({super.key});

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
                      "assets/images/diferencial.jpg",
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
                  "Diagnóstico Diferencial del Síndrome de Williams",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El diagnóstico del Síndrome de Williams puede confundirse con otros síndromes genéticos que presentan características clínicas similares. Por ello, es esencial considerar estos diagnósticos diferenciales para brindar una atención precisa.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 25),
              _buildDifferential(
                title: "1. Síndrome de Noonan",
                description:
                    "- Rasgos faciales similares: hipertelorismo, ptosis y orejas de implantación baja.\n"
                    "- Retraso en el crecimiento y cardiopatías (principalmente estenosis pulmonar).\n"
                    "- Ausencia de la deleción 7q11.23.\n"
                    "- Diagnóstico mediante secuenciación de genes como PTPN11, SOS1, KRAS.",
              ),
              _buildDifferential(
                title: "2. Síndrome de Smith-Magenis",
                description:
                    "- Retraso del desarrollo, alteraciones del sueño y trastornos de conducta marcados.\n"
                    "- Deleción en 17p11.2 o mutación en el gen RAI1.\n"
                    "- Facies diferentes a las del SW.\n"
                    "- Trastornos del habla con lenguaje más afectado que en SW.",
              ),
              _buildDifferential(
                title: "3. Síndrome de Down",
                description:
                    "- Trisomía 21 confirmada genéticamente.\n"
                    "- Retraso en el desarrollo y discapacidad intelectual variable.\n"
                    "- Rasgos faciales distintos: puente nasal plano, pliegue epicántico, macroglosia.\n"
                    "- Hipotonía generalizada desde el nacimiento.",
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
                  "La comparación clínica y el respaldo genético son fundamentales para distinguir el SW de otros síndromes similares. Una evaluación multidisciplinaria y el uso de pruebas moleculares adecuadas permiten confirmar el diagnóstico preciso.",
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
