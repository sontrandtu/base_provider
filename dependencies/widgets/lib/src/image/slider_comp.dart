import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:widgets/src/image/cached_network_image_comp.dart';

class SliderComp extends StatefulWidget {
  final List<String> images;

  const SliderComp({Key? key, required this.images}) : super(key: key);

  @override
  State<SliderComp> createState() => _SliderCompState();
}

class _SliderCompState extends State<SliderComp> {
  int activeIndex = 0;

  Widget buildIndicator(sliders) => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: sliders.length,
      effect: WormEffect(
          dotWidth: 6,
          dotHeight: 6,
          activeDotColor: sliders.isNotEmpty ? Theme.of(context).primaryColor : Colors.transparent,
          dotColor: sliders.isNotEmpty ? Colors.grey : Colors.transparent));

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              return CachedNetworkImageComp(
                url: widget.images[index],
                width: 355,
                height: 160,
                borderRadius: BorderRadius.circular(8),
              );
            },
            options: CarouselOptions(
              height: 160,
              initialPage: 0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          buildIndicator(widget.images),
        ],
      ),
    );
  }
}
