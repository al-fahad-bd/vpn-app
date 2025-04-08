import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/widgets/custom_app_bar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Terms & Conditions',
        onBackPressed: () {
          Get.back();
        },
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            SectionTitle("Our Terms & Conditions"),
            ServiceDescription(
                "Create moments of impact for your users when they’re on the app and ensure they continue to remain engaged. AXP Scenes – Inform and engage users with carousel-like images showcasing the value of the app right from the onboarding stage. Message Center – Quickly and easily send interactive messages inside the app. AXP Experiments – Test the relevancy of your messages so only the most engaging messages go out to your wider audience. In-App Messages – Make the most of every moment you’ve got with customers while they’re actively using your app. Use first and zero party data to understand each user and deliver better, more relevant experiences that create memorable moments. AXP Experiments – Test the relevancy of your messages so only the most engaging messages go out to your wider audience"),
            SizedBox(height: 20),
            ServiceDescription(
                "Create moments of impact for your users when they’re on the app and ensure they continue to remain engaged. AXP Scenes – Inform and engage users with carousel-like images showcasing the value of the app right from the onboarding stage. Message Center – Quickly and easily send interactive messages inside the app. AXP Experiments – Test the relevancy of your messages so only the most engaging messages go out to your wider audience. In-App Messages – Make the most of every moment you’ve got with customers while they’re actively using your app. Use first and zero party data to understand each user and deliver better, more relevant experiences that create memorable moments. AXP Experiments – Test the relevancy of your messages so only the most engaging messages go out to your wider audience"),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ServiceDescription extends StatelessWidget {
  final String description;
  const ServiceDescription(this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        description,
        style: const TextStyle(
          color: Color(0xff8F8996),
          fontSize: 12,
          fontFamily: 'Gilroy',
        ),
      ),
    );
  }
}
