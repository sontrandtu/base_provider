import 'dart:async';
import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:achitecture_weup/common/core/widget/camera/camera_option_button.dart';
import 'package:achitecture_weup/common/helper/app_common.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'camera_button.dart';

late List<CameraDescription> cameras;

class CameraViewer extends StatefulWidget {
  const CameraViewer({Key? key}) : super(key: key);

  @override
  _CameraViewerState createState() {
    return _CameraViewerState();
  }
}

class _CameraViewerState extends State<CameraViewer> with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  late AnimationController _flashModeControlRowAnimationController;
  late AnimationController _focusModeControlRowAnimationController;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentScale = 1.0;
  double _baseScale = 1.0;
  int _pointers = 0;

  @override
  void initState() {
    super.initState();
    _ambiguate(WidgetsBinding.instance)?.addObserver(this);

    _flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _focusModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    _flashModeControlRowAnimationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }

  void logError(String code, String? message) {
    if (message != null) {
      showError('Error: $code\nError Message: $message');
    } else {
      showError('Error: $code');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Center(child: _cameraPreviewWidget()),
          ),
          Align(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CameraButton(onTap: onTakePictureButtonPressed),
            ),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            child: SafeArea(child: _modeControlRowWidget()),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const CircularProgressIndicator();
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (details) => onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    if (controller == null || _pointers != 2) {
      return;
    }

    _currentScale = (_baseScale * details.scale).clamp(_minAvailableZoom, _maxAvailableZoom);

    await controller!.setZoomLevel(_currentScale);
  }

  Widget _modeControlRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          CameraOptionButton(
            icon: Icons.close,
            onTapCallback: () {
              Navigator.of(context).pop();
            },
          ),
          const Spacer(),
          _cameraTogglesButton(),
          // SizedBox(width: 15, height: 15),
          //  _focusModeButton(),
          const SizedBox(width: 15, height: 15),
          _flashModeButton(),
        ],
      ),
    );
  }

  int _indexFlash(int current, int max) {
    if (current < max) {
      return current + 1;
    }
    return 0;
  }

  Widget _flashModeButton() {
    List<dynamic> _list = [
      FlashMode.off,
      FlashMode.auto,
      FlashMode.always,
      FlashMode.torch,
    ];
    List<IconData> _listIcon = [
      Icons.flash_off,
      Icons.flash_auto,
      Icons.flash_on,
      Icons.highlight,
    ];
    final int index = (controller?.value.flashMode != null) ? _list.indexOf(controller?.value.flashMode) : 0;
    final int nextIndex = _indexFlash(index, _list.length - 1);
    return CameraOptionButton(
      icon: _listIcon.elementAt(index),
      onTapCallback: () {
        onSetFlashModeButtonPressed(_list.elementAt(nextIndex));
      },
    );
  }

  CameraDescription? cameraDescription;

  void _onChanged({required int index, required int nextIndex, required List<CameraDescription> toggles}) {
    if (cameraDescription != null) {
      index = toggles.indexOf(cameraDescription!);
      if (index < toggles.length - 1) {
        nextIndex = index + 1;
      }
    }
    onNewCameraSelected(toggles.elementAt(nextIndex));
  }

  Widget _cameraTogglesButton() {
    final List<CameraDescription> toggles = <CameraDescription>[];
    int index = 0;
    int nextIndex = 0;

    if (cameras.isEmpty) {
    } else {
      for (CameraDescription _cameraDescription in cameras) {
        if (cameraDescription == null && _cameraDescription.lensDirection == CameraLensDirection.back) {
          cameraDescription = _cameraDescription;
          onNewCameraSelected(_cameraDescription);
        }
        toggles.add(_cameraDescription);
      }
    }
    return CameraOptionButton(
      icon: getCameraLensIcon(cameraDescription!.lensDirection),
      onTapCallback: () => _onChanged(toggles: toggles, index: index, nextIndex: nextIndex),
    );
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  void onNewCameraSelected(CameraDescription _cameraDescription) async {
    cameraDescription = _cameraDescription;
    if (controller != null) {
      await controller!.dispose();
    }

    final CameraController cameraController = CameraController(
      _cameraDescription,
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.ultraHigh,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        ViewUtils.toast('Camera error ${cameraController.value.errorDescription}', mode: ToastMode.error);
      }
    });

    try {
      await cameraController.initialize();
      await Future.wait([
        cameraController.getMaxZoomLevel().then((value) => _maxAvailableZoom = value),
        cameraController.getMinZoomLevel().then((value) => _minAvailableZoom = value),
      ]);
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
        });
        Navigator.pop(context, file);
      }
    });
  }

  void onFlashModeButtonPressed() {
    if (_flashModeControlRowAnimationController.value == 1) {
      _flashModeControlRowAnimationController.reverse();
    } else {
      _flashModeControlRowAnimationController.forward();
      _focusModeControlRowAnimationController.reverse();
    }
  }

  void onFocusModeButtonPressed() {
    if (_focusModeControlRowAnimationController.value == 1) {
      _focusModeControlRowAnimationController.reverse();
    } else {
      _focusModeControlRowAnimationController.forward();
      _flashModeControlRowAnimationController.reverse();
    }
  }

  void onAudioModeButtonPressed() {
    if (controller != null) {
      onNewCameraSelected(controller!.description);
    }
  }

  void onCaptureOrientationLockButtonPressed() async {
    try {
      if (controller != null) {
        final CameraController cameraController = controller!;
        if (cameraController.value.isCaptureOrientationLocked) {
          await cameraController.unlockCaptureOrientation();
        } else {
          await cameraController.lockCaptureOrientation();
        }
      }
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  void onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) setState(() {});
    });
  }

  void onSetFocusModeButtonPressed(FocusMode mode) {
    setFocusMode(mode).then((_) {
      if (mounted) setState(() {});
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setFocusMode(FocusMode mode) async {
    if (controller == null) {
      return;
    }

    try {
      await controller!.setFocusMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }


  Future<XFile?> takePicture() async {
    bool taking = false;
    if (!taking) {
      taking = true;
      final CameraController? cameraController = controller;
      if (cameraController == null || !cameraController.value.isInitialized) {
        ViewUtils.toast('Error: select a camera first.', mode: ToastMode.error);
        taking = false;
        return null;
      }

      if (cameraController.value.isTakingPicture) {
        taking = false;
        return null;
      }

      try {
        XFile file = await cameraController.takePicture();
        taking = false;
        return file;
      } on CameraException catch (e) {
        taking = false;
        _showCameraException(e);
        return null;
      }
    }
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    ViewUtils.toast('Error: ${e.code}\n${e.description}', mode: ToastMode.error);
  }
}

class CameraApp extends StatelessWidget {
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CameraViewer(),
    );
  }
}

T? _ambiguate<T>(T? value) => value;
