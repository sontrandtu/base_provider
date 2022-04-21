import 'package:flutter/material.dart';

class SwitchButtonComp extends StatelessWidget {
  const SwitchButtonComp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return GestureDetector(
            onTap: () {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }
              widget.value == false
                  ? widget.onChanged(true)
                  : widget.onChanged(false);
            },
            child: Container(
              width: 45.0,
              height: 28.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: _circleAnimation.value ==
                    Alignment.centerLeft
                    ? Colors.grey
                    : Colors.blue,),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
                child: Container(
                  alignment: widget.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          )
        });
  }

}

