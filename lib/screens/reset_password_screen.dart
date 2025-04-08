import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/screens/subscription_screen.dart';
import 'package:vpn_app/widgets/custom_app_bar.dart';
import 'package:vpn_app/widgets/custom_elevated_button.dart';
import 'package:vpn_app/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Change Password',
        onBackPressed: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text(
              "Reset Password",
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "You can reset your password now. Make sure you remeber it now or you can reset again & again",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 45),
            const CustomTextField(
              hint: "Password",
              iconPath: "assets/images/lock.svg",
              isPassword: true,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hint: "Confirm Password",
              iconPath: "assets/images/lock.svg",
              isPassword: true,
            ),
            const SizedBox(height: 45),
            CustomElevatedButton(
              text: 'Change Now',
              onPressed: () {
                Get.to(
                  () => const SubscriptionScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
