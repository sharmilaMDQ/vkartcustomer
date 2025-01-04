import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSnackBar {
  String title;
  String message;

  AppSnackBar({required this.title, required this.message}) {
    print("HERE");
  }

  AppSnackBar.error({
    required this.message,
    this.title = "Error",
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message, backgroundColor: Colors.redAccent, margin: const EdgeInsets.all(10.0), forwardAnimationCurve: Curves.easeOutBack);
  }

  AppSnackBar.success({required this.message, this.title = "Success"}) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message, backgroundColor: Colors.greenAccent, margin: const EdgeInsets.all(10.0), forwardAnimationCurve: Curves.easeOutBack);
  }

  AppSnackBar.warning({required this.title, required this.message}) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message, backgroundColor: Colors.orangeAccent, margin: const EdgeInsets.all(10.0), forwardAnimationCurve: Curves.easeOutBack);
  }
}

class AppButton2 extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final double fontSize;
  final VoidCallback onPressed;
  final Color titleColor;
  final Color color;
  final Color borderColor;
  final FontWeight fontWeight;

  const AppButton2({
    required this.width,
    required this.height,
    required this.title,
    required this.fontSize,
    required this.onPressed,
    required this.titleColor,
    required this.color,
    required this.borderColor,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: titleColor,
          backgroundColor: color,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
    );
  }
}

