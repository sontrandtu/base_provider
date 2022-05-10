import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  State<IntroducePage> createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Title of first page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: Image.asset("assets/images/1.jpg", height: 220),
      ),
    ),
    PageViewModel(
      title: "Title of second page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: Image.asset("assets/images/2.jpg", height: 220),
      ),
    ),
    PageViewModel(
      title: "Title of third page",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: Image.asset("assets/images/3.jpg", height: 220),
      ),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPagesViewModel,
      onDone: () {
      },
      showBackButton: false,
      showSkipButton: true,
      showNextButton: true,
      next: const Text("next"),
      skip: const Text("Skip"),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      ),
    );
  }
}
