import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:achitecture_weup/common/helper/image_utils/image_utils.dart';
import 'package:achitecture_weup/common/helper/system_utils.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:achitecture_weup/common/extension/string_extension.dart';

import 'image/view_image.dart';

class FormAlbum extends StatefulWidget {
  final ValueChanged<List<Map<String, dynamic>>> onChanged;

  const FormAlbum({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FormAlbum> createState() => _FormAlbumState();
}

class _FormAlbumState extends State<FormAlbum> {
  late List<Map<String, dynamic>> _items;

  late List<AssetEntity>? _assetEntities;
  int maxLength = 3;

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
        mainAxisAlignment: _items.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: _onSelect,
            child: _LayoutImage(
              child: const Icon(Icons.image),
              hasMargin: _items.isNotEmpty ? true : false,
              isRoot: true,
            ),
          ),
          if (!systemIsEmpty(_items)) ...[
            Expanded(
              child: SizedBox(
                height: 70,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List<Widget>.generate(
                      (_items.length > maxLength ? maxLength : _items.length),
                      (index) => _LayoutImage(
                            child: ImageViewer('${_items[index]['path']}', fit: BoxFit.fill, hasViewImage: true),
                            hasMargin: _items[index]['isLast'] != null && _items[index]['isLast'] == 1 ? false : true,
                            isRoot: false,
                            onDelete: _onDelete,
                          ))
                    ..add(
                      _items.length > maxLength
                          ? _LayoutImage(
                              onTap: () {
                                _onViewMore(_items);
                              },
                              child: Text(
                                KeyLanguage.viewMore.tl,
                                style: const TextStyle(fontSize: 12),
                              ),
                              hasMargin: _items.isNotEmpty ? true : false,
                              isRoot: true,
                            )
                          : const SizedBox.shrink(),
                    ),
                ),
              ),
            ), // else
          ],
        ],
      ),
    );
  }

  void _onViewMore(List items) => Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => ViewImage(ImageData(urls: []))));

  void _onSelect() async {
    final result = await ImageUtils.multiply(
      context,
      values: _assetEntities,
    );
    if (!systemIsEmpty(result)) {
      setState(() {
        _items = result;
        _genAssetEntity(_items);
      });
    }
    widget.onChanged.call(_items);
  }

  void _onDelete() {
    setState(() {
      _items.removeWhere((item) => item['id'] == _items.first['id']);
      _genAssetEntity(_items);
    });
    widget.onChanged.call(_items);
  }

  void _genAssetEntity(List inputs) {
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
  final Color? color;

  const _LayoutImage({
    Key? key,
    required this.child,
    this.onTap,
    this.hasMargin = true,
    this.onDelete,
    this.isRoot = false,
    this.color,
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color ?? Colors.grey.withOpacity(.2),
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
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
