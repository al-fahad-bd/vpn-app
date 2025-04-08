import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/screens/auth_screen/auth_screen.dart';
import 'package:vpn_app/screens/edit_profile_screen.dart';
import 'package:vpn_app/screens/service_screen.dart';
import 'package:vpn_app/screens/settings_screen.dart';
import 'package:vpn_app/screens/subscription_screen.dart';
import 'package:vpn_app/screens/terms_n_conditions_screen.dart';

import 'widgets/menu_items.dart';

class FullScreenMenu extends StatelessWidget {
  const FullScreenMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.04,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MenuItems(
                    title: "Profile",
                    onTap: () {
                      Get.to(() => const EditProfileScreen());
                    },
                  ),
                  MenuItems(
                    title: "Service",
                    onTap: () {
                      Get.to(() => const ServiceScreen());
                    },
                  ),
                  MenuItems(
                    title: "Go Premium",
                    onTap: () {
                      Get.to(() => const SubscriptionScreen());
                    },
                  ),
                  MenuItems(
                    title: "Settings",
                    onTap: () {
                      Get.to(() => const SettingsScreen());
                    },
                  ),
                  MenuItems(
                    title: "Terms & Conditions",
                    onTap: () {
                      Get.to(() => const TermsAndConditionsScreen());
                    },
                  ),
                  MenuItems(
                    title: "Log Out",
                    color: Colors.red,
                    onTap: () {
                      Get.to(const AuthScreen());
                    },
                  ),
                  // _menuItem("Profile"),
                  // _menuItem("Service"),
                  // _menuItem("Go Premium"),
                  // _menuItem("Settings"),
                  // _menuItem("Terms & Conditions"),
                  // const SizedBox(height: 20),
                  // _menuItem("Log Out", color: Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _menuItem(String title, {Color color = Colors.white}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
  //     child: Text(
  //       title,
  //       style: TextStyle(
  //         color: color,
  //         fontSize: 22,
  //         fontFamily: 'Gilroy',
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }
}
