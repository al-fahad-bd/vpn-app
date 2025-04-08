import 'package:flutter/material.dart';

class MenuItems extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const MenuItems({
    super.key,
    required this.title,
    this.color = Colors.white,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap events
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 22,
            fontFamily: 'Gilroy',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
