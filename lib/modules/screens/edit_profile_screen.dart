import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/modules/screens/home_screen_not_connected.dart';
import 'package:vpn_app/core/widgets/custom_app_bar.dart';
import 'package:vpn_app/core/widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Edit Profile',
        onBackPressed: () {
          Get.back();
        },
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => const VPNHomeScreen());
            },
            child: const Text(
              "Save",
              style: TextStyle(
                color: Color(0xff674FF7),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Color(0xff202020),
              radius: 60,
              foregroundImage: AssetImage(
                "assets/images/avatar.png",
              ),
            ),
            SizedBox(height: 40),
            CustomTextField(
              hint: 'Sami Ahmed',
              iconPath: 'assets/images/eyeOn.svg',
            ),
            // _buildTextField(Icons.person, "Sami Ahmed"),
            SizedBox(height: 20),
            CustomTextField(
              hint: 'uihut@gmail.com',
              iconPath: 'assets/images/email.svg',
            ),
            // _buildTextField(Icons.email, "uihut@gmail.com"),
            SizedBox(height: 20),
            CustomTextField(
              hint: 'uihut1234',
              iconPath: 'assets/images/lock.svg',
              isPassword: true,
            ),
            // _buildPasswordField(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subscriptions :",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                  ),
                ),
                Text(
                  "15d 22hr 57min",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Gilroy',
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
