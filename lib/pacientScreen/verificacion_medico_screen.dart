import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';

class VerificarMedicoScreen extends StatefulWidget {
  const VerificarMedicoScreen({super.key});

  @override
  State<VerificarMedicoScreen> createState() => _VerificarMedicoScreenState();
}

class _VerificarMedicoScreenState extends State<VerificarMedicoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cedulaController = TextEditingController();
  final _addressController = TextEditingController();
  final _institutionController = TextEditingController();
  final _rethusController = TextEditingController();

  List<File> _documents = [];
  String? _imageError;
  bool _acceptTerms = false;

  Future<void> _pickDocuments() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _documents = result.paths.map((path) => File(path!)).toList();
        _imageError = null;
      });
    } else {
      setState(() {
        _imageError = "No se seleccionó ningún documento.";
      });
    }
  }

  Future<void> _enviarVerificacion() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Usuario no autenticado')),
      );
      return;
    }

    var uri = Uri.parse('http://192.168.20.30:5001/verificacion/enviar');
    var request = http.MultipartRequest('POST', uri);

    request.fields['nombre'] = _nameController.text.trim();
    request.fields['cedula'] = _cedulaController.text.trim();
    request.fields['direccion'] = _addressController.text.trim();
    request.fields['institucion'] = _institutionController.text.trim();
    request.fields['rethus'] = _rethusController.text.trim();
    request.fields['email'] = FirebaseAuth.instance.currentUser?.email ?? '';
    request.fields['id_per'] = uid; // 👈 UID se envía oculto

    for (var file in _documents) {
      request.files.add(
        await http.MultipartFile.fromPath('documentos', file.path),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Verificación enviada exitosamente')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Error al enviar la verificación')),
      );
    }
  }

  Widget _showDocuments() {
    if (_documents.isEmpty) {
      return const Text('No hay documentos seleccionados');
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _documents
                .map(
                  (doc) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      '• ${doc.path.split('/').last}',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                )
                .toList(),
      );
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
        color: Color(0xFF007F5F),
        fontWeight: FontWeight.w700,
      ),
      prefixIcon: Icon(icon, color: const Color(0xFF2B9348)),
      filled: true,
      fillColor: Colors.white.withOpacity(0.8),
      contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF2B9348), width: 1.2),
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF007F5F), width: 2),
        borderRadius: BorderRadius.circular(14),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFF00B894);
    final accentColor = const Color(0xFF0984E3);

    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: 'Verificar Médico',
        backgroundColor: Colors.blueAccent,
        color: Color(0xFF00B894),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Solicitud de Verificación',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Complete los datos para ser verificado como médico.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration('Nombre Completo', Icons.person),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingrese su nombre'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cedulaController,
                  decoration: _inputDecoration('Cédula', Icons.badge),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingrese su cédula'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: _inputDecoration('Dirección', Icons.home),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingrese su dirección'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _institutionController,
                  decoration: _inputDecoration(
                    'Institución Médica',
                    Icons.local_hospital,
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingrese la institución médica'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _rethusController,
                  decoration: _inputDecoration(
                    'Número ReTHUS',
                    Icons.assignment_ind,
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Ingrese su número ReTHUS'
                              : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Adjunte al menos uno de los siguientes documentos: título profesional, tarjeta profesional o ReTHUS en PDF o imagen.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                    ),
                    onPressed: _pickDocuments,
                    icon: const Icon(Icons.upload_file),
                    label: const Text('Seleccionar Img o PDF '),
                  ),
                ),
                const SizedBox(height: 10),
                if (_imageError != null)
                  Text(_imageError!, style: const TextStyle(color: Colors.red)),
                _showDocuments(),
                const SizedBox(height: 24),
                CheckboxListTile(
                  title: const Text(
                    'Autorizo el tratamiento de mis datos personales según la Ley 1581 de 2012.',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  activeColor: primaryColor,
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() => _acceptTerms = value ?? false);
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (!_acceptTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Debe aceptar el tratamiento de datos.',
                              ),
                            ),
                          );
                          return;
                        }
                        if (_documents.isEmpty) {
                          setState(() {
                            _imageError =
                                'Debe subir al menos una IMG o Documento PDF';
                          });
                          return;
                        }
                        _enviarVerificacion();
                      }
                    },
                    child: const Text(
                      'Enviar Solicitud',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
