import 'package:flutter/material.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

class RssFeedConfig extends WidgetConfig {
  String feedUrl; // URL RSS-ленты
  int itemsCount; // количество отображаемых записей
  Color titleColor;
  Color descriptionColor;
  double titleFontSize;
  double descriptionFontSize;
  bool showDescription;

  RssFeedConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    required this.feedUrl,
    this.itemsCount = 5,
    this.titleColor = Colors.black,
    this.descriptionColor = Colors.grey,
    this.titleFontSize = 16,
    this.descriptionFontSize = 12,
    this.showDescription = true,
  }) : super(type: WidgetType.rssFeed);

  factory RssFeedConfig.withDefaults({required String id}) {
    return RssFeedConfig(
      id: id,
      left: 20,
      top: 20,
      width: 300,
      height: 350,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
      feedUrl: 'https://habr.com/ru/rss/hub/all/',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'feedUrl': feedUrl,
      'itemsCount': itemsCount,
      'titleColor': titleColor.value,
      'descriptionColor': descriptionColor.value,
      'titleFontSize': titleFontSize,
      'descriptionFontSize': descriptionFontSize,
      'showDescription': showDescription,
    });
    return json;
  }

  factory RssFeedConfig.fromJson(Map<String, dynamic> json) {
    return RssFeedConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      feedUrl: json['feedUrl'] ?? '',
      itemsCount: json['itemsCount'] ?? 5,
      titleColor: Color(json['titleColor']),
      descriptionColor: Color(json['descriptionColor']),
      titleFontSize: json['titleFontSize']?.toDouble() ?? 16,
      descriptionFontSize: json['descriptionFontSize']?.toDouble() ?? 12,
      showDescription: json['showDescription'] ?? true,
    );
  }

  @override
  RssFeedConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    String? feedUrl,
    int? itemsCount,
    Color? titleColor,
    Color? descriptionColor,
    double? titleFontSize,
    double? descriptionFontSize,
    bool? showDescription,
  }) {
    return RssFeedConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      feedUrl: feedUrl ?? this.feedUrl,
      itemsCount: itemsCount ?? this.itemsCount,
      titleColor: titleColor ?? this.titleColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      titleFontSize: titleFontSize ?? this.titleFontSize,
      descriptionFontSize: descriptionFontSize ?? this.descriptionFontSize,
      showDescription: showDescription ?? this.showDescription,
    );
  }
}
