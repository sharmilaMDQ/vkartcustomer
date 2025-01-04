import 'package:flutter/material.dart';

class NoOffersProductScreen extends StatefulWidget {
  const NoOffersProductScreen({super.key});

  @override
  State<NoOffersProductScreen> createState() => _NoOffersProductScreenState();
}

class _NoOffersProductScreenState extends State<NoOffersProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 500,
      decoration: BoxDecoration(
        
      ),
      child: Column(
        children: [
          Image.asset("assets/images/no offers available screen.jpg"),
        ],
      ),
    );
  }
}