import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'button/icon_button_comp.dart';

class AniAppBarTitle extends StatefulWidget {
  const AniAppBarTitle({Key? key}) : super(key: key);

  @override
  State<AniAppBarTitle> createState() => _BodyIntroCourseV2Comp();
}

class _BodyIntroCourseV2Comp extends State<AniAppBarTitle> with TickerProviderStateMixin {
  final GlobalKey globalKey = GlobalKey();
  late AnimationController _animationController;
  late AnimationController _animationController2;
  ScrollController controller = ScrollController();
  late Animation _colorTween;
  late Animation<double> _opacityTween, _opacityTween2;
  double y = 0;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 0));
    _animationController2 = AnimationController(vsync: this, duration: const Duration(seconds: 0));

    _colorTween =
        ColorTween(begin: Colors.teal.withOpacity(0.1), end: Colors.teal).animate(_animationController);

    _opacityTween = Tween<double>(begin: 0, end: 1).animate(_animationController2);
    _opacityTween2 = Tween<double>(begin: 1, end: 0).animate(_animationController2);

    controller.addListener(_listener);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      RenderBox box = globalKey.currentContext?.findRenderObject() as RenderBox;
      Offset position = box.localToGlobal(Offset.zero);

      y = position.dy + box.size.height * 2;
    });

    super.initState();
  }

  void _listener() {
    _animationController.animateTo(controller.position.pixels / (y - 80));
    _animationController2.animateTo((controller.position.pixels - 40) / y);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          controller: controller,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 92),
              AnimatedBuilder(
                animation: _opacityTween2,
                builder: (context, child) => Text(
                  'This is title for example very very long long long long long long',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.apply(color: Colors.black.withOpacity(_opacityTween2.value)),
                  key: globalKey,
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: _buildItem),
            ],
          ),
        ),
        SizedBox(
          height: 80,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) => AppBar(
              backgroundColor: _colorTween.value,
              elevation: 0,
              foregroundColor: Colors.red,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              titleSpacing: 0.0,
              centerTitle: true,
              title: Opacity(
                opacity: _opacityTween.value,
                child: Text(
                  'This is title for example very very long long long long long long',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.headline1?.apply(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              leading: IconButtonComp(
                icon: Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
                onPress: () => Navigator.pop(context),
                //splashRadius: 26,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == 0) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Sáng nay 14/04/2022, WeUp Group đã tổ chức thành công chương trình WeUp Open Talk với chủ đề: “Khơi nguồn ý tưởng – Dẫn lối thành công”. Chương trình diễn ra trong không khí gần gũi, hướng tới hoạt động đối thoại nội bộ và xây dựng văn hóa doanh nghiệp. Chương trình Talkshow WeUp Open Talk đã chính lên sóng vào sáng nay 14/04/2022 với chủ đề: “ Khơi nguồn ý tưởng – Dẫn lối thành công”.',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      );
    }
    if (index == 1) {
      return Container(height: 250, width: 150, color: Colors.red);
    }
    if (index == 2) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          'Sáng nay 14/04/2022, WeUp Group đã tổ chức thành công chương trình WeUp Open Talk với chủ đề: “Khơi nguồn ý tưởng – Dẫn lối thành công”. Chương trình diễn ra trong không khí gần gũi, hướng tới hoạt động đối thoại nội bộ và xây dựng văn hóa doanh nghiệp.',
          style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, height: 1.5),
          textAlign: TextAlign.justify,
        ),
      );
    }
    if (index == 3) {
      return Container(height: 350, width: 150, color: Colors.blue);
    }
    if (index == 4) {
      return Text(
        'Sáng nay 14/04/2022, WeUp Group đã tổ chức thành công chương trình WeUp Open Talk với chủ đề: “Khơi nguồn ý tưởng – Dẫn lối thành công”.',
        style: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.black, height: 1.5),
        textAlign: TextAlign.justify,
      );
    }
    if (index == 5) return const SizedBox(height: 32);
    return const SizedBox();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController2.dispose();
    controller.dispose();
    super.dispose();
  }
}
