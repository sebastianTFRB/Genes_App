import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';

class PerfilUsuarioScreen extends StatefulWidget {
  final String uid;
  const PerfilUsuarioScreen({super.key, required this.uid});

  @override
  State<PerfilUsuarioScreen> createState() => _PerfilUsuarioScreenState();
}

class _PerfilUsuarioScreenState extends State<PerfilUsuarioScreen> {
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
      final doc = await FirebaseFirestore.instance.collection('users').doc(widget.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
          isLoading = false;
        });
      } else {
        setState(() {
          error = 'Usuario no encontrado';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error al cargar datos';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: "Perfil del autor",
        color: Colors.blueAccent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? Center(child: Text(error.isNotEmpty ? error : 'Datos no disponibles'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
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
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: userData!["fotoPerfil"] != null && userData!["fotoPerfil"] != ''
                            ? NetworkImage(userData!["fotoPerfil"])
                            : const AssetImage("assets/images/profile.jpg") as ImageProvider,
                        backgroundColor: Colors.grey[300],
                      ),
                      const SizedBox(height: 12),
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
                      const SizedBox(height: 20),
                      const Divider(thickness: 1, color: Colors.blueGrey),
                      const Text(
                        "Este es un perfil público de autor.",
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
    );
  }
}
