

import 'package:get/get.dart';

import 'AppUtility.dart';

extension IntegerExtension on int {
  double get h => AppUtility.getHeight(this);

  double get w => AppUtility.getWidth(this);

  double get sp => AppUtility.sp(this);
}

extension DoubleExtension on double {
  double get h => AppUtility.getHeight(this);

  double get w => AppUtility.getWidth(this);

  double get sp => AppUtility.sp(this);
}

class IsolationData {
  String loginToken;
  FormData formData;
  String endPoint;
  bool put;

  IsolationData({
    required this.loginToken,
    required this.formData,
    required this.endPoint,
    required this.put,
  });
}

extension StringExtension on String? {
  String get fileName {
    try {
      var pathArray = this!.split("/");
      return pathArray[pathArray.length - 1];
    } catch (e) {
      return this ?? "";
    }
  }

  int toInt() {
    try {
      return int.tryParse(this ?? "0") ?? 0;
    } catch (e) {
      return 0;
    }
  }

  num toNum() {
    try {
      return num.tryParse(this ?? "0") ?? 0;
    } catch (e) {
      return 0;
    }
  }

  String get firstLetter {
    try {
      return this!.substring(0, 1);
    } catch (e) {
      return this ?? "";
    }
  }

  String get dummyText {
    try {
      if (this?.isEmpty ?? false) {
        return "0";
      } else {
        return this ?? "0";
      }
    } catch (e) {
      return "0";
    }
  }

  String get dummyDate {
    try {
      if (this?.isEmpty ?? false) {
        return "1992/01/23";
      } else {
        return this ?? "1992/01/23";
      }
    } catch (e) {
      return "1992/01/23";
    }
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
        .hasMatch(this);
  }
}
