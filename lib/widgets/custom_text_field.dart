import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final String iconPath;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.iconPath,
    this.isPassword = false,
    this.controller,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword && !_isPasswordVisible,
      style: const TextStyle(
        fontFamily: 'Gilroy',
        fontSize: 14,
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.white38,
          fontFamily: 'Gilroy',
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 8.0,
            top: 4.0,
            bottom: 6.0,
          ),
          child: SvgPicture.asset(
            widget.iconPath,
            width: 20,
            height: 20,
          ),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                padding: const EdgeInsets.all(12.0),
                icon: SvgPicture.asset(
                  _isPasswordVisible
                      ? "assets/images/eyeOn.svg"
                      : "assets/images/eyeOff.svg",
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: Colors.black,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: const BorderSide(
            color: Color(0xff674FF7),
          ),
        ),
      ),
    );
  }
}
