import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingProgress() async {
  String someValue = await Get.showOverlay(
      loadingWidget: Container(
        child: const Center(child: CircularProgressIndicator()),
      ),
      asyncFunction: () =>
      Future<String>.delayed(Duration(seconds: 5), () => "Wow i love it"));
  print(someValue);
}

Widget loadingWidget() => const Center(child: CircularProgressIndicator());
