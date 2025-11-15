import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app_preferences/app_preferences.dart';
import 'package:vpn_app/data/models/vpn_configuration.dart';
import 'package:vpn_app/data/models/vpn_info.dart';
import 'package:vpn_app/core/services/vpn_engine.dart';

class ControllerHome extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;

  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;

  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationData.isEmpty) {
      debugPrint("VpnInfo: ${vpnInfo.value}");
      debugPrint(
          "Base64 Config Data: ${vpnInfo.value.base64OpenVPNConfigurationData}");
      debugPrint("No vpn data found");
      Get.snackbar(
          "Country / Location", "Please select country / location first");

      return;
    }

    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn = const Base64Decoder()
          .convert(vpnInfo.value.base64OpenVPNConfigurationData);
      final configuration = const Utf8Decoder().convert(dataConfigVpn);
      final vpnConfiguration = VpnConfiguration(
        username: "vpn",
        password: "vpn",
        countryName: vpnInfo.value.countryLongName,
        config: configuration,
      );
      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;

      case VpnEngine.vpnConnectedNow:
        return Colors.green;

      default:
        return Colors.blueAccent;
    }
  }

  String get getRoundVpnButtonText {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return "Tap to Connect";

      case VpnEngine.vpnConnectedNow:
        return "Disconnecte";

      default:
        return "Connecting...";
    }
  }
}
