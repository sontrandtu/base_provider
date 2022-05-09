import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/helper/image_utils/image_utils.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';

class FormAlbum extends StatefulWidget {
  final ValueChanged<List<Map<String, dynamic>>> onChanged;
  const FormAlbum({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<FormAlbum> createState() => _FormAlbumState();
}

class _FormAlbumState extends State<FormAlbum> {
  late List<Map<String, dynamic>> _items;

  late List<AssetEntity>? _assetEntities;

  @override
  void initState() {
    _items = [];
    _assetEntities = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: DottedDecoration(
        shape: Shape.box,
        strokeWidth: .3,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async {
              final result = await ImageUtils.multiply(
                context,
                selectedAssets: _assetEntities,
              );
              if (!empty(result)) {
                setState(() {
                  _items = result;
                  _genAssetEntity(_items);
                });
              }
            },
            child: _LayoutImage(
              child: const Icon(Icons.image),
              hasMargin: _items.isNotEmpty ? true : false,
              isRoot: true,
            ),
          ),
          if (!empty(_items)) ...[
            if (_items.length <= 2) ...[
              ..._items
                  .map<Widget>((e) => _LayoutImage(
                        child: ImageViewer('${e['path']}', boxFit: BoxFit.fill),
                        hasMargin: e['isLast'] != null && e['isLast'] == 1
                            ? false
                            : true,
                        isRoot: false,
                        onDelete: () {
                          setState(() {
                            _items.removeWhere((item) => item['id'] == e['id']);
                            _genAssetEntity(_items);
                          });
                        },
                      ))
                  .toList()
            ] else ...[
              _LayoutImage(
                child: Center(child: Text('${_items.length} ' + KeyLanguage.images.tl)),
                hasMargin: _items.isNotEmpty ? true : false,
                isRoot: true,
              ),
            ],
          ],
        ],
      ),
    );
  }

  _genAssetEntity(List inputs) {
    _assetEntities = [];
    for (var element in inputs) {
      _assetEntities!.add(AssetEntity(
        id: element['id'],
        width: element['width'],
        height: element['height'],
        typeInt: element['typeInt'],
      ));
    }
  }
}

class _LayoutImage extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool hasMargin;
  final bool isRoot;

  const _LayoutImage({
    Key? key,
    required this.child,
    this.onTap,
    this.hasMargin = true,
    this.onDelete,
    this.isRoot = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: !hasMargin ? EdgeInsets.zero : const EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.2),
                ),
                child: child,
              ),
            ),
            if (!isRoot)
              Positioned(
                right: 0,
                top: 0,
                child: InkWell(
                  onTap: onDelete,
                  // backgroundColor: Colors.white,
                  // borderRadiusAll: 50,
                  // padding: EdgeInsets.all(2),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: const Icon(
                      Icons.delete,
                      size: 16,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
