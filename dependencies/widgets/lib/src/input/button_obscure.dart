import 'package:flutter/material.dart';

import '../button/ink_well_comp.dart';

class ButtonObscure extends StatelessWidget {
  const ButtonObscure({Key? key, this.isObscure, this.onObscureChange}) : super(key: key);
  final bool? isObscure;
  final Function()? onObscureChange;

  @override
  Widget build(BuildContext context) {
    return InkWellComp(
      onTap: onObscureChange,
      child: SizedBox(
        width: 24,
        height: 24,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: _buildTransition,
          child: isObscure ?? false
              ? const Icon(Icons.remove_red_eye, key: ValueKey('active'), size: 24)
              : const Icon(Icons.visibility_off, key: ValueKey('inactive'), size: 24),
        ),
      ),
    );
  }

  Widget _buildTransition(Widget child, Animation<double> animation) {
    return SizeTransition(sizeFactor: animation, child: FadeTransition(opacity: animation, child: child));
  }
}
