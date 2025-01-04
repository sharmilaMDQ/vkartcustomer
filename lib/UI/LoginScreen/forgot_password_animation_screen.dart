import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordAnimationScreen extends StatelessWidget {
  const ForgotPasswordAnimationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(

      child: Center(
        child:Lottie.asset(
                            'assets/icons/Animation - 1735627705840 (1).json', // Path to Lottie animation

                            fit: BoxFit.fill,
                          ) ,
      ),
    );
  }
}