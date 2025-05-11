import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/modules/screens/error_screen.dart';
import 'package:vpn_app/modules/screens/forget_password_screen.dart';
import 'package:vpn_app/modules/screens/home_screen_not_connected.dart';
import 'package:vpn_app/core/widgets/custom_elevated_button.dart';
import 'package:vpn_app/core/widgets/custom_text_field.dart';
import 'package:vpn_app/core/widgets/underline_painter.dart';

import 'widgets/social_login_buttons.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: DefaultTabController(
            length: 2, // Two tabs (Login & Sign Up)
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    "Welcome Back!",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gilroy',
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "You will get 7 days free trial on creating new account.\nMake sure you use correct informations",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontFamily: 'Gilroy',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 48),
                  // TabBar for switching between Login & Sign Up
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: TabBar(
                      labelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Gilroy',
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Gilroy',
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white54,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: Color(0xff674FF7),
                          width: 1,
                        ),
                      ),
                      indicatorPadding: EdgeInsets.zero,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(text: "Log In"),
                        Tab(text: "Sign Up"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // TabBarView for Login & Sign Up Forms
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: TabBarView(
                      children: [
                        _buildLoginForm(),
                        _buildSignUpForm(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      children: [
        SocialLoginButtons(
          buttons: [
            {
              'text': "Continue with Google",
              'iconPath': "assets/images/google.svg",
              'onPressed': () {
                debugPrint("Google button pressed");
              },
            },
            {
              'text': "Continue with Apple",
              'iconPath': "assets/images/apple.svg",
              'onPressed': () {
                debugPrint("Apple button pressed");
              },
            },
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.white38, // Match the UI design
                thickness: 1,
                endIndent: 10, // Spacing from text
              ),
            ),
            Text(
              "Or better yet...",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            Expanded(
              child: Divider(
                color: Colors.white38,
                thickness: 1,
                indent: 10, // Spacing from text
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        const CustomTextField(
          hint: "Email Address",
          iconPath: "assets/images/email.svg",
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          hint: "Password",
          iconPath: "assets/images/lock.svg",
          isPassword: true,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              Get.to(() => const ForgetPasswordScreen());
            },
            child: Stack(
              children: [
                const Text(
                  "Forget Password?",
                  style: TextStyle(
                    fontFamily: 'Gilroy',
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: -1, // Adjust this value to move the underline lower
                  child: CustomPaint(
                    size: const Size(
                      double.infinity,
                      2,
                    ),
                    painter: UnderlinePainter(),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomElevatedButton(
          text: 'Log In',
          onPressed: () {
            Get.to(
              () => const VPNHomeScreen(),
            );
          },
          buttonWidth: MediaQuery.of(context).size.width * 0.9,
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Column(
      children: [
        SocialLoginButtons(
          buttons: [
            {
              'text': "Continue with Google",
              'iconPath': "assets/images/google.svg",
              'onPressed': () {
                debugPrint("Google button pressed");
              },
            },
            {
              'text': "Continue with Apple",
              'iconPath': "assets/images/apple.svg",
              'onPressed': () {
                debugPrint("Apple button pressed");
              },
            },
          ],
        ),
        // _buildSocialLoginButtons(),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(
              child: Divider(
                color: Colors.white38, // Match the UI design
                thickness: 1,
                endIndent: 10, // Spacing from text
              ),
            ),
            Text(
              "Or better yet...",
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
            Expanded(
              child: Divider(
                color: Colors.white38,
                thickness: 1,
                indent: 10, // Spacing from text
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const CustomTextField(
          hint: "Email Address",
          iconPath: "assets/images/email.svg",
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          hint: "Password",
          iconPath: "assets/images/lock.svg",
          isPassword: true,
        ),
        const SizedBox(height: 16),
        const CustomTextField(
          hint: "Confirm Password",
          iconPath: "assets/images/lock.svg",
          isPassword: true,
        ),
        const SizedBox(height: 32),
        CustomElevatedButton(
          text: 'Sign Up',
          onPressed: () {
            Get.to(() => const ErrorScreen());
          },
        ),
      ],
    );
  }

  // Widget _buildSocialLoginButtons() {
  //   return Column(
  //     children: [
  //       SocialButtonWidget(
  //         text: "Continue with Google",
  //         iconPath: "assets/images/google.svg",
  //         onPressed: () {
  //           debugPrint("Google button pressed");
  //           // Add your logic here
  //         },
  //       ),
  //       const SizedBox(height: 12),
  //       SocialButtonWidget(
  //         text: "Continue with Apple",
  //         iconPath: "assets/images/apple.svg",
  //         onPressed: () {
  //           debugPrint("Apple button pressed");
  //           // Add your logic here
  //         },
  //       ),
  //       // _buildSocialButton(
  //       //   "Sign up with Google",
  //       //   "assets/images/google.svg",
  //       // ),
  //       // const SizedBox(height: 12),
  //       // _buildSocialButton(
  //       //   "Sign up with Apple",
  //       //   "assets/images/apple.svg",
  //       // ),
  //     ],
  //   );
  // }

  // Widget _buildSocialButton(String text, String iconPath) {
  //   return ElevatedButton.icon(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: Colors.transparent,
  //       minimumSize: const Size(
  //         double.infinity,
  //         65,
  //       ),
  //       shape: RoundedRectangleBorder(
  //         side: const BorderSide(
  //           color: Colors.white,
  //           width: 0.5,
  //         ),
  //         borderRadius: BorderRadius.circular(40),
  //       ),
  //     ),
  //     icon: SvgPicture.asset(
  //       iconPath, // Path to your SVG file
  //       width: 18, // Adjust size as needed
  //       height: 18,
  //     ),
  //     label: Text(
  //       text,
  //       style: const TextStyle(
  //         color: Colors.white,
  //         fontFamily: 'Gilroy',
  //         fontSize: 16,
  //       ),
  //     ),
  //     onPressed: () {},
  //   );
  // }
}
