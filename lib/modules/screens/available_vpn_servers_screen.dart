import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/modules/controllers/controller_vpn_location.dart';
import 'package:vpn_app/core/widgets/vpn_location_card_widget.dart';

class AvailableVpnServersScreen extends StatelessWidget {
  AvailableVpnServersScreen({super.key});

  final vpnLocationController = Get.put(ControllerVpnLocation());

  @override
  Widget build(BuildContext context) {
    // Trigger the VPN information retrieval if the list is empty
    if (vpnLocationController.vpnFreeServersAvailableList.isEmpty) {
      vpnLocationController.retrieveVpnInformation();
    }

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text(
                "Vpn Locations (${vpnLocationController.vpnFreeServersAvailableList.length})"),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(
              onPressed: () {
                vpnLocationController.retrieveVpnInformation();
              },
              backgroundColor: Colors.redAccent,
              child: const Icon(
                CupertinoIcons.refresh_circled,
                size: 40,
              ),
            ),
          ),
          body: vpnLocationController.isLoadingNewLocations.value
              ? loadingUIWidget()
              : vpnLocationController.vpnFreeServersAvailableList.isEmpty
                  ? noVpnServerFoundUIWidget()
                  : vpnAvailableServersData(),
        ));
  }

  Widget loadingUIWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
          ),
          SizedBox(height: 8),
          Text(
            "Gathering Free VPN Locations....",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget noVpnServerFoundUIWidget() {
    return const Center(
      child: Text(
        "No VPNs Found, Try Again.",
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget vpnAvailableServersData() {
    return ListView.builder(
      itemCount: vpnLocationController.vpnFreeServersAvailableList.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(3),
      itemBuilder: (context, index) {
        return VpnLocationCardWidget(
          vpnInfo: vpnLocationController.vpnFreeServersAvailableList[index],
        );
      },
    );
  }
}
