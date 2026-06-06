import 'package:flutter/material.dart';
import 'package:halon_wattafa/models/model_3d_config.dart';
import 'package:halon_wattafa/models/rss_feed_config.dart';

import '../widgettype.dart';
import 'border_config.dart';
import 'calendar_config.dart';
import 'clock_config.dart';
import 'html_embed_config.dart';
import 'markdown_note_config.dart';

abstract class WidgetConfig {
  final String id;
  final WidgetType type;
  double left;
  double top;
  double width;
  double height;
  BorderStyleConfig borderStyle;
  Color backgroundColor;
  double? fontSize;

  WidgetConfig({
    required this.id,
    required this.type,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.borderStyle,
    required this.backgroundColor,
    this.fontSize,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type.index,
    'left': left,
    'top': top,
    'width': width,
    'height': height,
    'borderStyle': borderStyle.toJson(),
    'backgroundColor': backgroundColor,
    'fontSize': fontSize,
  };

  static WidgetConfig? fromJson(Map<String, dynamic> json) {
    final type = WidgetType.values[json['type']];
    switch (type) {
      case WidgetType.calendar:
        return CalendarConfig.fromJson(json);
      case WidgetType.clock:
        return ClockConfig.fromJson(json);
      case WidgetType.markdownNote:
        return MarkdownNoteConfig.fromJson(json);
      case WidgetType.rssFeed:
        return RssFeedConfig.fromJson(json);
      case WidgetType.model3d:
        return Model3dConfig.fromJson(json);
      case WidgetType.htmlEmbed:
        return HtmlEmbedConfig.fromJson(json);
      default:
        return null;
    }
  }

  WidgetConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
  });
}
