// import 'package:get/get.dart';
// import 'package:vpn_app/api_vpn_gate/api_vpn_gate.dart';
// import 'package:vpn_app/app_preferences/app_preferences.dart';
// import 'package:vpn_app/models/vpn_info.dart';

// class ControllerVpnLocation extends GetxController {
//   List<VpnInfo> vpnFreeServersAvailableList = AppPreferences.vpnList;

//   final RxBool isLoadingNewLocations = false.obs;

//   Future<void> retrieveVpnInformation() async {
//     isLoadingNewLocations.value = true;
//     vpnFreeServersAvailableList.clear();
//     vpnFreeServersAvailableList =
//         await ApiVpnGate.retrieveAllAvailableFreeVpnServers();
//     isLoadingNewLocations.value = false;
//   }
// }

// import 'package:get/get.dart';
// import 'package:vpn_app/api_vpn_gate/api_vpn_gate.dart';
// import 'package:vpn_app/app_preferences/app_preferences.dart';
// import 'package:vpn_app/models/vpn_info.dart';

// class ControllerVpnLocation extends GetxController {
//   List<VpnInfo> vpnFreeServersAvailableList = [];

//   final RxBool isLoadingNewLocations = false.obs;

//   Future<void> retrieveVpnInformation() async {
//     isLoadingNewLocations.value = true;
//     vpnFreeServersAvailableList.clear();

//     // Get all VPN servers
//     List<VpnInfo> allVpnServers =
//         await ApiVpnGate.retrieveAllAvailableFreeVpnServers();

//     // Create a map to store the best server for each country
//     Map<String, VpnInfo> bestVpnServersPerCountry = {};

//     for (VpnInfo vpnInfo in allVpnServers) {
//       if (bestVpnServersPerCountry.containsKey(vpnInfo.countryLongName)) {
//         // If the current server is faster, replace the existing one
//         if (vpnInfo.speed >
//             bestVpnServersPerCountry[vpnInfo.countryLongName]!.speed) {
//           bestVpnServersPerCountry[vpnInfo.countryLongName] = vpnInfo;
//         }
//       } else {
//         // If this is the first server for the country, add it to the map
//         bestVpnServersPerCountry[vpnInfo.countryLongName] = vpnInfo;
//       }
//     }

//     // Convert the map values back to a list
//     vpnFreeServersAvailableList = bestVpnServersPerCountry.values.toList();

//     isLoadingNewLocations.value = false;
//   }
// }

import 'package:get/get.dart';
import 'package:vpn_app/api_vpn_gate/api_vpn_gate.dart';
import 'package:vpn_app/models/vpn_info.dart';

class ControllerVpnLocation extends GetxController {
  List<VpnInfo> vpnFreeServersAvailableList = [];

  final RxBool isLoadingNewLocations = false.obs;

  Future<void> retrieveVpnInformation() async {
    isLoadingNewLocations.value = true;
    vpnFreeServersAvailableList.clear();

    // Fetch all VPN servers from the API
    List<VpnInfo> allVpnServers =
        await ApiVpnGate.retrieveAllAvailableFreeVpnServers();

    // Create a map to store the best server for each country
    Map<String, VpnInfo> bestVpnServersPerCountry = {};

    // Loop through all VPN servers and filter out the fastest ones for each country
    for (VpnInfo vpnInfo in allVpnServers) {
      if (bestVpnServersPerCountry.containsKey(vpnInfo.countryLongName)) {
        // Compare the speed, and replace the existing server if the new one is faster
        if (vpnInfo.speed >
            bestVpnServersPerCountry[vpnInfo.countryLongName]!.speed) {
          bestVpnServersPerCountry[vpnInfo.countryLongName] = vpnInfo;
        }
      } else {
        // If no VPN is saved for the country, add the current one
        bestVpnServersPerCountry[vpnInfo.countryLongName] = vpnInfo;
      }
    }

    // Convert the map values back to a list and assign it to the list of VPN servers to display
    vpnFreeServersAvailableList = bestVpnServersPerCountry.values.toList();

    isLoadingNewLocations.value = false;
  }
}