// class TextInput extends StatefulWidget {
//   final String label;
//   final TextEditingController? controller;
//   final MainAxisSize mainAxisSize;
//   final MainAxisAlignment mainAxisAlignment;
//   final bool isCapsNumeric;
//   final double? height;
//   final double? contentPaddingV;
//   final String? hintText;
//   final String? errorText;
//   final String? imagePath;
//   final bool obscureText;
//   final bool margin;
//   final bool isEntryField;
//   final bool withImage;
//   final bool isSelected;
//   final bool isMistake;
//   final bool isCapital;
//   final bool demoCar;
//   final int? MaxLength;
//   final bool isReadOnly;
//   final bool enableInteractiveSelection;
//   final Color textColor;
//   final TextInputType? textInputType;
//   final VoidCallback? onPressed;
//   final String? icon;
//   final void Function(String) onTextChange;
//   final Icon? sufficIcon;
//   final FocusNode? focusNode;
//   final Color hintTextColor;
//   final Color labelTextColor;
//
//   const TextInput({
//     required this.label,
//     required this.onTextChange,
//     this.obscureText = false,
//     this.isReadOnly = false,
//     this.withImage = false,
//     this.isCapsNumeric = false,
//     this.isEntryField = true,
//     this.isSelected = false,
//     this.isMistake = false,
//     this.isCapital = false,
//     this.demoCar = false,
//     this.MaxLength,
//     this.imagePath,
//     this.margin = true,
//     this.enableInteractiveSelection = true,
//     this.controller,
//     this.contentPaddingV,
//     this.mainAxisSize = MainAxisSize.max,
//     this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
//     this.height,
//     this.hintText,
//     this.errorText,
//     this.onPressed,
//     this.textInputType,
//     this.icon,
//     this.sufficIcon,
//     this.textColor = AppTheme.textColor,
//     this.hintTextColor = AppTheme.lableColor90,
//     this.labelTextColor = AppTheme.borderLightGrey,
//     this.focusNode,
//   });
//
//   @override
//   State<TextInput> createState() => _TextInputState();
// }
//
// class _TextInputState extends State<TextInput> {
//   bool showPassword = false;
//   final TextEditingController _controller = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> lines = widget.hintText!.split('\n');
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//
//     return Container(
//       //color: widget.isEntryField ? AppTheme.appColor : Colors.white,
//         margin: widget.margin
//             ? EdgeInsets.fromLTRB(12, 14, 12, 0)
//             : EdgeInsets.only(top: 0, bottom: 0),
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               widget.isEntryField
//                   ? Material(
//                 borderRadius:
//                 const BorderRadius.all(Radius.circular(4.0)),
//                 color: Colors.white,
//                 child: TextFormField(
//                   focusNode: widget.focusNode,
//                   autofocus: false,
//                   autocorrect: false,
//                   enableSuggestions: false,
//                   onTap: widget.onPressed,
//                   enableInteractiveSelection:
//                   widget.enableInteractiveSelection,
//                   readOnly: widget.isReadOnly ? true : false,
//                   keyboardType: widget.textInputType,
//                   textInputAction: TextInputAction.done,
//                   textCapitalization: widget.isCapital
//                       ? TextCapitalization.characters
//                       : TextCapitalization.words,
//                   minLines:
//                   widget.textInputType == TextInputType.multiline
//                       ? 3
//                       : 1,
//                   maxLines:
//                   widget.textInputType == TextInputType.multiline
//                       ? 3
//                       : 1,
//                   inputFormatters: widget.isCapsNumeric
//                       ? <TextInputFormatter>[
//                     FilteringTextInputFormatter.allow(
//                         RegExp("[0-9A-Z]")),
//                   ]
//                       : widget.textInputType! == TextInputType.number ||
//                       widget.textInputType! == TextInputType.phone
//                       ? [
//                     FilteringTextInputFormatter.deny(
//                         RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
//                     LengthLimitingTextInputFormatter(10)
//                   ]
//                       : [
//                     FilteringTextInputFormatter.deny(
//                         RegExp(r'#')),
//                     // FilteringTextInputFormatter.allow("[a-zA-Z0-9\s]"),
//
//                     // Disallow suggestions WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\s]")),
//                   ],
//                   maxLength: widget.MaxLength,
//                   onChanged: widget.onTextChange,
//                   controller: widget.controller,
//                   style: TextStyle(
//                       letterSpacing: 0.2,
//                       color: widget.textColor,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 14),
//                   decoration: InputDecoration(
//                     border: const OutlineInputBorder(),
//                     labelText: widget.label,
//                     counter: Offstage(),
//                     floatingLabelBehavior: FloatingLabelBehavior.always,
//                     labelStyle: TextStyle(
//                         color: widget.controller.isNull
//                             ? AppTheme.textColor
//                             : widget.controller!.value.text.isEmpty
//                             ? AppTheme.textColor
//                             : AppTheme.lableColor,
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500),
//                     hintText: widget.hintText,
//                     hintStyle: TextStyle(
//                       color: AppTheme.lableColor,
//                     ),
//                     errorText: widget.errorText,
//                     contentPadding: EdgeInsets.symmetric(
//                         horizontal: 10.0,
//                         vertical: widget.contentPaddingV.isNull
//                             ? 10.0
//                             : widget.contentPaddingV!),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.5),
//                       borderSide: BorderSide(width: 1.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.5),
//                       borderSide: widget.isMistake
//                           ? BorderSide(
//                           color: Colors.deepOrangeAccent, width: 1.0)
//                           : BorderSide(
//                           color: Color(0x4d252525), width: 1.0),
//                     ),
//                     suffixIcon: widget.obscureText
//                         ? IconButton(
//                       padding:
//                       EdgeInsets.symmetric(horizontal: 15.0),
//                       color: Color(0xff252525),
//                       onPressed: widget.onPressed,
//                       icon: widget.sufficIcon == null
//                           ? const Icon(Icons.keyboard_arrow_down)
//                           : widget.sufficIcon!,
//                     )
//                         : null,
//                   ).copyWith(
//                     focusedBorder:
//                     FormThemes.inputOutlineBorder['focusedBorder'],
//                     border: FormThemes.inputOutlineBorder['border'],
//                     errorBorder:
//                     FormThemes.inputOutlineBorder['errorBorder'],
//                     disabledBorder:
//                     FormThemes.inputOutlineBorder['disabledBorder'],
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.5),
//                       borderSide: widget.isMistake
//                           ? BorderSide(
//                           color: Colors.deepOrangeAccent, width: 1.0)
//                           : BorderSide(
//                           color: Color(0x4d252525), width: 1.0),
//                     ),
//                   ),
//                 ),
//               )
//                  : InkWell(
//                 onTap: widget.onPressed,
//                 child: Container(
//                   margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
//                   decoration: BoxDecoration(
//                     color: widget.isSelected
//                         ? AppTheme.selectedOrange
//                         : Colors.white,
//                     borderRadius: BorderRadius.circular(5.5),
//                   ),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Text(
//                           lines[0],
//                           style: TextStyle(
//                               overflow: TextOverflow.ellipsis,
//                               color: widget.isSelected
//                                   ? Colors.deepOrangeAccent
//                                   : Colors.black,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         Text(
//                           lines[1],
//                           style: TextStyle(
//                               color: widget.isSelected
//                                   ? Colors.deepOrangeAccent
//                                   : Colors.black,
//                               fontWeight: FontWeight.w400,
//                               fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//
//             ]),
//         );
//     }
// }

