import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? buttonWidth;
  final double? buttonHeight;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.horizontalPadding,
    this.verticalPadding,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
    this.buttonWidth,
    this.buttonHeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            backgroundColor ?? const Color(0xff674FF7), // Default color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(borderRadius ?? 24), // Default radius
        ),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 32, // Default horizontal padding
          vertical: verticalPadding ?? 20, // Default vertical padding
        ),
        minimumSize: Size(
          buttonWidth ??
              MediaQuery.of(context).size.width * 0.9, // Default width
          buttonHeight ??
              MediaQuery.of(context).size.height * 0.05, // Default height
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16, // Default font size
          color: textColor ?? Colors.white, // Default text color
          fontFamily: 'Gilroy',
          fontWeight: fontWeight ?? FontWeight.w500, // Default font weight
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
