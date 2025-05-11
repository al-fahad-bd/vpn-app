import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Reactive variables
  var isDataMode = true.obs;
  var isNotifications = false.obs;
  var isDarkMode = true.obs;

  // Toggle methods
  void toggleDataMode(bool value) => isDataMode.value = value;
  void toggleNotifications(bool value) => isNotifications.value = value;
  void toggleDarkMode(bool value) => isDarkMode.value = value;
}