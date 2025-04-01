import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/sub_screens/sw_cardiovascular_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/sub_screens/sw_cognitivo_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/sub_screens/sw_diagnostico_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/sub_screens/sw_fenotipos_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/sub_screens/sw_manejo_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/sindrome_williams/sub_screens/sw_diferencial_screen.dart';

// Pantalla principal
class GuiaSindromeWilliams extends StatelessWidget {
  const GuiaSindromeWilliams({super.key});

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
                    "assets/images/williams/williams-2.webp",
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
                "¿Qué es el Síndrome de Williams?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 900),
              child: const Text(
                "El Síndrome de Williams-Beuren es una condición genética causada por la deleción de genes en el cromosoma 7. Se manifiesta con rasgos faciales característicos, problemas cardiovasculares y una personalidad muy sociable.",
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
                      "Características faciales y físicas distintivas.",
                      Icons.face,
                      Colors.greenAccent,
                      context,
                      const FenotipoWilliamsScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Cardiovascular",
                      "Problemas del corazón como la estenosis supravalvular aórtica.",
                      Icons.favorite,
                      Colors.redAccent,
                      context,
                      const CardiovascularScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Cognitivo",
                      "Perfil conductual, del lenguaje y habilidades sociales.",
                      Icons.psychology,
                      Colors.purpleAccent,
                      context,
                      const CognitivoConductualScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Diagnóstico",
                      "Métodos clínicos y genéticos para confirmar el diagnóstico.",
                      Icons.science,
                      Colors.blueAccent,
                      context,
                      const DiagnosticoScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Diferencial",
                      "Síndromes que pueden parecerse clínicamente.",
                      Icons.compare,
                      Colors.orangeAccent,
                      context,
                      const DiagnosticoDiferencialScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Manejo",
                      "Recomendaciones y especialidades para el tratamiento.",
                      Icons.medical_services,
                      Colors.teal,
                      context,
                      const ManejoSindromeWilliamsScreen(),
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
