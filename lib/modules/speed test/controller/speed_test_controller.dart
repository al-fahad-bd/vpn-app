import 'package:get/get.dart';
import 'dart:math';
import 'dart:async';

// Controller
class SpeedTestController extends GetxController {
  final RxDouble downloadSpeed = 0.0.obs;
  final RxDouble uploadSpeed = 0.0.obs;
  final RxDouble currentSpeed = 0.0.obs;
  final RxInt ping = 167.obs;
  final RxInt jitter = 167.obs;
  final RxBool isTesting = false.obs;
  final RxBool showResults = false.obs;
  final RxString testPhase = ''.obs; // 'download', 'upload', or ''

  Timer? _testTimer;
  int _testStep = 0;

  void startSpeedTest() {
    if (isTesting.value) return;

    // Reset values
    downloadSpeed.value = 0.0;
    uploadSpeed.value = 0.0;
    currentSpeed.value = 0.0;
    showResults.value = false;
    isTesting.value = true;
    testPhase.value = 'download';
    _testStep = 0;

    // Simulate speed test
    _testTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _testStep++;

      if (_testStep <= 30) {
        // Download phase (3 seconds)
        testPhase.value = 'download';
        currentSpeed.value = _simulateSpeed(30, 50);
        if (_testStep == 30) {
          downloadSpeed.value = currentSpeed.value;
        }
      } else if (_testStep <= 60) {
        // Upload phase (3 seconds)
        testPhase.value = 'upload';
        currentSpeed.value = _simulateSpeed(20, 45);
        if (_testStep == 60) {
          uploadSpeed.value = currentSpeed.value;
        }
      } else {
        // Test complete
        timer.cancel();
        isTesting.value = false;
        showResults.value = true;
        testPhase.value = '';
        currentSpeed.value = downloadSpeed.value;

        // Update ping and jitter
        ping.value = Random().nextInt(50) + 150;
        jitter.value = Random().nextInt(50) + 150;
      }
    });
  }

  double _simulateSpeed(double minSpeed, double maxSpeed) {
    final random = Random();
    final step = _testStep % 30;

    // Create a smooth acceleration curve
    final progress = step / 30.0;
    final easedProgress = _easeInOutCubic(progress);

    final targetSpeed = minSpeed + (maxSpeed - minSpeed) * easedProgress;
    final variation = (random.nextDouble() - 0.5) * 5;

    return (targetSpeed + variation).clamp(0, 100);
  }

  double _easeInOutCubic(double t) {
    return t < 0.5 ? 4 * t * t * t : 1 - pow(-2 * t + 2, 3) / 2;
  }

  @override
  void onClose() {
    _testTimer?.cancel();
    super.onClose();
  }
}
