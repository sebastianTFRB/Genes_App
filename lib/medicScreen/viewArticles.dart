import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:genesapp/usersScreen/pdf_visualizador_screen.dart';
import 'package:genesapp/usersScreen/perfilview.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';

class VerArticulosScreen extends StatelessWidget {
  const VerArticulosScreen({super.key});

  String _formatearFecha(Timestamp timestamp) {
    final fecha = timestamp.toDate();
    return '${fecha.day}/${fecha.month}/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: "Artículos Publicados",
        color: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance
                .collection('articulos_medicos')
                .orderBy('fecha', descending: true)
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay artículos publicados."));
          }

          final articulos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: articulos.length,
            itemBuilder: (context, index) {
              final data = articulos[index].data() as Map<String, dynamic>;
              final nombre = data['nombreArchivo'] ?? 'Sin nombre';
              final url =
                  'https://genesapp.centralus.cloudapp.azure.com/api2/upload/$nombre';
              final email = data['email'] ?? 'Desconocido';
              final fecha =
                  data['fecha'] != null
                      ? _formatearFecha(data['fecha'])
                      : 'Sin fecha';
              final fotoPerfil = data['fotoPerfil'] ?? '';
              final uid = data['uid'] ?? '';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 👤 Encabezado con autor
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PerfilUsuarioScreen(uid: uid),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  fotoPerfil.isNotEmpty
                                      ? NetworkImage(fotoPerfil)
                                      : const AssetImage(
                                            "assets/images/default_user.png",
                                          )
                                          as ImageProvider,
                              radius: 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                email,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                fecha,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // 📄 Nombre del artículo
                      Text(
                        nombre,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      const SizedBox(height: 10),

                      // 📎 Botón de ver artículo PDF
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PdfViewerScreen(url: url),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Ver artículo',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
