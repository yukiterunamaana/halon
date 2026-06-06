// lib/widgets/analog_clock_widget.dart
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/analog_clock_config.dart';

class AnalogClockWidget extends StatefulWidget {
  final AnalogClockConfig config;
  const AnalogClockWidget({super.key, required this.config});

  @override
  State<AnalogClockWidget> createState() => _AnalogClockWidgetState();
}

class _AnalogClockWidgetState extends State<AnalogClockWidget> {
  late DateTime _now;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AnalogClockPainter(dateTime: _now, config: widget.config),
      size: Size(widget.config.width, widget.config.height),
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  final DateTime dateTime;
  final AnalogClockConfig config;

  _AnalogClockPainter({required this.dateTime, required this.config});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;
    final strokeWidth = radius * 0.03;

    canvas.drawCircle(center, radius, Paint()..color = config.dialColor);

    for (int i = 1; i <= 12; i++) {
      final angle = (i * 30) * pi / 180;
      final start = Offset(
        center.dx + (size.width / 2 - 2) * cos(angle),
        center.dy + (size.height / 2 - 2) * sin(angle),
      );
      final end = Offset(
        center.dx + (size.width / 2 - size.width * 0.1) * cos(angle),
        center.dy + (size.height / 2 - size.height * 0.1) * sin(angle),
      );
      canvas.drawLine(
        start,
        end,
        Paint()
          ..color = Colors.black
          ..strokeWidth = strokeWidth,
      );
    }

    final hour = dateTime.hour % 12;
    final minute = dateTime.minute;
    final second = dateTime.second;
    final hourAngle = (hour + minute / 60) * 30 * pi / 180;
    final minuteAngle = (minute + second / 60) * 6 * pi / 180;
    final secondAngle = second * 6 * pi / 180;

    if (config.showSeconds) {
      final secondLength = radius * 0.9;
      final secondEnd = Offset(
        center.dx + secondLength * cos(secondAngle - pi / 2),
        center.dy + secondLength * sin(secondAngle - pi / 2),
      );
      canvas.drawLine(
        center,
        secondEnd,
        Paint()
          ..color = config.secondHandColor
          ..strokeWidth = strokeWidth * 0.6,
      );
    }

    final minuteLength = radius * 0.75;
    final minuteEnd = Offset(
      center.dx + minuteLength * cos(minuteAngle - pi / 2),
      center.dy + minuteLength * sin(minuteAngle - pi / 2),
    );
    canvas.drawLine(
      center,
      minuteEnd,
      Paint()
        ..color = config.handColor
        ..strokeWidth = strokeWidth * 1.2,
    );

    final hourLength = radius * 0.55;
    final hourEnd = Offset(
      center.dx + hourLength * cos(hourAngle - pi / 2),
      center.dy + hourLength * sin(hourAngle - pi / 2),
    );
    canvas.drawLine(
      center,
      hourEnd,
      Paint()
        ..color = config.handColor
        ..strokeWidth = strokeWidth * 1.6,
    );

    canvas.drawCircle(center, strokeWidth * 1.2, Paint()..color = Colors.black);

    if (config.showDate) {
      final dateText = '${dateTime.day}';
      final textSpan = TextSpan(
        text: dateText,
        style: TextStyle(
          color: config.dateColor,
          fontSize: radius * 0.2,
          fontWeight: FontWeight.bold,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final textOffset = Offset(
        center.dx + radius * 0.65,
        center.dy - textPainter.height / 2,
      );
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant _AnalogClockPainter oldDelegate) {
    return oldDelegate.dateTime != dateTime ||
        oldDelegate.config.showSeconds != config.showSeconds ||
        oldDelegate.config.showDate != config.showDate ||
        oldDelegate.config.dialColor != config.dialColor ||
        oldDelegate.config.handColor != config.handColor ||
        oldDelegate.config.secondHandColor != config.secondHandColor ||
        oldDelegate.config.dateColor != config.dateColor;
  }
}