class FormThemes {
  static const Color appTheme = Color(0xff9cb533);
  static const Color appLabelColor = Color(0xff202020);
  static const Color appHeaderColor = Color(0xff9e7d49);
  static const Widget SpaceDivider = SizedBox(height: 20.0);
  static const Color inputBorderColor = Color(0xFF52A934);
  static const Color Buttoncolor = Color(0xFF52A934);

  static const TextStyle formHeaderStyle = TextStyle(fontSize: 20.0, color: Color(0xff202020), fontWeight: FontWeight.bold);

  // Textinput
  static const Color labelColor = Colors.white;
  static const BorderRadius inputBorderRadius = BorderRadius.all(Radius.circular(8.0));

  static const Map<String, OutlineInputBorder> inputOutlineBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.grey),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: "disabledBorder" == true ? Colors.grey : inputBorderColor),
    )
  };

  static const BorderRadius inputLeftBorderRadius = BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10));

  static const Map<String, OutlineInputBorder> inputLeftOutlineBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputLeftBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    )
  };

  static const BorderRadius inputRightBorderRadius = BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10));

  static const Map<String, OutlineInputBorder> customRightDropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputRightBorderRadius,
      borderSide: BorderSide(color: inputBorderColor),
    )
  };

  // Buttons
  static MaterialStateProperty<Color> Function(Color btnBGColor) buttonBgColor = (btnBGColor) => MaterialStateProperty.all<Color>(btnBGColor);
  static MaterialStateProperty<Color> Function(Color btnFGColor) buttonFgColor = (btnFGColor) => MaterialStateProperty.all<Color>(btnFGColor);

  // Text buttons
  static MaterialStateProperty<TextStyle> Function({Color textColor}) textButtonStyle =
      ({textColor = Colors.white}) => MaterialStateProperty.all<TextStyle>(TextStyle(color: textColor));

  // Form input
  static const Color formLabelColor = appLabelColor;
  static const Color formInputColor = appTheme;

  // Form Radio
  static const Color formRadioSelectedColor = appTheme;
  static const Color formRadioUnSelectedColor = Color(0xffF1F6FB);
  static MaterialStateProperty<Color> formRadioSelectedLabelColor = MaterialStateProperty.all<Color>(Colors.white);
  static MaterialStateProperty<Color> formRadioUnSelectedLabelColor = MaterialStateProperty.all<Color>(appLabelColor);

  // Form Dropdown
  static const Color formDropdownBorderColor = Color(0xffF5F5F5);
  static const Map<String, OutlineInputBorder> formDropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: formDropdownBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: Colors.white),
    )
  };

  // Dropdown
  static const Color dropdownBorderColor = Color(0xff772D82);
  static const Map<String, OutlineInputBorder> dropdownBorder = {
    "focusedBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "disabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "enabledBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "errorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "focusedErrorBorder": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    ),
    "border": OutlineInputBorder(
      borderRadius: inputBorderRadius,
      borderSide: BorderSide(color: dropdownBorderColor),
    )
  };

  // Form checkbox
  static Color checkBoxColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return Color(0xff34C759);
    }
    return Color(0xffD4D4D4);
  }

  // Gradient Buttons
  static const Gradient successBtnGradient =
      LinearGradient(stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: successBtnGradientColor);
  static const List<Color> successBtnGradientColor = [Color(0xff34C759), Color(0xff00711D)];

  // Danger gradient
  static const Gradient dangerBtnGradient =
      LinearGradient(stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: dangerBtnGradientColor);
  static const List<Color> dangerBtnGradientColor = [Color(0xffFF3737), Color(0xffBE0000)];

  // Stupid designer
  static const Gradient pinkBtnGradient =
      LinearGradient(stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: pinkBtnGradientColor);
  static const List<Color> pinkBtnGradientColor = [Color(0xffF9468E), Color(0xffCB0052)];

  // Stupid designer
  static const Gradient warningBtnGradient =
      LinearGradient(stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: warningBtnGradientColor);
  static const List<Color> warningBtnGradientColor = [Color(0xffFCDE41), Color(0xffFDB107)];

  static const Gradient disableBtnGradient =
      LinearGradient(stops: [0, 1], begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: disableBtnGradientColor);
  static const List<Color> disableBtnGradientColor = [Color(0xffB0B3C4), Color(0xff808895)];
}
