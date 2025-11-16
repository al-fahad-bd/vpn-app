import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vpn_app/modules/menu/menu_screen.dart';
import 'package:vpn_app/modules/speed%20test/view/speed_test_screen.dart';
import 'package:vpn_app/modules/screens/subscription_screen.dart';
import 'package:vpn_app/core/widgets/country_slider.dart';

class VPNHomeScreen extends StatefulWidget {
  const VPNHomeScreen({super.key});

  @override
  State<VPNHomeScreen> createState() => _VPNHomeScreenState();
}

class _VPNHomeScreenState extends State<VPNHomeScreen> {
  int selectedIndex = 2;

  final List<String> countryFlags = [
    'assets/countryFlags/ca.png',
    'assets/countryFlags/sa.png',
    'assets/countryFlags/bd.png',
    'assets/countryFlags/us.png',
    'assets/countryFlags/af.png',
    'assets/countryFlags/cn.png',
  ];

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      // drawer: const MenuScreen(),
      backgroundColor: Colors.grey[900],
      // backgroundColor: const Color(0xff3a3b48),

      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/shapes_grey.svg',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              // colorFilter: ColorFilter.mode(Colors.white, BlendMode.softLight),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/images/map.svg',
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.4,
              fit: BoxFit.cover,
            ),
          ),

          //App Bar
          Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            height: 55,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      barrierLabel: "Menu",
                      transitionDuration: const Duration(milliseconds: 300),
                      pageBuilder: (_, __, ___) => const FullScreenMenu(),
                      transitionBuilder: (_, anim, __, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1, 0),
                            end: Offset.zero,
                          ).animate(anim),
                          child: child,
                        );
                      },
                    );
                  }, // Open the menu
                  child: SvgPicture.asset(
                    'assets/images/menu.svg',
                    // width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.036,
                    fit: BoxFit.cover,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const SubscriptionScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    backgroundColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/images/crown.svg',
                        height: MediaQuery.of(context).size.height * 0.02,
                        width: MediaQuery.of(context).size.width * 0.02,
                        fit: BoxFit.cover,
                        colorFilter: const ColorFilter.mode(
                          Colors.yellow,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Premium",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Gilroy',
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ), // Adjust for app bar spacing
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CountrySlider(
                countryFlags: countryFlags,
                onChanged: (index) {
                  setState(
                    () {
                      selectedIndex = index;
                    },
                  );
                },
              ),
              const Text(
                "Not Connected",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Gilroy',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => Get.to(() => const SpeedTestScreen()),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff3b3a48),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xff4f4e5b),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xff4f4e5b),
                            child: SvgPicture.asset(
                              'assets/images/world.svg',
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height * 0.04,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Icon(Icons.wordpress_outlined, color: Colors.white),
                          const SizedBox(width: 10),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Faster Server",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gilroy',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "212.369.56.87",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'Gilroy',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xff4f4e5b),
                            width: 1,
                          ),
                        ),
                        // backgroundColor: Colors.transparent,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(80),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: Color(0xff674FF7),
                        blurRadius: 80,
                        spreadRadius: 20,
                      ),
                    ],
                    border: Border.all(
                      color: const Color(0xff674FF7),
                      width: 7,
                    ),
                    // color: const Color(0xff3b3a48),
                    color: Colors.black54,
                  ),
                  child: SvgPicture.asset(
                    'assets/images/power_icon.svg',
                    colorFilter: const ColorFilter.mode(
                      Color(0xff674FF7),
                      BlendMode.srcIn,
                    ),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ],
      ),
    );
  }
}
