import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String title;
  final dynamic description;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onConfirm;
  final bool isAccept;
  final bool isCancel;
  final VoidCallback? onCancel;
  final bool isClose;
  final TextAlign? textAlign;

  const CustomDialog(
      {required this.title,
      required this.description,
      this.onConfirm,
      this.isAccept = true,
       this.confirmText = 'Đồng ý',
       this.cancelText = 'Hủy',
      this.isCancel = false,
      this.onCancel,
      this.isClose = false,
      this.textAlign,
      Key? key})
      : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(top: 12),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Visibility(
            visible: widget.isClose,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {},
                    child: const Icon(Icons.close),
                  )),
            ),
          ),
          Center(
            child: Text(
              widget.title.toUpperCase(),
              textAlign: TextAlign.center,
              // style:,
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 22),
            child: widget.description is Widget ? widget.description : Text(
              widget.description,
              style: const TextStyle(
                fontSize: 14,fontWeight: FontWeight.w600,),
              textAlign: widget.textAlign ?? TextAlign.center,
            ),
          ),
          ViewUtils.divider(),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 41,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(15)),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: widget.onCancel,
                    child: Center(child: Text(widget.cancelText)),
                  ),
                ),
              ),
              Container(
                height: 41,
                width: 1,
                color: Colors.black.withOpacity(0.1),
              ),
              Expanded(
                child: Container(
                  height: 41,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(15)),
                  ),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: widget.onConfirm,
                    child: Center(child: Text(widget.confirmText)),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
