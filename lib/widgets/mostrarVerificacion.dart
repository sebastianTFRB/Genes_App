import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void mostrarVerificacionMedica(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const _VerificacionMedicaDialog(),
  );
}

class _VerificacionMedicaDialog extends StatefulWidget {
  const _VerificacionMedicaDialog();

  @override
  State<_VerificacionMedicaDialog> createState() => _VerificacionMedicaDialogState();
}

class _VerificacionMedicaDialogState extends State<_VerificacionMedicaDialog> {
  final _cedulaController = TextEditingController();
  final _institucionController = TextEditingController();
  final _experienciaController = TextEditingController();
  bool _isLoading = false;
  bool _solicitudEnviada = false;

  @override
  void initState() {
    super.initState();
    _verificarSiYaExisteSolicitud();
  }

  Future<void> _verificarSiYaExisteSolicitud() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final doc = await FirebaseFirestore.instance.collection('roleRequests').doc(user.uid).get();
    if (doc.exists && doc['status'] == 'pending') {
      setState(() => _solicitudEnviada = true);
    }
  }

  Future<void> _enviarSolicitud() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (_cedulaController.text.isEmpty || _institucionController.text.isEmpty || _experienciaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor completa todos los campos")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('roleRequests').doc(user.uid).set({
        'userId': user.uid,
        'email': user.email,
        'status': 'pending',
        'requestedRole': 'doctor',
        'requestedAt': Timestamp.now(),
        'cedula': _cedulaController.text.trim(),
        'institucion': _institucionController.text.trim(),
        'experiencia': _experienciaController.text.trim(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Solicitud enviada correctamente")),
      );

      setState(() {
        _solicitudEnviada = true;
      });

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al enviar la solicitud")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Verificación Médica", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            if (_solicitudEnviada)
              const Text("Ya enviaste una solicitud. Espera a que el administrador la revise.",
                  style: TextStyle(color: Colors.blueGrey)),
            if (!_solicitudEnviada) ...[
              TextField(
                controller: _cedulaController,
                decoration: const InputDecoration(labelText: 'Número de cédula'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _institucionController,
                decoration: const InputDecoration(labelText: 'Institución afiliada'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _experienciaController,
                decoration: const InputDecoration(labelText: 'Experiencia médica'),
                maxLines: 3,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _isLoading ? null : _enviarSolicitud,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Enviar Solicitud"),
              ),
            ]
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _institucionController.dispose();
    _experienciaController.dispose();
    super.dispose();
  }
}
