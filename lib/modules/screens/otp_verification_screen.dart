import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:vpn_app/modules/screens/reset_password_screen.dart';
import 'package:vpn_app/core/widgets/custom_app_bar.dart';
import 'package:vpn_app/core/widgets/custom_elevated_button.dart';

class OTPVerificationScreen extends StatelessWidget {
  const OTPVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Verification',
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
              "Verify Yourself",
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "We sent email on ui***@gmail.com make sure you enter 5 digit code correctly",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 12,
                color: Colors.white54,
              ),
            ),
            const SizedBox(height: 45),
            Pinput(
              length: 5,
              defaultPinTheme: PinTheme(
                width: 60,
                height: 60,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              focusedPinTheme: PinTheme(
                width: 60,
                height: 60,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Gilroy',
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xff674FF7),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 45),
            CustomElevatedButton(
              text: 'Verify',
              onPressed: () {
                Get.to(
                  () => const ResetPasswordScreen(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
