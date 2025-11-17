import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

/// Helper class for accurate ping measurements
class PingHelper {
  /// Measures ping to a given host
  /// Returns ping time in milliseconds, or -1 if failed
  static Future<int> ping(String host, {int timeout = 2000}) async {
    try {
      final stopwatch = Stopwatch()..start();

      // Parse URL to get host
      final uri = Uri.parse(host);
      final hostName = uri.host.isNotEmpty ? uri.host : host;

      // Attempt to lookup the host
      final addresses = await InternetAddress.lookup(
        hostName,
        type: InternetAddressType.any,
      ).timeout(
        Duration(milliseconds: timeout),
        onTimeout: () => throw TimeoutException('Ping timeout'),
      );

      if (addresses.isEmpty) {
        return -1;
      }

      // Try to connect to the host
      Socket? socket;
      try {
        socket = await Socket.connect(
          addresses.first,
          uri.hasPort ? uri.port : 80,
          timeout: Duration(milliseconds: timeout),
        );

        stopwatch.stop();
        return stopwatch.elapsedMilliseconds;
      } finally {
        socket?.destroy();
      }
    } catch (e) {
      debugPrint('Ping error for $host: $e');
      return -1;
    }
  }

  /// Measures ping to multiple servers and returns the best result
  static Future<PingResult> measurePing({
    List<String>? servers,
    int samples = 5,
  }) async {
    final testServers = servers ??
        [
          'www.google.com',
          'www.cloudflare.com',
          'www.amazon.com',
        ];

    final List<int> successfulPings = [];

    for (int i = 0; i < samples; i++) {
      final server = testServers[i % testServers.length];
      final pingTime = await ping(server);

      if (pingTime > 0) {
        successfulPings.add(pingTime);
      }

      // Small delay between pings
      if (i < samples - 1) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }

    if (successfulPings.isEmpty) {
      return PingResult(
        averagePing: 0,
        jitter: 0,
        minPing: 0,
        maxPing: 0,
        samples: [],
      );
    }

    // Calculate statistics
    final avgPing =
        successfulPings.reduce((a, b) => a + b) / successfulPings.length;
    final minPing = successfulPings.reduce((a, b) => a < b ? a : b);
    final maxPing = successfulPings.reduce((a, b) => a > b ? a : b);

    // Calculate jitter (standard deviation)
    double variance = 0;
    for (var ping in successfulPings) {
      variance += (ping - avgPing) * (ping - avgPing);
    }
    final jitter = sqrt(variance / successfulPings.length);

    return PingResult(
      averagePing: avgPing.round(),
      jitter: jitter.round(),
      minPing: minPing,
      maxPing: maxPing,
      samples: successfulPings,
    );
  }
}

/// Result of ping measurement
class PingResult {
  final int averagePing;
  final int jitter;
  final int minPing;
  final int maxPing;
  final List<int> samples;

  PingResult({
    required this.averagePing,
    required this.jitter,
    required this.minPing,
    required this.maxPing,
    required this.samples,
  });

  @override
  String toString() {
    return 'PingResult(avg: ${averagePing}ms, jitter: ${jitter}ms, min: ${minPing}ms, max: ${maxPing}ms)';
  }
}
