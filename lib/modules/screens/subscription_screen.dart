import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/modules/screens/edit_profile_screen.dart';
import 'package:vpn_app/core/widgets/custom_app_bar.dart';
import 'package:vpn_app/core/widgets/custom_elevated_button.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  SubscriptionScreenState createState() => SubscriptionScreenState();
}

class SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedIndex = 1; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Subscriptions',
        onBackPressed: () {
          Get.back();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Get access to all\nlocation and features",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Gilroy',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              "Subscribe our premium membership to\naccess all premium locations",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 30),
            buildSubscriptionOption(
                0, "1 Month", "\$9.99", "Total Price \$9.99"),
            buildSubscriptionOption(
                1, "6 Month", "\$6.99", "Total Price \$36.99"),
            buildSubscriptionOption(
                2, "1 Year", "\$7.99", "Total Price \$88.99"),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildFeatureItem("Unlock over 300+ locations"),
                buildFeatureItem("Unlock over 250+ premium servers"),
                buildFeatureItem("Get stronger connection on all locations"),
              ],
            ),
            const SizedBox(height: 64),
            CustomElevatedButton(
              text: 'Start Subscriptions',
              onPressed: () {
                Get.to(() => const EditProfileScreen());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubscriptionOption(
      int index, String title, String price, String subtext) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 20,
        ),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xff674FF7) : Colors.grey.shade700,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 5),
                Text(
                  subtext,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "/per month",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: Color(0xff674FF7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_rounded,
              color: Colors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: 'Gilroy',
            ),
          ),
        ],
      ),
    );
  }
}
