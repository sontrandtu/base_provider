import 'dart:io' as io;
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/sys/permission_config.dart';
import 'package:achitecture_weup/common/core/widget/pdf_viewer.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';
import 'package:achitecture_weup/common/helper/key_language.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dio/dio.dart';

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
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PDFViewer(url)));
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