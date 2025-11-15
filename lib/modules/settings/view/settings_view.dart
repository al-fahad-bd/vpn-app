import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/core/widgets/custom_app_bar.dart';
import 'package:vpn_app/modules/settings/controller/settings_controller.dart';

class SettingsView extends StatelessWidget {
  final SettingsController _ctrl = Get.put(SettingsController());

  SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        title: 'Settings',
        onBackPressed: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            _buildSwitchTile(
              'Data Mode',
              'VPN also works on data mode',
              _ctrl.isDataMode,
              _ctrl.toggleDataMode,
            ),
            _buildSwitchTile(
              'Notifications',
              'Receive notifications on your phone',
              _ctrl.isNotifications,
              _ctrl.toggleNotifications,
            ),
            _buildSwitchTile(
              'Dark Mode',
              'Enable dark mode for eye comfort',
              _ctrl.isDarkMode,
              _ctrl.toggleDarkMode,
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('App Information'),
            _buildInfoTile(
              'App Security',
              'Enable dark mode to make your eyes comfortable',
            ),
            _buildInfoTile(
              'Privacy Policy',
              'A privacy policy discloses how we gather, use, and manage your data.',
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget: Switch Tile
  Widget _buildSwitchTile(
    String title,
    String subtitle,
    RxBool value,
    Function(bool) onChanged,
  ) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Switch(
              value: value.value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: const Color(0xff34c759),
              inactiveTrackColor: const Color(0xff131314),
              inactiveThumbColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget: Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Reusable Widget: Info Tile
  Widget _buildInfoTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
