import 'dart:async';
import 'dart:io';

final List<String> data = [];
String moduleName = '';

main(List<String> args) async {
  print('Args: $args');


  final dir = Directory('../dependencies');

  // print(dir.absolute);
  // print(dir.existsSync());
//
  final List<FileSystemEntity> entities = await dir.list().toList();

  Future.forEach(entities, _writeFile);
}

Future<void> recursive(Directory dir) async {
  final List<FileSystemEntity> entities = await dir.list().toList();
  Iterable<File> files = entities.whereType<File>();
  Iterable<Directory> directories = entities.whereType<Directory>();
  int index = dir.path.replaceAll('\\', '/').indexOf('/lib');
  for (var element in files) {
    String path = element.path.replaceAll('\\', '/').replaceRange(0, index + 4, '');
    if (path == '/$moduleName.dart') break;
    data.add('export \'$path\';');
    print(path);
  }
  await Future.forEach(directories, recursive);
}

FutureOr _writeFile(FileSystemEntity element) async {
  data.clear();

  final yamlFile = File('${element.path}/pubspec.yaml');
  if (!yamlFile.existsSync()) return;

  List<String> pubLines = yamlFile.readAsLinesSync();

  moduleName = pubLines.firstWhere((element) => element.contains('name')).split(': ').last;
  print('---||======> Generate for module: $moduleName');

  data.add('\n/// CODE GENERATE\n');
  data.add('library $moduleName;\n');

  final dir = Directory('${element.path}/lib');
  await recursive(dir);

  final file = File('${element.path}/lib/$moduleName.dart');

  file.writeAsStringSync(data.join('\n'));
}
