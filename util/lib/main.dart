import 'dart:async';
import 'dart:io';

final List<String> data = [];
String moduleName = '';

main(List<String> args) async {
  await _writeFile('./data');
  _writeFile('./domain');
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

  if (directories.isEmpty) return;
  await Future.forEach(directories, recursive);
}

FutureOr _writeFile(String path) async {
  data.clear();
  final yamlFile = File('$path/pubspec.yaml');
  List<String> pubLines = yamlFile.readAsLinesSync();

  moduleName = pubLines.firstWhere((element) => element.contains('name')).split(': ').last;
  print('---||======> Generate for module: $moduleName');

  data.add('\n/// CODE GENERATE. Last modify: ${DateTime.now()}\n');
  data.add('library $moduleName;\n');

  await recursive(Directory('$path/lib'));

  final file = File('$path/lib/$moduleName.dart');

  file.writeAsStringSync(data.join('\n'));
}
