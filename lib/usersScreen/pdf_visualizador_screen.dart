import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';

class PdfViewerScreen extends StatelessWidget {
  final String url;
  const PdfViewerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.trim().isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Visualizador de PDF')),
        body: const Center(
          child: Text('❌ No se proporcionó una URL válida para el PDF.'),
        ),
      );
    }

    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: 'Visualizador de PDF',
        color: Color.fromARGB(255, 33, 150, 243),
        mostrarBotonPerfil: false,
      ),
      backgroundColor: Color(0xFFF6FFF9),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: SfPdfViewer.network(
          url,
          headers: const {},
          canShowPaginationDialog: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          enableDoubleTapZooming: true,
          onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
            print('❌ Error al cargar PDF: ${details.description}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al cargar el PDF: ${details.description}'),
              ),
            );
          },
        ),
      ),
    );
  }
}
