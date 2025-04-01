import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sub_screens/sd_cardiovascular_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sub_screens/sd_fenotipos_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sub_screens/sd_cognitivo_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sub_screens/sd_diagnostico_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sub_screens/sd_diferencial_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_down/sub_screens/sd_manejo_screen.dart';

class GuiaSindromeDown extends StatelessWidget {
  const GuiaSindromeDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    "assets/images/down/Down-Syndrome-1.webp",
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
                "¿Qué es el Síndrome de Down?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 900),
              child: const Text(
                "El Síndrome de Down es una alteración genética causada por la presencia de una tercera copia total o parcial del cromosoma 21. Se asocia con discapacidad intelectual, características físicas típicas y un riesgo aumentado de ciertas enfermedades congénitas.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 30),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;
                return Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    _tarjetaSeccion(
                      "Fenotipo",
                      "Características faciales, corporales y neuromusculares típicas.",
                      Icons.face,
                      Colors.blueAccent,
                      context,
                      const FenotipoDownScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Cardiovascular",
                      "Defectos congénitos del corazón y riesgo de hipertensión pulmonar.",
                      Icons.favorite,
                      Colors.redAccent,
                      context,
                      const CardiovascularDownScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Cognitivo",
                      "Desarrollo intelectual, social y conductual.",
                      Icons.psychology,
                      Colors.purpleAccent,
                      context,
                      const CognitivoDownScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Diagnóstico",
                      "Evaluación física y pruebas genéticas específicas.",
                      Icons.science,
                      Colors.green,
                      context,
                      const DiagnosticoDownScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Diferencial",
                      "Otras condiciones con fenotipos similares.",
                      Icons.compare,
                      Colors.orangeAccent,
                      context,
                      const DiagnosticoDiferencialDownScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Manejo",
                      "Enfoque multidisciplinario e intervención temprana.",
                      Icons.medical_services,
                      Colors.teal,
                      context,
                      const ManejoSindromeDownScreen(),
                      isWide,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _tarjetaSeccion(
    String titulo,
    String descripcion,
    IconData icon,
    Color color,
    BuildContext context,
    Widget destino,
    bool isWide,
  ) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 800),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destino),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.all(15),
            width:
                isWide
                    ? MediaQuery.of(context).size.width * 0.42
                    : MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  titulo,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  descripcion,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
