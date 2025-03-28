import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

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

  Future<void> _checkPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final photosPermission = await Permission.photos.request();

    if (cameraPermission.isDenied || photosPermission.isDenied) {
      setState(() {
        _imageError = "Debe permitir el acceso a la cámara y las fotos.";
      });
    } else {
      setState(() {
        _imageError = null;
      });
    }
  }

  Future<void> _pickDocuments() async {
    await _checkPermissions();
    if (_imageError == null) {
      final picker = ImagePicker();
      final pickedFiles = await picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        setState(() {
          _documents = pickedFiles.map((e) => File(e.path)).toList();
          _imageError = null;
        });
      } else {
        setState(() {
          _imageError = "No se seleccionó ningún documento.";
        });
      }
    }
  }

  Widget _showDocuments() {
    if (_documents.isEmpty) {
      return const Text('No hay documentos seleccionados');
    } else {
      return Wrap(
        spacing: 10,
        children:
            _documents
                .map((doc) => Image.file(doc, height: 100, width: 100))
                .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verificar Médico')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Complete los siguientes datos para ser verificado como médico',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre Completo',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre completo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _cedulaController,
                  decoration: const InputDecoration(labelText: 'Cédula'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su cédula';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Dirección'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su dirección';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _institutionController,
                  decoration: const InputDecoration(
                    labelText: 'Institución Médica',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la institución médica';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _rethusController,
                  decoration: const InputDecoration(labelText: 'Número ReTHUS'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su número ReTHUS';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _pickDocuments,
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Seleccionar Documentos'),
                ),
                const SizedBox(height: 20),
                if (_imageError != null)
                  Text(_imageError!, style: const TextStyle(color: Colors.red)),
                _showDocuments(),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text(
                    'Autorizo el tratamiento de mis datos personales según la Ley 1581 de 2012.',
                  ),
                  value: _acceptTerms,
                  onChanged: (value) {
                    setState(() {
                      _acceptTerms = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
                          _imageError = 'Debe subir al menos un documento';
                        });
                        return;
                      }
                      // Aquí deberías enviar los datos al backend y guardar en Firestore/Storage
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Verificación solicitada'),
                        ),
                      );
                    }
                  },
                  child: const Text('Enviar Solicitud'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
