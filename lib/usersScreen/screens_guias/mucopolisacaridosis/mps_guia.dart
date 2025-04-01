import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/sub_screens/mps_cardiopulmonar_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/sub_screens/mps_diagnostico_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/sub_screens/mps_diferencial_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/sub_screens/mps_fenotipos_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/sub_screens/mps_manejo_screen.dart';
import 'package:genesapp/usersScreen/screens_guias/mucopolisacaridosis/sub_screens/mps_neurologico_screen.dart';

class GuiaMucopolisacaridosis extends StatelessWidget {
  const GuiaMucopolisacaridosis({super.key});

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
                    "assets/images/muco/1.webp",
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
                "¿Qué son las Mucopolisacaridosis?",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 900),
              child: const Text(
                "Las mucopolisacaridosis (MPS) son un grupo de enfermedades genéticas raras causadas por deficiencias enzimáticas que afectan la degradación de los glicosaminoglicanos. Su acumulación provoca afectación multisistémica progresiva, con rasgos faciales toscos, talla baja, problemas esqueléticos, neurológicos, respiratorios y cardíacos.",
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
                      "Facies tosca, baja talla, rigidez articular.",
                      Icons.face_retouching_natural,
                      Colors.brown,
                      context,
                      const FenotipoMpsScreen(), 
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Neurológico",
                      "Retraso psicomotor, hidrocefalia, convulsiones.",
                      Icons.psychology,
                      Colors.purple,
                      context,
                      const NeurologicoMpsScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Cardiopulmonar",
                      "Afectación valvular, apnea, infecciones respiratorias.",
                      Icons.favorite,
                      Colors.redAccent,
                      context,
                      const CardiopulmonarMpsScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Diagnóstico",
                      "Estudios enzimáticos, genéticos y orina.",
                      Icons.biotech,
                      Colors.blueAccent,
                      context,
                      const DiagnosticoMpsScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Diferencial",
                      "Otras enfermedades lisosomales y síndromes congénitos.",
                      Icons.compare_arrows,
                      Colors.orange,
                      context,
                      const DiagnosticoDiferencialMpsScreen(),
                      isWide,
                    ),
                    _tarjetaSeccion(
                      "Manejo",
                      "Reemplazo enzimático, abordaje multidisciplinario.",
                      Icons.local_hospital,
                      Colors.teal,
                      context,
                      const ManejoMpsScreen(),
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
