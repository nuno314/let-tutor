import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:let_tutor/presentation/extentions/extention.dart';

import '../../theme/theme_color.dart';
import '../forms/screen_form.dart';
import 'viewers/pdf_viewer.dart';

part 'document_viewer.action.dart';

class DocumentViewerArgs {
  final String title;
  final String url;

  DocumentViewerArgs({
    required this.title,
    required this.url,
  });
}

class DocumentViewerScreen extends StatefulWidget {
  final DocumentViewerArgs args;

  const DocumentViewerScreen({
    Key? key,
    required this.args,
  }) : super(key: key);

  @override
  _DocumentViewerScreenState createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  late String? downloadId;

  @override
  Widget build(BuildContext context) {
    return ScreenForm(
      title: widget.args.title,
      trans: translate(context),
      showHeaderImage: false,
      headerColor: AppColor.primaryColor,
      bgColor: AppColor.scaffoldColor,
      child: Builder(
        builder: (context) {
          return PDFViewer(url: widget.args.url, getDataFrom: getDataFrom);
        },
      ),
    );
  }
}
