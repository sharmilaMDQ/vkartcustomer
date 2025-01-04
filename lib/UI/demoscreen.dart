import 'package:flutter/material.dart';

class StepperEx extends StatefulWidget {
  @override
  _StepperExState createState() => _StepperExState();
}

class _StepperExState extends State<StepperEx> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  switchStepType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Stepper(
                steps: _stepper(),
                type: stepperType,
                currentStep: this._currentStep,
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
                // controlsBuilder: (BuildContext context,
                //     {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
                //   return null; // Return null to remove the buttons
                // },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text('Order Placed'),
        content: Column(
          children: <Widget>[],
        ),
        isActive: _currentStep >= 0,
        state: StepState.complete,
      ),
      Step(
        title: Text('Product'),
        content: Column(
          children: <Widget>[],
        ),
        isActive: _currentStep >= 2,
        state: StepState.complete,
      ),
      Step(
        title: Text('Processing'),
        content: Column(
          children: <Widget>[],
        ),
        isActive: _currentStep >= 2,
        state: StepState.complete,
      ),
      Step(
        title: Text('On the way'),
        content: Column(
          children: <Widget>[],
        ),
        isActive: _currentStep >= 3,
        state: StepState.complete,
      ),
      Step(
        title: Text('Delivery'),
        content: Column(
          children: <Widget>[],
        ),
        isActive: _currentStep >= 4,
        state: StepState.complete,
      ),
    ];
    return _steps;
  }
}
