import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Forms/AppSnackBar.dart';
import 'AppTheme.dart';

class Button extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;
  final BorderSide borderColor;

  Button({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
    this.borderColor = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(color: AppTheme.Buttoncolor, borderRadius: BorderRadius.circular(25.0)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.Buttoncolor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: borderColor)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class Button3 extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;
  final BorderSide borderColor;

  Button3({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
    this.borderColor = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(color: AppTheme.Buttoncolor, borderRadius: BorderRadius.circular(25.0)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.Buttoncolor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0), side: borderColor)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;

  Button1({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppTheme.Buttoncolor), borderRadius: BorderRadius.circular(8.0)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class TextInput1 extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCapsNumeric;
  final double? height;
  final double? contentPaddingV;
  final String? hintText;
  final String? errorText;
  final String? imagePath;
  final bool obscureText;
  final bool margin;
  final bool isEntryField;
  final bool withImage;
  final bool isSelected;
  final bool isMistake;
  final bool textVisible;
  final bool isCapital;
  final bool demoCar;
  final int? MaxLength;
  final int? maxLines; // Add this line
  final bool isReadOnly;
  final bool enableInteractiveSelection;
  final Color textColor;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedSuffixIcon;
  final String? icon;
  final void Function(String) onTextChange;
  final Icon? sufficIcon;
  final FocusNode? focusNode;
  final Color hintTextColor;
  final Color labelTextColor;

  const TextInput1({
     this.label,
    required this.onTextChange,
     this.maxLines,
    this.obscureText = false,
    this.isReadOnly = false,
    this.withImage = false,
    this.isCapsNumeric = false,
    this.isEntryField = true,
    this.isSelected = false,
    this.isMistake = false,
    this.isCapital = false,
    this.demoCar = false,
    this.MaxLength,
    this.imagePath,
    this.margin = true,
    this.enableInteractiveSelection = true,
    this.controller,
    this.contentPaddingV,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.height,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.onPressedSuffixIcon,
    this.textInputType,
    this.icon,
    this.textVisible = false,
    this.sufficIcon,
    this.textColor = AppTheme.textColor,
    this.hintTextColor = AppTheme.lableColor90,
    this.labelTextColor = AppTheme.borderLightGrey,
    this.focusNode,
  });

  @override
  State<TextInput1> createState() => _TextInput1State();
}

class _TextInput1State extends State<TextInput1> {
  bool showPassword = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.hintText!.split('\n');
    //double width = MediaQuery.of(context).size.width;
    //double height = MediaQuery.of(context).size.height;
    return Container(
      //color: widget.isEntryField ? AppTheme.appColor : Colors.white,
      margin: widget.margin ? EdgeInsets.fromLTRB(12, 14, 12, 0) : EdgeInsets.only(top: 0, bottom: 0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        widget.isEntryField
            ? Material(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                color: Colors.white,
                child: TextFormField(
                  
                  focusNode: widget.focusNode,
                  autofocus: false,
                  autocorrect: false,
                  obscureText: widget.textVisible,
                  enableSuggestions: false,
                  onTap: widget.onPressed,
                  enableInteractiveSelection: widget.enableInteractiveSelection,
                  readOnly: widget.isReadOnly ? true : false,
                  keyboardType: widget.textInputType,
                  textInputAction: TextInputAction.done,
                  textCapitalization: widget.isCapital ? TextCapitalization.characters : TextCapitalization.words,
                  minLines: widget.textInputType == TextInputType.multiline ? 3 : 1,
                  maxLines: widget.textInputType == TextInputType.multiline ? 3 : 1,
                  inputFormatters: widget.isCapsNumeric
                      ? <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp("[0-9A-Z]")),
                        ]
                      : widget.textInputType! == TextInputType.number || widget.textInputType! == TextInputType.phone
                          ? [FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),.?":{}|<>]')), LengthLimitingTextInputFormatter(10)]
                          : [
                              FilteringTextInputFormatter.deny(RegExp(r'#')),
                              // FilteringTextInputFormatter.allow("[a-zA-Z0-9\s]"),

                              // Disallow suggestions WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9\s]")),
                            ],
                  maxLength: null,
    
                  onChanged: widget.onTextChange,
                  controller: widget.controller,
                  style: GoogleFonts.poppins(letterSpacing: 0.2, color: widget.textColor, fontWeight: FontWeight.w400, fontSize: 14),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: widget.label,
                    counter: Offstage(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                        color: widget.controller.isNull
                            ? AppTheme.textColor
                            : widget.controller!.value.text.isEmpty
                                ? AppTheme.textColor
                                : AppTheme.lableColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    hintText: widget.hintText,
                    hintStyle: GoogleFonts.poppins(
                      color: AppTheme.lableColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                    errorText: widget.errorText,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: widget.contentPaddingV.isNull ? 10.0 : widget.contentPaddingV!),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: BorderSide(width: 1.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: const BorderSide(width: 1.0, color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide: widget.isMistake
                          ? BorderSide(color: Colors.deepOrangeAccent, width: 1.0)
                          : BorderSide(color: Color(0x4d252525), width: 1.0),
                    ),
                    suffixIcon: widget.obscureText
                        ? IconButton(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            color: Color(0xff252525),
                            onPressed: widget.onPressedSuffixIcon,
                            icon: widget.sufficIcon == null ? const Icon(Icons.keyboard_arrow_down) : widget.sufficIcon!,
                          )
                        : null,
                  ).copyWith(
                    focusedBorder: FormThemes.inputOutlineBorder['focusedBorder'],
                    border: FormThemes.inputOutlineBorder['border'],
                    errorBorder: FormThemes.inputOutlineBorder['errorBorder'],
                    disabledBorder: FormThemes.inputOutlineBorder['disabledBorder'],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.5),
                      borderSide:
                          widget.isMistake ? BorderSide(color: Colors.deepOrangeAccent, width: 1.0) : BorderSide(color: Colors.grey, width: 1.0),
                    ),
                  ),
                ),
              )
            : InkWell(
                onTap: widget.onPressed,
                child: Container(
                  margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                  decoration: BoxDecoration(
                    color: widget.isSelected ? AppTheme.selectedOrange : Colors.white,
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          lines[0],
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: widget.isSelected ? Colors.deepOrangeAccent : Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          lines[1],
                          style:
                              TextStyle(color: widget.isSelected ? Colors.deepOrangeAccent : Colors.black, fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              )
      ]),
    );
  }
}
