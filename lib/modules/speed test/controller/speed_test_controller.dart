import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:vpn_app/modules/speed%20test/controller/ping_helper.dart';

class SpeedTestController extends GetxController {
  final RxDouble downloadSpeed = 0.0.obs;
  final RxDouble uploadSpeed = 0.0.obs;
  final RxDouble currentSpeed = 0.0.obs;
  final RxInt ping = 0.obs;
  final RxInt jitter = 0.obs;
  final RxBool isTesting = false.obs;
  final RxBool showResults = false.obs;
  final RxString testPhase = ''.obs; // 'ping', 'download', 'upload', or ''

  final FlutterInternetSpeedTest speedTest = FlutterInternetSpeedTest();

  double _maxDownloadSpeed = 0.0;
  double _maxUploadSpeed = 0.0;
  List<int> _pingResults = [];

  @override
  void onInit() {
    super.onInit();
    // Enable logging for debugging (optional)
    // speedTest.enableLog();
  }

  Future<void> startSpeedTest() async {
    if (isTesting.value) return;

    // Reset values
    downloadSpeed.value = 0.0;
    uploadSpeed.value = 0.0;
    currentSpeed.value = 0.0;
    ping.value = 0;
    jitter.value = 0;
    showResults.value = false;
    isTesting.value = true;
    testPhase.value = 'ping';
    _maxDownloadSpeed = 0.0;
    _maxUploadSpeed = 0.0;
    _pingResults.clear();

    // First, measure ping
    await _measurePing();

    if (!isTesting.value) return; // Check if cancelled

    // Then start the complete speed test
    await _startSpeedTest();
  }

  Future<void> _measurePing() async {
    testPhase.value = 'ping';

    try {
      // Use the ping helper for accurate measurements
      final result = await PingHelper.measurePing(
        servers: [
          'www.google.com',
          'www.cloudflare.com',
          'www.amazon.com',
        ],
        samples: 5,
      );

      ping.value = result.averagePing;
      jitter.value = result.jitter;

      debugPrint('Ping measurement complete: $result');
    } catch (e) {
      debugPrint('Ping measurement error: $e');
      ping.value = 0;
      jitter.value = 0;
    }
  }

  Future<void> _startSpeedTest() async {
    testPhase.value = 'download';

    try {
      debugPrint('Starting speed test with useFastApi: false');

      await speedTest.startTesting(
        onStarted: () {
          debugPrint('Speed test started - onStarted callback');
          testPhase.value = 'download';
        },
        onCompleted: (TestResult download, TestResult upload) {
          debugPrint('onCompleted callback triggered');
          debugPrint(
              'Download result: ${download.transferRate} ${download.unit}');
          debugPrint('Upload result: ${upload.transferRate} ${upload.unit}');

          // Convert to Mbps
          final downloadMbps =
              _convertToMbps(download.transferRate, download.unit);
          final uploadMbps = _convertToMbps(upload.transferRate, upload.unit);

          // Use max speeds or final speeds, whichever is higher
          downloadSpeed.value = _maxDownloadSpeed > downloadMbps
              ? _maxDownloadSpeed
              : downloadMbps;
          uploadSpeed.value =
              _maxUploadSpeed > uploadMbps ? _maxUploadSpeed : uploadMbps;
          currentSpeed.value = downloadSpeed.value;

          isTesting.value = false;
          showResults.value = true;
          testPhase.value = '';

          debugPrint(
              'Test completed - Download: ${downloadSpeed.value} Mbps, Upload: ${uploadSpeed.value} Mbps');
        },
        onProgress: (double percent, TestResult data) {
          debugPrint(
              'onProgress: ${percent.toStringAsFixed(1)}% - ${data.transferRate} ${data.unit} - Type: ${data.type}');

          // Update current speed based on test type
          final speed = _convertToMbps(data.transferRate, data.unit);
          currentSpeed.value = speed;

          if (data.type == TestType.download) {
            if (testPhase.value != 'download') {
              testPhase.value = 'download';
              debugPrint('Switched to download phase');
            }
            downloadSpeed.value = speed;
            if (speed > _maxDownloadSpeed) {
              _maxDownloadSpeed = speed;
              debugPrint('New max download speed: $_maxDownloadSpeed Mbps');
            }
          } else if (data.type == TestType.upload) {
            if (testPhase.value != 'upload') {
              testPhase.value = 'upload';
              debugPrint('Switched to upload phase');
            }
            uploadSpeed.value = speed;
            if (speed > _maxUploadSpeed) {
              _maxUploadSpeed = speed;
              debugPrint('New max upload speed: $_maxUploadSpeed Mbps');
            }
          }
        },
        onDownloadComplete: (TestResult data) {
          final speed = _convertToMbps(data.transferRate, data.unit);
          downloadSpeed.value =
              _maxDownloadSpeed > 0 ? _maxDownloadSpeed : speed;
          debugPrint(
              'Download phase complete: ${downloadSpeed.value} Mbps (Max: $_maxDownloadSpeed)');
        },
        onUploadComplete: (TestResult data) {
          final speed = _convertToMbps(data.transferRate, data.unit);
          uploadSpeed.value = _maxUploadSpeed > 0 ? _maxUploadSpeed : speed;
          debugPrint(
              'Upload phase complete: ${uploadSpeed.value} Mbps (Max: $_maxUploadSpeed)');
        },
        onError: (String errorMessage, String speedTestError) {
          debugPrint('ERROR - onError callback');
          debugPrint('Error message: $errorMessage');
          debugPrint('Speed test error: $speedTestError');
          _handleTestError(errorMessage);
        },
        onCancel: () {
          debugPrint('Test cancelled - onCancel callback');
          isTesting.value = false;
          testPhase.value = '';
        },
        onDefaultServerSelectionInProgress: () {
          debugPrint('Selecting default server...');
        },
        onDefaultServerSelectionDone: (client) {
          debugPrint('Default server selected: ${client?.toString()}');
        },
        // Use default test servers
        downloadTestServer: 'http://speedtest.ftp.otenet.gr/files/test10Mb.db',
        uploadTestServer: 'http://speedtest.ftp.otenet.gr/',
        fileSizeInBytes: 10 * 1024 * 1024, // 10 MB (minimum required)
        useFastApi:
            false, // Don't use fast API to avoid connectivity_plus dependency
      );

      debugPrint('startTesting called successfully');
    } catch (e, stackTrace) {
      debugPrint('Exception in _startSpeedTest: $e');
      debugPrint('Stack trace: $stackTrace');
      _handleTestError('Failed to start speed test: ${e.toString()}');
    }
  }

  double _convertToMbps(double transferRate, SpeedUnit unit) {
    switch (unit) {
      case SpeedUnit.kbps:
        return transferRate / 1000; // Convert Kbps to Mbps
      case SpeedUnit.mbps:
        return transferRate;
      case SpeedUnit.gbps:
        return transferRate * 1000; // Convert Gbps to Mbps
      default:
        return transferRate;
    }
  }

  void _handleTestError(String message) {
    isTesting.value = false;
    showResults.value = false;
    testPhase.value = '';

    Get.snackbar(
      'Error',
      message.isNotEmpty
          ? message
          : 'Speed test failed. Please check your internet connection and try again.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> cancelTest() async {
    if (isTesting.value) {
      await speedTest.cancelTest();
      isTesting.value = false;
      testPhase.value = '';
      currentSpeed.value = 0.0;
    }
  }

  @override
  void onClose() {
    speedTest.cancelTest();
    super.onClose();
  }
}
