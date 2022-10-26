import 'package:domain/domain.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:io';
import 'package:mime/mime.dart';
import 'package:request_cache_manager/request_cache_manager.dart';

extension FileIOExtension on File? {
  MultipartFile get toMultipart {
    final mimeType = lookupMimeType(this?.path ?? '');
    return MultipartFile.fromFileSync(this?.path ?? '', contentType: MediaType.parse(mimeType!));
  }
}

extension DioExtension<T> on Future<Response<ApiModel<T?>>> {
  Future<ApiModel<T?>> wrap() async {
    Response<ApiModel<T?>> httpResponse = await this;

    return httpResponse.data as ApiModel<T?>;
  }
}

extension FormDataExtension on Map<String, dynamic> {
  FormData get formData {
    forEach((key, value) {
      if (value is List<File>) value = value.map((e) => value.toMultipart).toList();
      if (value is File) value = value.toMultipart;
    });
    return FormData.fromMap(this);
  }

  String get urlEncode {
    return entries.map<String>((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}').join('&');
  }
}
