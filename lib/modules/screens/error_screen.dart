import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5E46DD), // Background color
      body: Stack(
        children: [
          // Upper stars
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/images/stars_1.svg", // First stars image
              fit: BoxFit.cover,
            ),
          ),
          // Lower stars
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/images/stars_2.svg", // Second stars image
              fit: BoxFit.cover,
            ),
          ),
          // Main content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset("assets/images/rocket.svg"),
              const SizedBox(height: 16),
              Center(
                child: SvgPicture.asset("assets/images/404.svg"),
              ),
              const SizedBox(height: 16),
              const Text(
                'An error occurred',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text(
                'Retry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 42),
            ],
          ),
        ],
      ),
    );
  }
}
