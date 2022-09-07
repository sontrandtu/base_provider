import 'dart:io';

class ImageEntity {
  final int? id;
  final String? path;
  final String? name;
  final int? size;
  final File? file;

  ImageEntity({this.id, this.path, this.file, this.name, this.size});

  @override
  String toString() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['path'] = path;
    map['file'] = file;
    return map.toString();
  }
}
