import 'dart:io' as io;
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/permission_config.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/key_language.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

enum FileOption { camera, gallery, document }

class FileUtils {
  FileUtils._internal();

  static final FileUtils _instance = FileUtils._internal();

  factory FileUtils() => _instance;

  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  // Check hạn kích cỡ file
  Future<bool> checkSize(io.File file) async {
    final int fileSize = await file.length();
    return fileSize > (5 * 1024 * 1024);
  }

  void open(BuildContext context, {required String url}) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => _PDFViewer(url)));
  }

  Future<String>? download(String url, {ValueChanged<num>? onProcess}) async {
    if (url == '') return '';
    final bool res = await PermissionConfig.instance.request(
      permission: Permission.storage,
      title: KeyLanguage.questionStorage.tl,
      content: KeyLanguage.questionStorage.tl,
    );
    if (!res) return '';
    try {
      bool isSuccess = false;
      int process = 0;
      final Dio _dio = Dio();
      String fileName = url.fileName();
      final savePath = await _getPath(fileName);
      await _dio.download(
        url,
        savePath,
        onReceiveProgress: (count, total) {
          process = ((count / total) * 100).ceil();
          if(process == 100) isSuccess = true;
          if (onProcess != null) onProcess(process);
        },
      );
      if(isSuccess) return savePath;
    } catch (e) {
      showError(e);
      throw Exception(e);
    }
    return '';
  }

  Future<String> _getPath(String input) async {
    final _path = await getApplicationDocumentsDirectoryPath();
    return '$_path/$input';
  }
}

class _PDFViewer extends StatefulWidget {
  final String url;

  const _PDFViewer(this.url, {Key? key}) : super(key: key);

  @override
  State<_PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<_PDFViewer> {
  bool _isLoading = true;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  // late PDFDocument document;

  @override
  void initState() {
    _loadDocument();
    super.initState();
  }

  void _loadDocument() async {
    // document = await PDFDocument.fromURL('https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf');
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComp(
        title: 'PDF Viewer',
        onLeading: () {},
      ),
      body: Container(
        child: SfPdfViewer.network(
          'https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf',
          key: _pdfViewerKey,
        ),
      ),
    );
  }
}
