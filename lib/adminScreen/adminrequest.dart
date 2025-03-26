import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';

class AdminVerificationPanel extends StatelessWidget {
  const AdminVerificationPanel({super.key});

  Future<void> updateRequestStatus(String userId, String status) async {
    await FirebaseFirestore.instance.collection('roleRequests').doc(userId).update({
      'status': status,
    });

    if (status == 'approved') {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'role': 'doctor',
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: "Artículos Publicados",
        color: Colors.blueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('roleRequests')
            .orderBy('requestedAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No hay solicitudes"));
          }

          final requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final data = requests[index].data() as Map<String, dynamic>;
              final userId = requests[index].id;

              return Card(
                margin: const EdgeInsets.all(10),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Correo: ${data['email'] ?? ''}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text("Cédula: ${data['cedula'] ?? ''}"),
                      Text("Institución: ${data['institucion'] ?? ''}"),
                      Text("Experiencia: ${data['experiencia'] ?? ''}"),
                      Text("Estado: ${data['status'] ?? ''}"),
                      const SizedBox(height: 10),
                      if (data['status'] == 'pending')
                        Row(
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => updateRequestStatus(userId, 'approved'),
                              icon: const Icon(Icons.check),
                              label: const Text("Aprobar"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton.icon(
                              onPressed: () => updateRequestStatus(userId, 'rejected'),
                              icon: const Icon(Icons.close),
                              label: const Text("Rechazar"),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            ),
                          ],
                        )
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
