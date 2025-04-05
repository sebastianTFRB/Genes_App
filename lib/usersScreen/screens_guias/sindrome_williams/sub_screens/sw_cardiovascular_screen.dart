import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class CardiovascularScreen extends StatelessWidget {
  const CardiovascularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          "Manifestaciones Cardiovasculares",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FadeIn(
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      "assets/images/williams/WS1.jpg",
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: const Text(
                  "¿Qué alteraciones cardiovasculares presenta el síndrome?",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),

              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: const Text(
                  "El compromiso cardiovascular es una de las características clínicas más importantes del Síndrome de Williams. Estas alteraciones pueden comprometer seriamente la salud del paciente si no se detectan a tiempo.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(height: 30),

              FadeInUp(
                duration: const Duration(milliseconds: 900),
                child: const Text(
                  "Principales Manifestaciones:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),

              FadeInUp(
                duration: const Duration(milliseconds: 1000),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BulletPoint(
                      "Estenosis supravalvular aórtica (ESA): la alteración más común y de mayor riesgo.",
                    ),
                    BulletPoint("Estenosis de ramas de arterias pulmonares."),
                    BulletPoint(
                      "Vasculopatía generalizada que puede afectar múltiples territorios vasculares.",
                    ),
                    BulletPoint(
                      "Hipertensión arterial, a menudo de difícil control.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(milliseconds: 1100),
                child: const Text(
                  "Importancia del seguimiento:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 1200),
                child: const Text(
                  "Es fundamental realizar controles periódicos con cardiología, incluyendo ecocardiogramas Doppler y monitorización de la presión arterial. La detección precoz de la ESA permite tomar decisiones clínicas como intervenciones quirúrgicas o médicas que mejoran la expectativa y calidad de vida del paciente.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),

              const SizedBox(height: 20),
              FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: const Text(
                  "Consideraciones clínicas adicionales:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                duration: const Duration(milliseconds: 1400),
                child: const Text(
                  "• Algunos pacientes pueden permanecer asintomáticos durante años, por lo que es indispensable realizar tamizajes aunque no existan síntomas aparentes.\n"
                  "• El uso de sedantes o anestesia debe ser manejado con precaución debido al riesgo cardiovascular asociado.\n"
                  "• La evaluación debe extenderse a otros vasos como renales y cerebrales si se sospechan complicaciones asociadas.",
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
          const Text("\u2022 ", style: TextStyle(fontSize: 18)),
          Expanded(
            child: Text(
              text.replaceFirst("\u2022 ", ""),
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
