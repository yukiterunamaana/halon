import 'package:flutter/material.dart';

class BorderStyleConfig {
  final Color color;
  final double width;
  final double radius;

  BorderStyleConfig({
    required this.color,
    required this.width,
    required this.radius,
  });

  Map<String, dynamic> toJson() => {
    'color': color.value,
    'width': width,
    'radius': radius,
  };

  factory BorderStyleConfig.fromJson(Map<String, dynamic> json) {
    return BorderStyleConfig(
      color: Color(json['color']),
      width: json['width'].toDouble(),
      radius: json['radius'].toDouble(),
    );
  }

  BorderStyleConfig copyWith({Color? color, double? width, double? radius}) {
    return BorderStyleConfig(
      color: color ?? this.color,
      width: width ?? this.width,
      radius: radius ?? this.radius,
    );
  }
}
