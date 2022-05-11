import 'dart:io' as io;
import 'dart:io';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/permission_config.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/key_language.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
          if (process == 100) isSuccess = true;
          if (onProcess != null) onProcess(process);
        },
      );
      if (isSuccess) return savePath;
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
  final bool hideRotation;
  final bool hideSearch;

  const _PDFViewer(this.url, {Key? key, this.hideRotation = false, this.hideSearch = false}) : super(key: key);

  @override
  State<_PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<_PDFViewer> {
  late final GlobalKey<SfPdfViewerState> _pdfViewerKey;
  bool hasData = false;
  late PdfViewerController? controller;

  // late PDFDocument document;

  bool showAction = false;

  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    _pdfViewerKey = GlobalKey();
    if (widget.url == '') hasData = false;
    if (widget.url != '' && widget.url.endsWith('.pdf')) {
      hasData = true;
      controller = PdfViewerController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBarComp(
          title: 'PDF Viewer',
          centerTitle: false,
          onLeading: () {
            _restore();
            Navigator.pop(context);
          },
          action: [
            // if (!widget.hideSearch)
            //   IconButtonComp(icon: Icons.search, color: Colors.white, onPress: _onRotation),
            if (!widget.hideRotation)
              IconButtonComp(icon: Icons.screen_rotation, color: Colors.white, onPress: _onRotation),
          ],
        ),
        body: !hasData
            ? const Center(
                child: Text(
                  'File không thể hiển thị lúc này',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            : Stack(
                children: [
                  _PDFWidget(
                    // 'https://unec.edu.az/application/uploads/2014/12/pdf-sample.pdf',
                    widget.url,
                    pdfViewerKey: _pdfViewerKey,
                    controller: controller,
                    onDocumentLoaded: onDocumentLoaded,
                  ),
                  if (showAction) ...[
                    Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black45.withOpacity(.3), borderRadius: BorderRadius.circular(8)),
                          child: IconButtonComp(icon: Icons.keyboard_arrow_left, onPress: controller?.previousPage),
                        )),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black45.withOpacity(.3), borderRadius: BorderRadius.circular(8)),
                          child: IconButtonComp(icon: Icons.keyboard_arrow_right, onPress: controller?.nextPage),
                        ))
                  ],
                ],
              ),
      ),
    );
  }

  void onDocumentLoaded(PdfDocumentLoadedDetails details) {
    if (mounted && controller!.pageCount > 1) {
      setState(() {
        showAction = true;
      });
    }
  }

  Future<bool> _onWillPop() async {
    _restore();
    return true;
  }

  void _onRotation() async {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } else {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    }
  }

  void _restore() async {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    if (controller != null) controller?.clearSelection();
    super.dispose();
  }
}

class _PDFWidget extends StatelessWidget {
  final String url;
  final PdfTextSelectionChangedCallback? onTextSelectionChanged;
  final PdfDocumentLoadedCallback? onDocumentLoaded;
  final PdfDocumentLoadFailedCallback? onDocumentLoadFailed;
  final GlobalKey<SfPdfViewerState> pdfViewerKey;
  final PdfPageChangedCallback? onPageChanged;
  final PdfViewerController? controller;

  const _PDFWidget(this.url,
      {Key? key,
      required this.pdfViewerKey,
      this.onTextSelectionChanged,
      this.onDocumentLoaded,
      this.onDocumentLoadFailed,
      this.onPageChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isValidUrl) {
      return SfPdfViewer.network(
        url,
        key: pdfViewerKey,
        controller: controller,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        onDocumentLoaded: onDocumentLoaded,
        onDocumentLoadFailed: onDocumentLoadFailed,
        onPageChanged: onPageChanged,
        enableTextSelection: true,
        onTextSelectionChanged: onTextSelectionChanged,
      );
    }
    if (url.isStorage()) {
      return SfPdfViewer.file(
        File(url),
        key: pdfViewerKey,
        controller: controller,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        onDocumentLoaded: onDocumentLoaded,
        onDocumentLoadFailed: onDocumentLoadFailed,
        onPageChanged: (detail) {},
        enableTextSelection: true,
        onTextSelectionChanged: onTextSelectionChanged,
      );
    }
    if (url.isAssets()) {
      return SfPdfViewer.asset(
        url,
        key: pdfViewerKey,
        controller: controller,
        canShowScrollHead: false,
        canShowScrollStatus: false,
        onDocumentLoaded: onDocumentLoaded,
        onDocumentLoadFailed: onDocumentLoadFailed,
        onPageChanged: (detail) {},
        enableTextSelection: true,
        onTextSelectionChanged: onTextSelectionChanged,
      );
    }

    return const SizedBox.shrink();
  }
}
