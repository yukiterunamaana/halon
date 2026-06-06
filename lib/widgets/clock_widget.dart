import 'dart:async';

import 'package:flutter/material.dart';

import '../models/clock_config.dart';

class ClockWidget extends StatefulWidget {
  final ClockConfig config;
  const ClockWidget({super.key, required this.config});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
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

  /*  String _formatNumber(int n) {
    switch (widget.config.digitFormat) {
      case DigitFormat.arabic:
        return n.toString();
      case DigitFormat.roman:
        return _toRoman(n);
      case DigitFormat.easternArabic:
        return _toEasternArabic(n);
    }
  }*/

  /*  String _toRoman(int n) {
    const r = [
      '',
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
    ];
    return n <= 12 ? r[n] : n.toString();
  }

  String _toEasternArabic(int n) {
    const e = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return n.toString().split('').map((ch) => e[int.parse(ch)]).join();
  }*/

  String formatTimeUnit(int i) {
    return i < 10 ? '0${i.toString()}' : i.toString();
  }

  @override
  Widget build(BuildContext context) {
    final time =
        '${formatTimeUnit(_now.hour)}:${formatTimeUnit(_now.minute)}${widget.config.showSeconds ? ':${formatTimeUnit(_now.second)}' : ''}';
    final date = '${_now.day}.${_now.month}.${_now.year}';
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: widget.config.fontSize ?? 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}

/*
import 'dart:async';

import 'package:flutter/material.dart';

import '../models/clock_config.dart';

class ClockWidget extends StatefulWidget {
  final ClockConfig config;
  const ClockWidget({super.key, required this.config});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
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

  String _formatNumber(int n) {
    switch (widget.config.digitFormat) {
      case DigitFormat.arabic:
        return n.toString();
      case DigitFormat.roman:
        return _toRoman(n);
      case DigitFormat.easternArabic:
        return _toEasternArabic(n);
    }
  }

  String _toRoman(int n) {
    // упрощённо для 1-12
    const roman = [
      '',
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI',
      'XII',
    ];
    return roman[n];
  }

  String _toEasternArabic(int n) {
    const eastern = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return n.toString().split('').map((ch) => eastern[int.parse(ch)]).join();
  }

  @override
  Widget build(BuildContext context) {
    final time =
        '${_formatNumber(_now.hour)}:${_formatNumber(_now.minute)}${widget.config.showSeconds ? ':${_formatNumber(_now.second)}' : ''}';
    return Container(
      alignment: Alignment.center,
      child: Text(
        time,
        style: TextStyle(fontSize: widget.config.fontSize ?? 24),
      ),
    );
  }
}
*/
