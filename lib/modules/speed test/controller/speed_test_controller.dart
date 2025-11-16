import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_speed_test_plus/flutter_speed_test_plus.dart';

class SpeedTestController extends GetxController {
  final RxDouble downloadSpeed = 0.0.obs;
  final RxDouble uploadSpeed = 0.0.obs;
  final RxDouble currentSpeed = 0.0.obs;
  final RxDouble downloadProgress = 0.0.obs;
  final RxDouble uploadProgress = 0.0.obs;
  final RxBool isTesting = false.obs;
  final RxBool showResults = false.obs;
  final RxString testPhase = ''.obs; // 'download', 'upload', or ''

  final _speedTestPlugin = FlutterInternetSpeedTest();

  Future<void> startSpeedTest() async {
    if (isTesting.value) return;

    // Reset values
    downloadSpeed.value = 0.0;
    uploadSpeed.value = 0.0;
    currentSpeed.value = 0.0;
    downloadProgress.value = 0.0;
    uploadProgress.value = 0.0;
    showResults.value = false;
    isTesting.value = true;
    testPhase.value = 'initializing';

    try {
      await _speedTestPlugin.startTesting(
        onStarted: () {
          debugPrint('Speed test started');
        },
        onDefaultServerSelectionInProgress: () {
          testPhase.value = 'selecting_server';
          debugPrint('Selecting best server...');
        },
        onDefaultServerSelectionDone: (Client? client) {
          debugPrint('Server selected: ${client?.ip ?? "Unknown"}');
          testPhase.value = 'download';
        },
        onDownloadComplete: (TestResult data) {
          downloadSpeed.value = data.transferRate;
          debugPrint('Download complete: ${data.transferRate} ${data.unit.name}');
        },
        onUploadComplete: (TestResult data) {
          uploadSpeed.value = data.transferRate;
          debugPrint('Upload complete: ${data.transferRate} ${data.unit.name}');
        },
        onProgress: (double percent, TestResult data) {
          currentSpeed.value = data.transferRate;
          
          if (data.type == TestType.download) {
            testPhase.value = 'download';
            downloadProgress.value = percent;
            debugPrint('Download progress: $percent% - ${data.transferRate} ${data.unit.name}');
          } else if (data.type == TestType.upload) {
            testPhase.value = 'upload';
            uploadProgress.value = percent;
            debugPrint('Upload progress: $percent% - ${data.transferRate} ${data.unit.name}');
          }
        },
        onCompleted: (TestResult download, TestResult upload) {
          downloadSpeed.value = download.transferRate;
          uploadSpeed.value = upload.transferRate;
          showResults.value = true;
          isTesting.value = false;
          testPhase.value = '';
          
          debugPrint('Test completed!');
          debugPrint('Download: ${download.transferRate} ${download.unit.name}');
          debugPrint('Upload: ${upload.transferRate} ${upload.unit.name}');
          
          Get.snackbar(
            'Test Complete',
            'Download: ${download.transferRate.toStringAsFixed(2)} ${download.unit.name}\n'
            'Upload: ${upload.transferRate.toStringAsFixed(2)} ${upload.unit.name}',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.8),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        },
        onError: (String errorMessage, String speedTestError) {
          debugPrint('Speed test error: $errorMessage - $speedTestError');
          isTesting.value = false;
          testPhase.value = '';
          
          Get.snackbar(
            'Error',
            'Failed to complete speed test: $errorMessage',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        },
        onCancel: () {
          debugPrint('Speed test cancelled');
          isTesting.value = false;
          testPhase.value = '';
        },
        // Optional: You can specify custom test servers
        // downloadTestServer: 'http://your-server.com/test-file.bin',
        // uploadTestServer: 'http://your-server.com/',
        fileSizeInBytes: 10 * 1024 * 1024, // 10 MB
        useFastApi: true, // Uses fast.com API for server selection
      );
    } catch (e) {
      debugPrint('Speed test error: $e');
      isTesting.value = false;
      testPhase.value = '';
      
      Get.snackbar(
        'Error',
        'Failed to start speed test: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> cancelTest() async {
    if (!isTesting.value) return;
    
    try {
      final cancelled = await _speedTestPlugin.cancelTest();
      if (cancelled) {
        debugPrint('Speed test cancelled successfully');
      }
    } catch (e) {
      debugPrint('Error cancelling test: $e');
    }
  }

  // Helper method to get speed in Mbps
  String getDownloadSpeedInMbps() {
    // Assuming the speed is already in Mbps from the plugin
    return downloadSpeed.value.toStringAsFixed(2);
  }

  String getUploadSpeedInMbps() {
    return uploadSpeed.value.toStringAsFixed(2);
  }

  String getCurrentSpeedInMbps() {
    return currentSpeed.value.toStringAsFixed(2);
  }

  @override
  void onClose() {
    // Cancel test if still running
    if (isTesting.value) {
      _speedTestPlugin.cancelTest();
    }
    super.onClose();
  }
}