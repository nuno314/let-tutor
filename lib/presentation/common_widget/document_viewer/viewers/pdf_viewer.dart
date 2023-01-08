import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

import '../../../common_widget/loading.dart';

class PDFViewer extends StatefulWidget {
  final String url;
  final Future<Uint8List?> Function({required String url}) getDataFrom;

  const PDFViewer({
    Key? key,
    required this.url,
    required this.getDataFrom,
  }) : super(key: key);

  @override
  _PDFViewerState createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  Uint8List? pdfData;

  void onViewCreated() {
    widget.getDataFrom(url: widget.url).then((value) {
      setState(() {
        pdfData = value;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onViewCreated();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (pdfData == null) {
      return const Center(
          child: Loading(
        brightness: Brightness.light,
        radius: 16,
      ));
    }
    return SizedBox(
      key: UniqueKey(),
      child: PdfPreview(
        allowPrinting: false,
        allowSharing: false,
        canChangePageFormat: false,
        initialPageFormat:
            PdfPageFormat(100 * PdfPageFormat.mm, 120 * PdfPageFormat.mm),
        build: (format) => Future.value(pdfData),
      ),
    );
  }
}
