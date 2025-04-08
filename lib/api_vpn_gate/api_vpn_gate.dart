// import 'dart:convert';

// import 'package:csv/csv.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:vpn_app/app_preferences/app_preferences.dart';
// import 'package:vpn_app/models/ip_info.dart';
// import 'package:vpn_app/models/vpn_info.dart';
// import 'package:http/http.dart' as http;

// class ApiVpnGate {
//   static Future<List<VpnInfo>> retrieveAllAvailableFreeVpnServers() async {
//     final List<VpnInfo> vpnServersList = [];

//     try {
//       final responseFromApi = await http.get(
//         Uri.parse(
//           "http://www.vpngate.net/api/iphone",
//         ),
//       );

//       if (responseFromApi.statusCode == 200) {
//         debugPrint("{$responseFromApi}");
//         final commaSeparatedValueString =
//             responseFromApi.body.split("#")[1].replaceAll("*", "");
//         List<List<dynamic>> listData =
//             const CsvToListConverter().convert(commaSeparatedValueString);

//         final header = listData[0];
//         debugPrint("Header row: $header");

//         for (int counter = 1; counter < listData.length - 1; counter++) {
//           Map<String, dynamic> jsonData = {};
//           for (int innerCounter = 0;
//               innerCounter < header.length;
//               innerCounter++) {
//             jsonData.addAll({
//               header[innerCounter].toString(): listData[counter][innerCounter]
//             });
//           }
//           vpnServersList.add(VpnInfo.fromJson(jsonData));
//           // print("Added VPN server: ${jsonData['HostName']}");
//         }
//       } else {
//         debugPrint(
//             "API call failed with status code: ${responseFromApi.statusCode}");
//       }
//     } catch (errorMsg) {
//       // print("Error occurred: $errorMsg");
//       Get.snackbar(
//         "Error Occurred",
//         errorMsg.toString(),
//         colorText: Colors.white,
//         backgroundColor: Colors.redAccent.withOpacity(.8),
//       );
//     }

//     vpnServersList.shuffle();

//     if (vpnServersList.isNotEmpty) AppPreferences.vpnList = vpnServersList;

//     debugPrint("Total VPN servers retrieved: ${vpnServersList.length}");
//     return vpnServersList;
//   }

//   static Future<void> retrieveIPDetails(
//       {required Rx<IpInfo> ipInformation}) async {
//     try {
//       final responseFromApi =
//           await http.get(Uri.parse("http://ip-api.com/json/"));
//       final dataFromApi = jsonDecode(responseFromApi.body);

//       ipInformation.value = IpInfo.fromJson(dataFromApi);
//     } catch (erroMsg) {
//       Get.snackbar(
//         "Error Occurred",
//         erroMsg.toString(),
//         colorText: Colors.white,
//         backgroundColor: Colors.redAccent.withOpacity(.8),
//       );
//     }
//   }
// }

import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/app_preferences/app_preferences.dart';
import 'package:vpn_app/models/ip_info.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:http/http.dart' as http;

class ApiVpnGate {
  // Retrieve all VPN servers and filter based on the best speed per country
  static Future<List<VpnInfo>> retrieveAllAvailableFreeVpnServers() async {
    final List<VpnInfo> vpnServersList = [];

    try {
      final responseFromApi = await http.get(
        Uri.parse("http://www.vpngate.net/api/iphone"),
      );

      if (responseFromApi.statusCode == 200) {
        // debugPrint("Response: ${responseFromApi.body}");

        // Split and clean the CSV response
        final commaSeparatedValueString =
            responseFromApi.body.split("#")[1].replaceAll("*", "");
        List<List<dynamic>> listData =
            const CsvToListConverter().convert(commaSeparatedValueString);

        final header = listData[0];
        // debugPrint("Header row: $header");

        // Iterate through the list data, converting each row to a VPNInfo object
        for (int counter = 1; counter < listData.length - 1; counter++) {
          Map<String, dynamic> jsonData = {};
          for (int innerCounter = 0;
              innerCounter < header.length;
              innerCounter++) {
            jsonData.addAll({
              header[innerCounter].toString(): listData[counter][innerCounter]
            });
          }
          vpnServersList.add(VpnInfo.fromJson(jsonData));
        }

        // Now filter the list to retain only the best VPN per country
        final Map<String, VpnInfo> bestVpnServersPerCountry = {};

        for (VpnInfo vpnInfo in vpnServersList) {
          if (bestVpnServersPerCountry.containsKey(vpnInfo.countryLongName)) {
            // If we already have a server for the country, check if the current one is faster
            if (vpnInfo.speed >
                bestVpnServersPerCountry[vpnInfo.countryLongName]!.speed) {
              bestVpnServersPerCountry[vpnInfo.countryLongName] = vpnInfo;
            }
          } else {
            // If this is the first server for the country, add it to the map
            bestVpnServersPerCountry[vpnInfo.countryLongName] = vpnInfo;
          }
        }

        // Convert the map values (best servers) back to a list
        final filteredVpnServersList = bestVpnServersPerCountry.values.toList();

        // debugPrint(
        //     "Filtered VPN servers by country, total: ${filteredVpnServersList.length}");

        if (filteredVpnServersList.isNotEmpty) {
          AppPreferences.vpnList = filteredVpnServersList;
        }

        return filteredVpnServersList;
      } else {
        // debugPrint(
        //     "API call failed with status code: ${responseFromApi.statusCode}");
        return [];
      }
    } catch (errorMsg) {
      Get.snackbar(
        "Error Occurred",
        errorMsg.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withAlpha((0.8 * 255).toInt()),
      );
      return [];
    }
  }

  static Future<void> retrieveIPDetails(
      {required Rx<IpInfo> ipInformation}) async {
    try {
      final responseFromApi =
          await http.get(Uri.parse("http://ip-api.com/json/"));
      final dataFromApi = jsonDecode(responseFromApi.body);

      ipInformation.value = IpInfo.fromJson(dataFromApi);
    } catch (errorMsg) {
      Get.snackbar(
        "Error Occurred",
        errorMsg.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.redAccent.withAlpha((0.8 * 255).toInt()),
      );
    }
  }
}
