part of 'image_viewer.dart';

class _ViewImage extends StatelessWidget {
  final String url;
  final TypeImageViewer type;

  const _ViewImage(this.url, {Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          PhotoView(
            imageProvider: _imageProvider(url),
            enablePanAlways: true,
            loadingBuilder: (context, progress) => Center(
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.8),
                child: const Center(
                  child: CircularProgressIndicator(
                      // value: progress == null
                      //     ? null
                      //     : progress.cumulativeBytesLoaded /
                      //     (progress.expectedTotalBytes ??
                      //         progress.cumulativeBytesLoaded),
                      ),
                ),
              ),
            ),
            // enableRotation: true,
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 1.8,
            initialScale: PhotoViewComputedScale.contained,
            basePosition: Alignment.center,
          ),
          const SafeArea(child: BackButton(color: Colors.white)),
        ],
      ),
    );
  }

  ImageProvider _imageProvider(String url) {
    if (type == TypeImageViewer.network) {
      return NetworkImage(url);
    } else if (type == TypeImageViewer.storage) {
      return FileImage(File(url));
    }
    return ExactAssetImage(url);
  }
}
