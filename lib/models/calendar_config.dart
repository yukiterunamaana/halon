import 'package:flutter/material.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

enum DisplayMode { week, twoWeeks, month, monthTwoRows }

class CalendarConfig extends WidgetConfig {
  DisplayMode displayMode;
  Color weekdayColor;
  Color saturdayColor;
  Color sundayColor;
  bool startMonday;

  CalendarConfig({
    this.displayMode = .month,
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    required this.weekdayColor,
    required this.saturdayColor,
    required this.sundayColor,
    required this.startMonday,
  }) : super(type: WidgetType.calendar);

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'weekdayColor': weekdayColor.value,
      'saturdayColor': saturdayColor.value,
      'sundayColor': sundayColor.value,
      'startMonday': startMonday,
    });
    return json;
  }

  factory CalendarConfig.fromJson(Map<String, dynamic> json) {
    return CalendarConfig(
      displayMode: DisplayMode.values[json['displayMode']],
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      weekdayColor: Color(json['weekdayColor']),
      saturdayColor: Color(json['saturdayColor']),
      sundayColor: Color(json['sundayColor']),
      startMonday: json['startMonday'],
    );
  }

  @override
  CalendarConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    Color? weekdayColor,
    Color? saturdayColor,
    Color? sundayColor,
    bool? startMonday,
  }) {
    return CalendarConfig(
      id: id,
      displayMode: this.displayMode,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      weekdayColor: weekdayColor ?? this.weekdayColor,
      saturdayColor: saturdayColor ?? this.saturdayColor,
      sundayColor: sundayColor ?? this.sundayColor,
      startMonday: startMonday ?? this.startMonday,
    );
  }
}
