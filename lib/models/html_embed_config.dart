import 'package:flutter/material.dart';
import 'package:halon_wattafa/models/board_config.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

class HtmlEmbedConfig extends WidgetConfig {
  String url;
  String htmlCode;
  bool enableJavaScript;

  HtmlEmbedConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    required this.url,
    required this.htmlCode,
    this.enableJavaScript = true,
  }) : super(type: WidgetType.htmlEmbed);

  factory HtmlEmbedConfig.withDefaults({required String id}) {
    return HtmlEmbedConfig(
      id: id,
      left: 1 * BoardConfig.gridStep,
      top: 1 * BoardConfig.gridStep,
      width: 4 * BoardConfig.gridStep,
      height: 4 * BoardConfig.gridStep,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
      url: 'https://example.com',
      htmlCode:
          '<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/X4VbdwhkE10" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>',
      enableJavaScript: true,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({'url': url, 'enableJavaScript': enableJavaScript});
    return json;
  }

  factory HtmlEmbedConfig.fromJson(Map<String, dynamic> json) {
    return HtmlEmbedConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      url: json['url'],
      enableJavaScript: json['enableJavaScript'] ?? true,
      htmlCode: '',
    );
  }

  @override
  HtmlEmbedConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    String? url,
    bool? enableZoom,
    bool? enableJavaScript,
  }) {
    return HtmlEmbedConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      url: url ?? this.url,
      enableJavaScript: enableJavaScript ?? this.enableJavaScript,
      htmlCode: '',
    );
  }
}
