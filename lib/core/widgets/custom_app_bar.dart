import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 0,
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Gilroy',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      leading: Container(
        margin: const EdgeInsets.only(
            left: 20, right: 4, top: 10, bottom: 10), // Adjust left margin
        decoration: const BoxDecoration(
          color: Color(0xff674FF7),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xff674FF7),
              blurRadius: 7,
              spreadRadius: 2,
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: 14,
          ),
          onPressed: onBackPressed ?? () => Navigator.pop(context),
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Default AppBar height
}
