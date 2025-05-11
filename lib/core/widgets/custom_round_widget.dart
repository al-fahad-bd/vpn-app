import 'package:flutter/material.dart';
import 'package:vpn_app/main.dart';

class CustomRoundWidget extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final Widget roundWidgetIcon;
  const CustomRoundWidget({
    super.key,
    required this.titleText,
    required this.subTitleText,
    required this.roundWidgetIcon,
  });

  @override
  Widget build(BuildContext context) {
    sizeOfScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeOfScreen.width * 0.46,
      child: Column(
        children: [
          roundWidgetIcon,
          const SizedBox(
            height: 7,
          ),
          Text(
            titleText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            subTitleText,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
