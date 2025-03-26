import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class VisorPdfScreen extends StatefulWidget {
  final String nombreArchivo;

  const VisorPdfScreen({super.key, required this.nombreArchivo});

  @override
  State<VisorPdfScreen> createState() => _VisorPdfScreenState();
}

class _VisorPdfScreenState extends State<VisorPdfScreen> {
  File? _archivoLocal;
  bool _cargando = true;
  bool _error = false;


  @override
  void initState() {
    super.initState();
    _descargarArchivo();
  }

  Future<void> _descargarArchivo() async {
    final baseUrl = 'http://192.168.20.10:5000/upload/';
    final encodedNombre = Uri.encodeComponent(widget.nombreArchivo);
    final fullUrl = '$baseUrl$encodedNombre';

    try {
      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/${widget.nombreArchivo}');
        await file.writeAsBytes(bytes);

        setState(() {
          _archivoLocal = file;
          _cargando = false;
        });
      } else {
        throw Exception('Error al descargar el archivo');
      }
    } catch (e) {
      setState(() {
        _error = true;
        _cargando = false;
      });
      final fallbackUrl = '$baseUrl$encodedNombre';
      await launchUrl(Uri.parse(fallbackUrl), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.nombreArchivo)),
      body: Stack(
        children: [
          if (_archivoLocal != null)
            SfPdfViewer.file(_archivoLocal!),
          if (_cargando)
            const Center(child: CircularProgressIndicator()),
          if (_error && !_cargando)
            const Center(child: Text('No se pudo cargar el documento')),
        ],
      ),
    );
  }
}
