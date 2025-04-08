import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/widgets/custom_app_bar.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Service',
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
            SectionTitle("Our Service"),
            ServiceDescription(
                "Create moments of impact for your users when they’re on the app and ensure they continue to remain engaged."),
            ServiceFeature("AXP Scenes",
                "Inform and engage users with carousel-like images showcasing the value of the app right from the onboarding stage"),
            ServiceFeature("Message Center",
                "Quickly and easily send interactive messages inside the app"),
            ServiceFeature("AXP Experiments",
                "Test the relevancy of your messages so only the most engaging messages go out to your wider audience"),
            ServiceFeature("In-App Messages",
                "Make the most of every moment you’ve got with customers while they’re actively using your app"),
            SizedBox(height: 20),
            SectionTitle("Next-level Personalization"),
            ServiceDescription(
                "Use first and zero party data to understand each user and deliver better, more relevant experiences that create memorable moments"),
            ServiceFeature("AXP Scenes",
                "Inform and engage users with carousel-like images showcasing the value of the app right from the onboarding stage"),
            ServiceFeature("Message Center",
                "Quickly and easily send interactive messages inside the app"),
            ServiceFeature("AXP Experiments",
                "Test the relevancy of your messages so only the most engaging messages go out to your wider audience"),
            ServiceFeature("In-App Messages",
                "Make the most of every moment you’ve got with customers while they’re actively using your app"),
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

class ServiceFeature extends StatelessWidget {
  final String title;
  final String description;
  const ServiceFeature(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Color(0xff8F8996),
            fontFamily: 'Gilroy',
            fontSize: 12,
          ),
          children: [
            TextSpan(
              text: "$title – ",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: description),
          ],
        ),
      ),
    );
  }
}
