import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath;

  const PDFViewerScreen(this.pdfPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Viewer")),
      body: FutureBuilder<PDFDocument>(
        future: PDFDocument.fromFile(File(pdfPath)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error loading PDF: ${snapshot.error}'));
            }
            return snapshot.data != null
                ? PDFViewer(
                    document: snapshot.data!,
                  )
                : Center(child: Text('No document available'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
