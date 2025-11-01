// Speed Test Screen
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/controllers/speed_test_controller';

class SpeedTestScreen extends StatelessWidget {
  const SpeedTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SpeedTestController());

    return Scaffold(
      backgroundColor: const Color(0xFF6B5CE7),
      body: SafeArea(
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
                        const Icon(Icons.arrow_downward, color: Colors.white70, size: 32),
                        const SizedBox(height: 8),
                        const Text(
                          'Download',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.showResults.value
                              ? '${controller.downloadSpeed.value.toStringAsFixed(2)} Mbp/s'
                              : '0.00 Mbp/s',
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
                        const Icon(Icons.arrow_upward, color: Colors.white70, size: 32),
                        const SizedBox(height: 8),
                        const Text(
                          'Upload',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller.showResults.value
                              ? '${controller.uploadSpeed.value.toStringAsFixed(2)} Mbp/s'
                              : '0.00 Mbp/s',
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

            const SizedBox(height: 40),

            // Speed Gauge
            Expanded(
              child: Center(
                child: Obx(() => controller.isTesting.value || controller.showResults.value
                    ? SpeedGauge(
                        speed: controller.currentSpeed.value,
                        isTesting: controller.isTesting.value,
                      )
                    : GestureDetector(
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
                      )),
              ),
            ),

            // Info Row
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _InfoItem(
                    icon: Icons.signal_cellular_alt,
                    label: 'Ping - ${controller.ping.value}ms',
                    color: Colors.green,
                  ),
                  _InfoItem(
                    icon: Icons.show_chart,
                    label: 'Jitter - ${controller.jitter.value}ms',
                    color: Colors.pink,
                  ),
                  const _InfoItem(
                    icon: Icons.public,
                    label: 'IP - Public',
                    color: Colors.orange,
                  ),
                ],
              ),
            )),

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
                      icon: Icons.wifi,
                      title: 'Nerscope',
                      subtitle: 'Sylhet, BD',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://flagcdn.com/w80/gb.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'United Kingdom',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '212.369.56.87',
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

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
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
      child: CustomPaint(
        painter: SpeedGaugePainter(speed: speed, isTesting: isTesting),
        child: Center(
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
      -pi * 0.75,
      pi * 1.5,
      false,
      backgroundPaint,
    );

    // Progress arc
    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF9B8CE8), Color(0xFF7B6CD8)],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28
      ..strokeCap = StrokeCap.round;

    final sweepAngle = (speed / 100) * pi * 1.5;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi * 0.75,
      sweepAngle,
      false,
      progressPaint,
    );

    // Draw scale markers
    final markerPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final markers = [0, 5, 10, 20, 30, 60, 100];
    for (var marker in markers) {
      final angle = -pi * 0.75 + (marker / 100) * pi * 1.5;
      final x = center.dx + (radius - 45) * cos(angle);
      final y = center.dy + (radius - 45) * sin(angle);

      textPainter.text = TextSpan(
        text: marker.toString(),
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
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
    final needleAngle = -pi * 0.75 + sweepAngle;
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

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
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
        color: Colors.white.withOpacity(0.15),
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