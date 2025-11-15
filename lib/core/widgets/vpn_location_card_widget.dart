import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app_preferences/app_preferences.dart';
import 'package:vpn_app/modules/controllers/controller_home.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/data/models/vpn_info.dart';
import 'package:vpn_app/core/services/vpn_engine.dart';

class VpnLocationCardWidget extends StatelessWidget {
  final VpnInfo vpnInfo;
  const VpnLocationCardWidget({
    super.key,
    required this.vpnInfo,
  });

  String formatSpeedBytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return "0 B";
    }
    const suffixesTitle = [
      "Bps",
      "Kbps",
      "Mbps",
      "Gbps",
      "Tbps",
    ];
    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();

    return "${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimals)} ${suffixesTitle[speedTitleIndex]}";
  }

  @override
  Widget build(BuildContext context) {
    sizeOfScreen = MediaQuery.of(context).size;
    final homeController = Get.find<ControllerHome>();
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
        vertical: sizeOfScreen.height * 0.01,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          debugPrint(
              "Selected VPN Info: ${vpnInfo.base64OpenVPNConfigurationData}");
          homeController.vpnInfo.value = vpnInfo;
          AppPreferences.vpnInfoObj = vpnInfo;
          Get.back();

          if (homeController.vpnConnectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();
            Future.delayed(
                const Duration(
                  seconds: 3,
                ),
                () => homeController.connectToVpnNow());
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          //country flag
          leading: Container(
            padding: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              "assets/countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png",
              height: 40,
              width: sizeOfScreen.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),

          //country name
          title: Text(vpnInfo.countryLongName),

          //vpn speed
          subtitle: Row(
            children: [
              const Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),

          //number of sessions
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionNum.toString(),
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).lighTextColor,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              const Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
