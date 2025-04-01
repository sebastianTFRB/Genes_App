import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ManejoSindromeDownScreen extends StatelessWidget {
  const ManejoSindromeDownScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Manejo del Síndrome de Down",
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
              FadeIn(
                duration: const Duration(milliseconds: 600),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/down/Down-Syndrome-31.webp",
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "Manejo Multidisciplinario del Síndrome de Down",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: const Text(
                  "El abordaje del Síndrome de Down requiere de un equipo interdisciplinario que acompañe al paciente desde el nacimiento. El objetivo es promover un desarrollo integral, prevenir complicaciones y mejorar la calidad de vida del niño y su familia.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              _buildSpecialty(
                title: "1. Cardiología",
                details:
                    "- Ecocardiograma en las primeras semanas de vida para descartar malformaciones.\n"
                    "- Seguimiento de cardiopatías congénitas si están presentes.",
                delay: 1000,
              ),
              _buildSpecialty(
                title: "2. Endocrinología",
                details:
                    "- Tamizaje y control de hipotiroidismo congénito y adquirido.\n"
                    "- Valoración del crecimiento y metabolismo.",
                delay: 1100,
              ),
              _buildSpecialty(
                title: "3. Neurología y Rehabilitación",
                details:
                    "- Atención temprana con terapia física, ocupacional y del lenguaje.\n"
                    "- Monitoreo del desarrollo psicomotor y cognitivo.",
                delay: 1200,
              ),
              _buildSpecialty(
                title: "4. Psicología y Educación",
                details:
                    "- Apoyo en habilidades adaptativas, conducta y emociones.\n"
                    "- Adaptación curricular e inclusión educativa.\n"
                    "- Estimulación cognitiva estructurada.",
                delay: 1300,
              ),
              _buildSpecialty(
                title: "5. Genética Clínica",
                details:
                    "- Confirmación diagnóstica mediante cariotipo.\n"
                    "- Asesoramiento genético a la familia sobre el tipo de trisomía y riesgo de recurrencia.",
                delay: 1400,
              ),
              _buildSpecialty(
                title: "6. Otorrinolaringología y Oftalmología",
                details:
                    "- Tamizaje auditivo y visual desde el nacimiento.\n"
                    "- Seguimiento ante otitis media recurrente, hipoacusia, estrabismo o cataratas.",
                delay: 1500,
              ),
              _buildSpecialty(
                title: "7. Gastroenterología y Nutrición",
                details:
                    "- Evaluación ante sospecha de enfermedad celíaca, reflujo o estreñimiento.\n"
                    "- Plan nutricional individualizado para prevenir obesidad.",
                delay: 1600,
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1700),
                child: const Text(
                  "Conclusión",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeInUp(
                duration: const Duration(milliseconds: 1800),
                child: const Text(
                  "El éxito en el manejo del Síndrome de Down radica en una atención coordinada, centrada en la persona, que acompañe a lo largo del desarrollo del niño. Una detección y atención temprana de las complicaciones permite un pronóstico más favorable y una mejor inclusión social.",
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

  Widget _buildSpecialty({
    required String title,
    required String details,
    required int delay,
  }) {
    return FadeInUp(
      duration: Duration(milliseconds: delay),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              details,
              style: const TextStyle(fontSize: 15),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
