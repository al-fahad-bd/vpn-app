import 'package:flutter/material.dart';

import 'social_button_widget.dart';

class SocialLoginButtons extends StatelessWidget {
  final List<Map<String, dynamic>> buttons;

  const SocialLoginButtons({
    super.key,
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buttons.map((button) {
        return Column(
          children: [
            SocialButtonWidget(
              text: button['text'],
              iconPath: button['iconPath'],
              onPressed: button['onPressed'],
            ),
            const SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }
}
