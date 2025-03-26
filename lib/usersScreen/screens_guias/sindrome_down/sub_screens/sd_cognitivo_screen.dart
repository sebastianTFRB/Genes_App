import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CognitivoDownScreen extends StatelessWidget {
  const CognitivoDownScreen({super.key});

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
                      "assets/images/cognitivo_down.jpg",
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
                  "El perfil cognitivo en el Síndrome de Down se caracteriza por discapacidad intelectual leve a moderada, con habilidades sociales destacadas y un desarrollo desigual en distintas áreas del neurodesarrollo. La estimulación temprana y un entorno adecuado son fundamentales para maximizar su potencial.",
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
                      "Atención: dificultades en atención sostenida y distractibilidad alta.",
                    ),
                    _buildBullet(
                      "Memoria: fortalezas en memoria visual, dificultades en memoria verbal y de trabajo.",
                    ),
                    _buildBullet(
                      "Lenguaje: retraso en la adquisición; mejor comprensión que expresión. Puede haber apraxia del habla.",
                    ),
                    _buildBullet(
                      "Funciones ejecutivas: limitaciones en planificación, flexibilidad cognitiva y resolución de problemas.",
                    ),
                    _buildBullet(
                      "Sociabilidad: generalmente buena, con tendencia a la imitación y el apego.",
                    ),
                    _buildBullet(
                      "Mayor prevalencia de trastornos del espectro autista en comparación con la población general.",
                    ),
                    _buildBullet(
                      "Riesgo elevado de enfermedad de Alzheimer de aparición temprana (en adultos).",
                    ),
                    _buildBullet(
                      "Aprendizaje: necesita apoyos pedagógicos, con mejor desempeño en tareas concretas y repetitivas.",
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
                  "La intervención interdisciplinaria desde edades tempranas con neuropsicología, fonoaudiología, pedagogía y psiquiatría infantil puede favorecer el desarrollo integral. La inclusión educativa con adaptaciones curriculares, estimulación cognitiva estructurada y un entorno socialmente estimulante son pilares fundamentales en el tratamiento.",
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
