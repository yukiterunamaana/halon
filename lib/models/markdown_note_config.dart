import 'package:flutter/material.dart';
import 'package:halon_wattafa/models/board_config.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'widget_config.dart';

class MarkdownNoteConfig extends WidgetConfig {
  String content;
  Color textColor;
  double textScale;

  MarkdownNoteConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    required this.content,
    this.textColor = Colors.black,
    this.textScale = 1.0,
  }) : super(type: WidgetType.markdownNote);

  factory MarkdownNoteConfig.withDefaults({required String id}) {
    return MarkdownNoteConfig(
      id: id,
      left: 1 * BoardConfig.gridStep,
      top: 1 * BoardConfig.gridStep,
      width: 4 * BoardConfig.gridStep,
      height: 4 * BoardConfig.gridStep,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
      content:
          '# Заметка\n\nЭто **пример** *markdown* текста.\n\n- Пункт 1\n- Пункт 2',
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'content': content,
      'textColor': textColor.value,
      'textScale': textScale,
    });
    return json;
  }

  factory MarkdownNoteConfig.fromJson(Map<String, dynamic> json) {
    return MarkdownNoteConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      content: json['content'] ?? '',
      textColor: Color(json['textColor']),
      textScale: json['textScale']?.toDouble() ?? 1.0,
    );
  }

  @override
  MarkdownNoteConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    String? content,
    Color? textColor,
    double? textScale,
  }) {
    return MarkdownNoteConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      content: content ?? this.content,
      textColor: textColor ?? this.textColor,
      textScale: textScale ?? this.textScale,
    );
  }
}
