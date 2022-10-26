import 'dart:io' as io;

import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'appbar_comp.dart';
import 'button/icon_button_comp.dart';

class PDFViewerComp extends StatefulWidget {
  final String url;
  final bool hideRotation;
  final bool hideSearch;

  const PDFViewerComp(this.url, {Key? key, this.hideRotation = false, this.hideSearch = false})
      : super(key: key);

  @override
  State<PDFViewerComp> createState() => _PDFViewerCompState();
}

class _PDFViewerCompState extends State<PDFViewerComp> {
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
        resizeToAvoidBottomInset: false,
        key: UniqueKey(),
        appBar: AppBarComp(
          title: hasData ? widget.url.fileName() : '',
          centerTitle: false,
          onLeading: _onLeading,
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
                  _PDFTypeWidget(
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
                          child: IconButtonComp(
                              icon: Icons.keyboard_arrow_left, onPress: controller?.previousPage),
                        )),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black45.withOpacity(.3), borderRadius: BorderRadius.circular(8)),
                          child:
                              IconButtonComp(icon: Icons.keyboard_arrow_right, onPress: controller?.nextPage),
                        ))
                  ],
                ],
              ),
      ),
    );
  }

  void _onLeading() {
    _restore();
    Navigator.pop(context);
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
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
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

class _PDFTypeWidget extends StatelessWidget {
  final String url;
  final PdfTextSelectionChangedCallback? onTextSelectionChanged;
  final PdfDocumentLoadedCallback? onDocumentLoaded;
  final PdfDocumentLoadFailedCallback? onDocumentLoadFailed;
  final GlobalKey<SfPdfViewerState> pdfViewerKey;
  final PdfPageChangedCallback? onPageChanged;
  final PdfViewerController? controller;

  const _PDFTypeWidget(this.url,
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
        io.File(url),
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
    if (url.isAssets()) {
      return SfPdfViewer.asset(
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

    return const SizedBox.shrink();
  }
}
