import 'package:flutter/material.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

class ImageConfig extends WidgetConfig {
  String imageUrl;
  BoxFit fit;

  ImageConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    this.imageUrl = '',
    this.fit = BoxFit.contain,
  }) : super(type: WidgetType.image);

  factory ImageConfig.withDefaults({required String id}) {
    return ImageConfig(
      id: id,
      left: 20,
      top: 20,
      width: 300,
      height: 200,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
      imageUrl: 'https://fastly.picsum.photos/id/1015/300/200.jpg',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({'imageUrl': imageUrl, 'fit': fit.index});
    return json;
  }

  factory ImageConfig.fromJson(Map<String, dynamic> json) {
    return ImageConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      imageUrl: json['imageUrl'],
      fit: BoxFit.values[json['fit'] ?? 0],
    );
  }

  @override
  ImageConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    String? imageUrl,
    BoxFit? fit,
  }) {
    return ImageConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      imageUrl: imageUrl ?? this.imageUrl,
      fit: fit ?? this.fit,
    );
  }
}
