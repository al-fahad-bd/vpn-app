import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app_preferences/app_preferences.dart';
import 'package:vpn_app/controllers/controller_home.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/models/vpn_status.dart';
import 'package:vpn_app/screens/available_vpn_servers_screen.dart';
import 'package:vpn_app/vpn_engine/vpn_engine.dart';
import 'package:vpn_app/widgets/custom_round_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.put(ControllerHome());

  locationSelectionBottomNavigation(BuildContext context) {
    debugPrint("bottom section clicked");
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {
            Get.to(() => AvailableVpnServersScreen());
          },
          child: Container(
            color: Colors.redAccent,
            padding:
                EdgeInsets.symmetric(horizontal: sizeOfScreen.width * .041),
            height: 62,
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Select Country / Location",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vpnRoundButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(100),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: homeController.getRoundButtonColor.withAlpha((0.1 * 255).toInt()),
              ),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: homeController.getRoundButtonColor.withAlpha((0.3 * 255).toInt()),
                ),
                child: Container(
                  height: sizeOfScreen.height * .14,
                  width: sizeOfScreen.width * .14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: homeController.getRoundButtonColor,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        homeController.getRoundVpnButtonText,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    VpnEngine.snapshotVpnStage().listen((event) {
      homeController.vpnConnectionState.value = event;
    });
    sizeOfScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text("Freedom Tunnel"),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.perm_device_info,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.changeThemeMode(
                AppPreferences.isModeDark ? ThemeMode.light : ThemeMode.dark,
              );

              AppPreferences.isModeDark = !AppPreferences.isModeDark;
            },
            icon: const Icon(
              Icons.brightness_2_outlined,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // 2 round widget
          // locations + ping
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "Location"
                          : homeController.vpnInfo.value.countryLongName,
                  subTitleText: "FREE",
                  roundWidgetIcon: CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.redAccent,
                    backgroundImage: homeController
                            .vpnInfo.value.countryLongName.isEmpty
                        ? null
                        : AssetImage(
                            "assets/countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png"),
                    child: homeController.vpnInfo.value.countryLongName.isEmpty
                        ? const Icon(
                            Icons.flag_circle,
                            size: 30,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                CustomRoundWidget(
                  titleText:
                      homeController.vpnInfo.value.countryLongName.isEmpty
                          ? "60 ms"
                          : "${homeController.vpnInfo.value.ping} ms",
                  subTitleText: "PING",
                  roundWidgetIcon: const CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.black54,
                    child: Icon(
                      Icons.graphic_eq,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // button for vpn
          vpnRoundButton(),

          // 2 round widget
          // download + ping
          StreamBuilder<VpnStatus?>(
            initialData: VpnStatus(),
            stream: VpnEngine.snapshotVpnStatus(),
            builder: (context, dataSnapshot) {
              debugPrint(
                  'Download: ${dataSnapshot.data!.byteIn}, Upload: ${dataSnapshot.data!.byteOut}');
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRoundWidget(
                    titleText: dataSnapshot.data!.byteIn ?? '0 kbps',
                    subTitleText: "DOWNLOAD",
                    roundWidgetIcon: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.arrow_circle_down,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  CustomRoundWidget(
                    titleText: dataSnapshot.data?.byteOut ?? '0 kbps',
                    subTitleText: "UPLOAD",
                    roundWidgetIcon: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.blueAccent,
                      child: Icon(
                        Icons.arrow_circle_up,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNavigation(context),
    );
  }
}
