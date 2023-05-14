import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileViewer extends StatefulWidget {
  const FileViewer({super.key});

  @override
  State<FileViewer> createState() => _FileViewerState();
}

class _FileViewerState extends State<FileViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.network('https://firebasestorage.googleapis.com/v0/b/careergy-3e171.appspot.com/o/attachments%2FVnFHTFH2u4SVzkvMvBMPVwOij303%2F6x4.JPG?alt=media&token=41e0b8fd-8ec7-441a-bae3-019538d21a35'),
    );
  }
}