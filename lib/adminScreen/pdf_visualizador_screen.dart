import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:genesapp/widgets/custom_app_bar_simple.dart';

class PdfViewerScreen extends StatelessWidget {
  final String url;

  const PdfViewerScreen({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarSimple(
        title: 'Visualizador de PDF',
        color: Color.fromARGB(255, 33, 150, 243),
        backgroundColor: Colors.blueAccent,
        mostrarBotonPerfil: false,
      ),
      backgroundColor: const Color(0xFFF6FFF9),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: SfPdfViewer.network(
          url,
          canShowPaginationDialog: true,
          canShowScrollHead: true,
          canShowScrollStatus: true,
          enableDoubleTapZooming: true,
        ),
      ),
    );
  }
}
