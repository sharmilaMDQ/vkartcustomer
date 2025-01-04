import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vkartcustomer/Forms/AppText.dart';
import 'package:vkartcustomer/Forms/typography.dart';
import '../utility/AppColor.dart';
import 'AppStyles.dart';

class TextFormsField extends StatelessWidget {
  TextFormsField({
    super.key,
    this.controller,
    required this.hintText,
    this.errorText = '',
    this.obscureText = false,
    this.suffixIcon,
    this.prefix,
    this.onSuffixTap,
    this.validate,
    this.onChanged,
    this.isValid = '',
    this.onPrefixTap,
    this.keyboardType,
    this.title,
    this.onSaved,
    this.inputFormatters,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength = 50,
  });

  final TextEditingController? controller;
  final String hintText;
  final String errorText;
  final String? title;
  final String? isValid;
  final int? validate;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSaved;

  final GestureTapCallback? onSuffixTap;
  final GestureTapCallback? onPrefixTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isEmpty ?? false) ...{
          AppText(title ?? '',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: (validate == 1)
                  ? AppColors.appGrey
                  : (validate == 0)
                      ? AppColors.appRed
                      : AppColors.appGrey),
          SizedBox(height: 5),
        },
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
                color: (validate == 1)
                    ? AppColors.appGrey
                    : (validate == 0)
                        ? AppColors.appRed
                        : AppColors.appGrey),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (prefix != null) ...[
                Insets.gapW5,
                InkWell(onTap: onPrefixTap, child: prefix),
              ],
              Expanded(
                child: TextFormField(
                  maxLines: maxLines,
                  minLines: minLines,
                  maxLength: maxLength,
                  onFieldSubmitted: onSaved ?? (String value) {},
                  keyboardType: keyboardType ?? TextInputType.text,
                  controller: controller,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  inputFormatters: inputFormatters,
                  style: const TextStyle(color: AppColors.black, fontFamily: TextFontFamily.openSans, fontSize: 16),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(bottom: 4, left: 16),
                    border: InputBorder.none,
                    hintText: hintText,
                    counterText: "",
                    hintStyle: const TextStyle(color: AppColors.appGrey, fontFamily: TextFontFamily.openSans, fontSize: 14),
                  ),
                ),
              ),
              if (suffixIcon != null) ...[
                InkWell(
                  onTap: onSuffixTap,
                  child: suffixIcon ?? const SizedBox(),
                ),
                const SizedBox(width: 12),
              ],
            ],
          ),
        ),
        if (errorText.isNotEmpty) ...[
          const SizedBox(height: 8),
          AppText(
            errorText,
            color: AppColors.appRed,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
