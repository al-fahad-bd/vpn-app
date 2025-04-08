import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/screens/otp_verification_screen.dart';
import 'package:vpn_app/widgets/custom_app_bar.dart';
import 'package:vpn_app/widgets/custom_elevated_button.dart';
import 'package:vpn_app/widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Forget Password',
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
              "Forget Password?",
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Enter your email to reset your password. We will send the code to the email so you can reset password",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 45),
            const CustomTextField(
              hint: "Email Address",
              iconPath: "assets/images/email.svg",
            ),
            const SizedBox(height: 45),
            CustomElevatedButton(
              text: 'Send Code',
              onPressed: () {
                Get.to(
                  () => const OTPVerificationScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
