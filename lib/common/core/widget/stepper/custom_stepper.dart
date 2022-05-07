import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  final List<Step> steps;
  final StepperType type;
  final VoidCallback? onStepCancel;
  final VoidCallback? onStepContinue;
  final double? elevation;
  final EdgeInsets? margin;
  final ValueChanged? onStepTapped;
  final ScrollPhysics? physics;
  final ControlsWidgetBuilder? controlsBuilder;

  const CustomStepper(
      {Key? key,
      required this.steps,
      this.type = StepperType.vertical,
      this.onStepCancel,
      this.onStepContinue,
      this.elevation,
      this.margin, this.onStepTapped, this.physics, this.controlsBuilder})
      : super(key: key);

  @override
  State<CustomStepper> createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Stepper(
      steps: widget.steps,
      currentStep: current,
      type: widget.type,
      onStepCancel: widget.onStepCancel,
      elevation: widget.elevation,
      onStepContinue: widget.onStepContinue,
      margin: widget.margin,
      onStepTapped: widget.onStepTapped,
      physics: widget.physics,
      controlsBuilder: widget.controlsBuilder,
    );
  }
}
