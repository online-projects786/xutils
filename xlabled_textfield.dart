import 'package:flutter/material.dart';

class XLabledTextField extends StatelessWidget {
  final int maxLines;
  final int minLines;
  final String hint;
  final String label;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double fontSize;
  final double contentPadding;
  final double height;
  final double width;
  final double labelFontSize;
  final double spaceBWLabelAndText;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  const XLabledTextField({
    Key? key,
    this.maxLines = 1,
    this.minLines = 1,
    this.hint = "",
    this.borderColor = Colors.blue,
    this.borderWidth = 20,
    this.borderRadius = 0,
    this.fontSize = 20,
    this.contentPadding = 10,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.height = 30,
    this.width = 200,
    this.label = "",
    this.labelFontSize = 25,
    this.spaceBWLabelAndText = 12,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      contentPadding: EdgeInsets.all(contentPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      hintText: hint,
    );

    TextStyle textStyle = TextStyle(fontSize: fontSize);
    return SizedBox(
      height: height,
      width: width,
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: labelFontSize),
          ),
          SizedBox(width: spaceBWLabelAndText),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              autocorrect: autocorrect,
              enableSuggestions: enableSuggestions,
              maxLines: maxLines,
              minLines: minLines,
              decoration: decoration,
              style: textStyle,
            ),
          ),
        ],
      ),
    );
  }
}
