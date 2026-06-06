import 'package:flutter/material.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

enum DigitFormat { arabic, roman, easternArabic }

class ClockConfig extends WidgetConfig {
  DigitFormat digitFormat;
  bool showSeconds;

  ClockConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    required this.digitFormat,
    required this.showSeconds,
  }) : super(type: WidgetType.clock);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({'digitFormat': digitFormat.index, 'showSeconds': showSeconds});
    return json;
  }

  factory ClockConfig.fromJson(Map<String, dynamic> json) {
    return ClockConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      digitFormat: DigitFormat.values[json['digitFormat']],
      showSeconds: json['showSeconds'],
    );
  }

  @override
  ClockConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    DigitFormat? digitFormat,
    bool? showSeconds,
  }) {
    return ClockConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      digitFormat: digitFormat ?? this.digitFormat,
      showSeconds: showSeconds ?? this.showSeconds,
    );
  }
}
