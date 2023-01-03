import 'dart:async';
import 'dart:io';

import '../common/common_function.dart';
import '../common/definations.dart';
import '../common/file_helper.dart';
import '../res/templates/asset/assets.dart';
import '../res/templates/asset/image_assets.dart';
import '../res/templates/asset/other_assets.dart';
import '../res/templates/asset/svg_assets.dart';

class AssetFile {
  final String variableName;
  final String filePath;

  AssetFile({required this.variableName, required this.filePath});
}

Future<void> generateAsset({
  required List<String> paths,
  required String output,
  String? root,
}) async {
  await FilesHelper.createFolder(output);
  final listAssets = <AssetFile>[];
  for (final p in paths) {
    final dir = Directory(p);

    final List<FileSystemEntity> entities = await dir.list().toList();
    for (final f in entities.whereType<File>()) {
      final fileName = f.path.split('/').last.split('.').first;
      listAssets.add(AssetFile(
        variableName: camelCase(fileName),
        filePath: f.path,
      ));
    }
  }
  listAssets.sort((a, b) => a.variableName.compareTo(b.variableName));
  var svgContentFile = '';
  var imageContentFile = '';
  var otherContentFile = '';
  for (final a in listAssets) {
    var append = '';

    append += root != null ? '\n\n  // [$root/${a.filePath}]' : '';
    final line = '  final String ${a.variableName} = \'${a.filePath}\';';
    if (line.length > 80) {
      append += '''\n  final String ${a.variableName} =
      '${a.filePath}';''';
    } else {
      append += '\n$line';
    }
    if (['.png', '.jpg', '.jpeg'].any((ext) => a.filePath.contains(ext))) {
      imageContentFile += append;
    } else if (['.svg'].any((ext) => a.filePath.contains(ext))) {
      svgContentFile += append;
    } else {
      otherContentFile += append;
    }
  }
  await FilesHelper.writeFile(
    pathFile: '${output}assets.dart',
    content: assetsRes,
  );

  await FilesHelper.writeFile(
    pathFile: '${output}image_assets.dart',
    content: imageAssetsRes.replaceFirst(contentKey, imageContentFile),
  );

  await FilesHelper.writeFile(
    pathFile: '${output}svg_assets.dart',
    content: svgAssetsRes.replaceFirst(contentKey, svgContentFile),
  );

  await FilesHelper.writeFile(
    pathFile: '${output}other_assets.dart',
    content: otherAssetsRes.replaceFirst(contentKey, otherContentFile),
  );
}
