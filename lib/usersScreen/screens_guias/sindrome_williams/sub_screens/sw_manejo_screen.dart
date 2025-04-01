import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class ManejoSindromeWilliamsScreen extends StatelessWidget {
  const ManejoSindromeWilliamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Manejo del Síndrome de Williams",
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
                      "assets/images/williams/williams-1.webp",
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
                  "Manejo Multidisciplinario del Síndrome de Williams",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),
              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: const Text(
                  "El abordaje clínico del SW requiere un equipo interdisciplinario para atender las múltiples dimensiones de la enfermedad. Desde la infancia, se deben implementar estrategias de vigilancia médica, terapias de apoyo y asesoramiento genético.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),
              _buildSpecialty(
                title: "1. Cardiología",
                details:
                    "- Evaluación periódica de la estenosis supravalvular aórtica (ESA).\n"
                    "- Control de presión arterial y detección de otras vasculopatías.",
                delay: 1000,
              ),
              _buildSpecialty(
                title: "2. Endocrinología",
                details:
                    "- Seguimiento de hipercalcemia, en especial en la infancia.\n"
                    "- Evaluación y tratamiento de disfunción tiroidea.\n"
                    "- Monitoreo del crecimiento y pubertad.",
                delay: 1100,
              ),
              _buildSpecialty(
                title: "3. Neurología y Rehabilitación",
                details:
                    "- Atención al desarrollo psicomotor.\n"
                    "- Intervención temprana con fisioterapia, terapia ocupacional y del lenguaje.",
                delay: 1200,
              ),
              _buildSpecialty(
                title: "4. Psicología y Psiquiatría",
                details:
                    "- Apoyo conductual para manejo de fobias, ansiedad y dificultades sociales.\n"
                    "- Reforzamiento de habilidades de autonomía.",
                delay: 1300,
              ),
              _buildSpecialty(
                title: "5. Genética Clínica",
                details:
                    "- Confirmación diagnóstica con pruebas moleculares.\n"
                    "- Asesoramiento familiar sobre riesgos de recurrencia.\n"
                    "- Elaboración de árbol genealógico.",
                delay: 1400,
              ),
              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1500),
                child: const Text(
                  "Conclusión",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              FadeInUp(
                duration: const Duration(milliseconds: 1600),
                child: const Text(
                  "El éxito en el tratamiento del SW radica en una intervención oportuna, seguimiento constante y un equipo interdisciplinario comprometido con mejorar la calidad de vida del paciente y su entorno familiar.",
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
