import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:genesapp/pacientScreen/verificacion_medico_screen.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';
import 'package:genesapp/widgets/mostrarVerificacion.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      if (user != null) {
        final doc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user!.uid)
                .get();
        if (doc.exists) {
          setState(() {
            userData = doc.data();
            isLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        error = 'Error al cargar datos';
        isLoading = false;
      });
    }
  }

  Future<void> _changePassword() async {
    final TextEditingController newPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Cambiar contraseña"),
            content: TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Nueva contraseña'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await user!.updatePassword(newPasswordController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Contraseña actualizada exitosamente"),
                      ),
                    );
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error al actualizar la contraseña"),
                      ),
                    );
                  }
                },
                child: const Text("Guardar"),
              ),
            ],
          ),
    );
  }

  Widget perfilInfoTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback? onTap, {
    bool isGreen = false,
    bool isDisabled = false,
  }) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor:
                  isGreen
                      ? Colors.green.withOpacity(0.1)
                      : Colors.blueGrey.withOpacity(0.1),
              child: Icon(
                icon,
                color:
                    isGreen
                        ? Colors.green
                        : isDisabled
                        ? Colors.grey
                        : Colors.blueAccent,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(),
      appBar: const CustomAppBarSimple(
        title: "Mi Perfil",
        color: Colors.blueAccent,
        backgroundColor: Colors.blueAccent,
        mostrarBotonPerfil: false,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : userData == null
              ? Center(
                child: Text(error.isNotEmpty ? error : 'Usuario no encontrado'),
              )
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      userData!["email"] ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      userData!["name"] ?? '',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Rol: ${userData!["role"] ?? 'Paciente'}",
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: _changePassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      child: const Text(
                        "Cambiar contraseña",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.blueGrey),

                    // Verificación médica si NO es admin
                    if (userData!["role"] != 'admin') ...[
                      if (userData!["role"] == 'doctor') ...[
                        perfilInfoTile(
                          Icons.verified,
                          "Verificación Médica",
                          "Verificado",
                          () => mostrarDialogoFelicidades(context),

                          isGreen: true,
                        ),
                      ] else ...[
                        perfilInfoTile(
                          Icons.verified,
                          "Verificación Médica",
                          "Sube tus credenciales",
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const VerificarMedicoScreen(),
                            ),
                          ),
                          isDisabled: false,
                        ),
                      ],
                    ],

                    perfilInfoTile(
                      Icons.history,
                      "Historial de Predicciones",
                      "Consulta anteriores análisis",
                      null,
                    ),
                    perfilInfoTile(
                      Icons.article,
                      "Mis Publicaciones",
                      "Casos médicos y debates",
                      null,
                    ),
                    perfilInfoTile(
                      Icons.settings,
                      "Configuración",
                      "Privacidad, notificaciones",
                      null,
                    ),
                    const Divider(color: Colors.blueGrey),
                    perfilInfoTile(
                      Icons.info,
                      "Acerca de GenesApp",
                      "Descubre más sobre la app",
                      null,
                    ),
                    perfilInfoTile(
                      Icons.people,
                      "Desarrolladores",
                      "Conoce al equipo detrás de GenesApp",
                      null,
                    ),
                    perfilInfoTile(
                      Icons.policy,
                      "Política de Privacidad",
                      "Consulta nuestras normas",
                      null,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
    );
  }
}

void mostrarDialogoFelicidades(BuildContext context) {
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.celebration, size: 60, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                "¡Felicidades!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Ahora tienes acceso completo como médico en GenesApp.\nGracias por unirte como profesional de la salud.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "¡Entendido!",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
  );
}
