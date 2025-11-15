// Speed Test Screen
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/modules/controllers/speed_test_controller.dart';

class SpeedTestScreen extends StatelessWidget {
  const SpeedTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpeedTestController());

    return Scaffold(
      backgroundColor: const Color(0xFF6B5CE7),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                          onPressed: () => Get.back(),
                        ),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Speed Test',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Download and Upload Display
                Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Download
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_downward,
                              color: controller.testPhase.value == 'download'
                                  ? Colors.white
                                  : Colors.white70,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Download',
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.showResults.value || controller.downloadSpeed.value > 0
                                  ? '${controller.downloadSpeed.value.toStringAsFixed(2)} Mbps'
                                  : controller.testPhase.value == 'download'
                                  ? '${controller.currentSpeed.value.toStringAsFixed(2)} Mbps'
                                  : '0.00 Mbps',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        width: 2,
                        height: 80,
                        color: Colors.white30,
                      ),
                      
                      // Upload
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.arrow_upward,
                              color: controller.testPhase.value == 'upload'
                                  ? Colors.white
                                  : Colors.white70,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Upload',
                              style: TextStyle(color: Colors.white70, fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.showResults.value || controller.uploadSpeed.value > 0
                                  ? '${controller.uploadSpeed.value.toStringAsFixed(2)} Mbps'
                                  : controller.testPhase.value == 'upload'
                                  ? '${controller.currentSpeed.value.toStringAsFixed(2)} Mbps'
                                  : '0.00 Mbps',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

                const SizedBox(height: 10),

                // Speed Gauge
                Flexible(
                  child: Center(
                    child: Obx(() {
                      if (controller.isTesting.value) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SpeedGauge(
                              speed: controller.currentSpeed.value,
                              isTesting: controller.isTesting.value,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _getTestPhaseText(controller.testPhase.value),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextButton.icon(
                              onPressed: controller.cancelTest,
                              icon: const Icon(Icons.close, color: Colors.white),
                              label: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withValues(alpha: 0.2),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else if (controller.showResults.value) {
                        return SpeedGauge(
                          speed: controller.downloadSpeed.value,
                          isTesting: false,
                        );
                      } else {
                        return GestureDetector(
                          onTap: controller.startSpeedTest,
                          child: Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF8B7CE8),
                                  Color(0xFF5B4CC7),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'GO',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 72,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                ),

                // Progress indicator
                Obx(() => controller.isTesting.value
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.testPhase.value == 'download'
                                      ? 'Download Progress'
                                      : controller.testPhase.value == 'upload'
                                      ? 'Upload Progress'
                                      : 'Initializing...',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  controller.testPhase.value == 'download'
                                      ? '${controller.downloadProgress.value.toStringAsFixed(0)}%'
                                      : controller.testPhase.value == 'upload'
                                      ? '${controller.uploadProgress.value.toStringAsFixed(0)}%'
                                      : '',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: controller.testPhase.value == 'download'
                                    ? controller.downloadProgress.value / 100
                                    : controller.testPhase.value == 'upload'
                                    ? controller.uploadProgress.value / 100
                                    : 0,
                                backgroundColor: Colors.white.withValues(alpha: 0.2),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox(height: 48)),

                // Network Info Cards
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: _NetworkCard(
                          icon: Icons.wifi,
                          title: 'Sol-BD',
                          subtitle: 'iPhone 13 Pro Max',
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _NetworkCard(
                          icon: Icons.cell_tower,
                          title: 'Network',
                          subtitle: 'Sylhet, BD',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Server Location
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset('assets/countryFlags/gb-nir.png'),
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Test Server',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Auto-selected',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
            );
    },
    )));
  }

  String _getTestPhaseText(String phase) {
    switch (phase) {
      case 'initializing':
        return 'Initializing...';
      case 'selecting_server':
        return 'Selecting Server...';
      case 'download':
        return 'Testing Download Speed';
      case 'upload':
        return 'Testing Upload Speed';
      default:
        return 'Running Test...';
    }
  }
}

class SpeedGauge extends StatelessWidget {
  final double speed;
  final bool isTesting;

  const SpeedGauge({
    super.key,
    required this.speed,
    required this.isTesting,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        children: [
          CustomPaint(
            size: const Size(280, 280),
            painter: SpeedGaugePainter(speed: speed, isTesting: isTesting),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  speed.toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Mbps',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SpeedGaugePainter extends CustomPainter {
  final double speed;
  final bool isTesting;

  SpeedGaugePainter({required this.speed, required this.isTesting});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Background arc
    final backgroundPaint = Paint()
      ..color = const Color(0xFF2D2658)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi * 1.30,
      pi * 1.60,
      false,
      backgroundPaint,
    );

    // Progress arc
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF9B8CE8), Color(0xFF7B6CD8)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 21
      ..strokeCap = StrokeCap.round;

    // Clamp speed to a maximum of 100 for display purposes
    final displaySpeed = speed > 100 ? 100 : speed;
    final sweepAngle = (displaySpeed / 100) * pi * 1.5;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi * 1.30,
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw scale markers
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final markers = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
    for (var marker in markers) {
      final angle = -pi * 1.25 + (marker / 100) * pi * 1.5;
      final x = center.dx + (radius - 35) * cos(angle);
      final y = center.dy + (radius - 35) * sin(angle);

      textPainter.text = TextSpan(
        text: marker.toString(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, y - textPainter.height / 2),
      );
    }

    // Draw needle
    final needleAngle = -pi * 1.70 + sweepAngle;
    final needlePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final needlePath = Path();
    needlePath.moveTo(
      center.dx + 8 * cos(needleAngle + pi / 2),
      center.dy + 8 * sin(needleAngle + pi / 2),
    );
    needlePath.lineTo(
      center.dx + (radius - 50) * cos(needleAngle),
      center.dy + (radius - 50) * sin(needleAngle),
    );
    needlePath.lineTo(
      center.dx + 8 * cos(needleAngle - pi / 2),
      center.dy + 8 * sin(needleAngle - pi / 2),
    );
    needlePath.close();

    canvas.drawPath(needlePath, needlePaint);

    // Center circle
    canvas.drawCircle(center, 10, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(SpeedGaugePainter oldDelegate) {
    return oldDelegate.speed != speed || oldDelegate.isTesting != isTesting;
  }
}

class _NetworkCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _NetworkCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}