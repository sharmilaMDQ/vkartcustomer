import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vkartcustomer/Components/AppTheme.dart';
import 'AppText.dart';

class AppTab extends StatelessWidget {
  final EdgeInsets? margin, padding;
  final bool isSelected;
  final String title;
  final Function() onClick;
  final bool disable;

  const AppTab({
    this.margin,
    this.padding,
    this.isSelected = false,
    this.title = '',
    required this.onClick,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !disable,
      child: GestureDetector(
        onTap: () => onClick(),
        child: Container(
          padding: padding ??
              EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
          margin: margin ??
              EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02,
                  vertical: 1),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.Buttoncolor : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppTheme.Buttoncolor : AppTheme.BorderColor,
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.07,
          child: AppText(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : AppTheme.Frontcolor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
