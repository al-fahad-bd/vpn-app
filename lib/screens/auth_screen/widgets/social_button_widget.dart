import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialButtonWidget extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback? onPressed;

  const SocialButtonWidget({
    super.key,
    required this.text,
    required this.iconPath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        minimumSize: const Size(
          double.infinity,
          65,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.white,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      icon: SvgPicture.asset(
        iconPath, // Path to your SVG file
        width: 18, // Adjust size as needed
        height: 18,
      ),
      label: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'Gilroy',
          fontSize: 16,
        ),
      ),
      onPressed: onPressed,
    );
  }
}