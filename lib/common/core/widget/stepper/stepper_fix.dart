import 'package:achitecture_weup/common/core/app_core.dart';
import 'package:flutter/material.dart';

class StepperFix extends StatefulWidget {
  final List<Widget> items;

  const StepperFix({Key? key, required this.items}) : super(key: key);

  @override
  State<StepperFix> createState() => _StepperFixState();
}

class _StepperFixState extends State<StepperFix> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComp(
        title: 'Stepper',
        iconLeading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.clear, color: Colors.white)),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 60),
        child: widget.items[current],
        // child: SizedBox(),
      ),
      bottomSheet: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(
            vertical: 6, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (current != 0)
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor)),
                onPressed: () {
                  if (current < 1) {
                    current = 0;
                  } else {
                    current--;
                  }
                  setState(() {});
                },
                child: Text(
                  'Pre',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ElevatedButtonComp(
              title:current == widget.items.length - 1 ? 'Confirm' : 'Next' ,
              onPressed: () {
                if (current < widget.items.length - 1) {
                  setState(() {
                    current++;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
