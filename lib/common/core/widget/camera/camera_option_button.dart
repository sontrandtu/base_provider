import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CameraOptionButton extends StatelessWidget {
  final IconData? icon;
  final Function? onTapCallback;
  final AnimationController? rotationController;
  final ValueNotifier<DeviceOrientation>? orientation;
  final bool isEnabled;
  const CameraOptionButton({
    Key? key,
    this.icon,
    required this.onTapCallback,
    this.rotationController,
    this.orientation,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.3,
        child: Transform.rotate(
          angle: 0.0,
          child: ClipOval(
            child: Material(
              color: const Color(0xFF4F6AFF),
              child: InkWell(
                child: SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                ),
                onTap: () {
                  if (onTapCallback != null) {
                    HapticFeedback.selectionClick();
                    onTapCallback!();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}