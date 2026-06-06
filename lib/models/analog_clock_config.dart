// lib/models/analog_clock_config.dart
import 'package:flutter/material.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

class AnalogClockConfig extends WidgetConfig {
  bool showSeconds;
  bool showDate;
  Color dialColor;
  Color handColor;
  Color secondHandColor;
  Color dateColor;

  AnalogClockConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    this.showSeconds = true,
    this.showDate = true,
    this.dialColor = Colors.white,
    this.handColor = Colors.black,
    this.secondHandColor = Colors.red,
    this.dateColor = Colors.black,
  }) : super(type: WidgetType.analogClock);

  factory AnalogClockConfig.withDefaults({required String id}) {
    return AnalogClockConfig(
      id: id,
      left: 20,
      top: 20,
      width: 200,
      height: 200,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'showSeconds': showSeconds,
      'showDate': showDate,
      'dialColor': dialColor,
      'handColor': handColor,
      'secondHandColor': secondHandColor,
      'dateColor': dateColor,
    });
    return json;
  }

  factory AnalogClockConfig.fromJson(Map<String, dynamic> json) {
    return AnalogClockConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      showSeconds: json['showSeconds'] ?? true,
      showDate: json['showDate'] ?? true,
      dialColor: Color(json['dialColor']),
      handColor: Color(json['handColor']),
      secondHandColor: Color(json['secondHandColor']),
      dateColor: Color(json['dateColor']),
    );
  }

  @override
  AnalogClockConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    bool? showSeconds,
    bool? showDate,
    Color? dialColor,
    Color? handColor,
    Color? secondHandColor,
    Color? dateColor,
  }) {
    return AnalogClockConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      showSeconds: showSeconds ?? this.showSeconds,
      showDate: showDate ?? this.showDate,
      dialColor: dialColor ?? this.dialColor,
      handColor: handColor ?? this.handColor,
      secondHandColor: secondHandColor ?? this.secondHandColor,
      dateColor: dateColor ?? this.dateColor,
    );
  }
}
