import 'package:flutter/material.dart';
import 'package:halon_wattafa/models/widget_config.dart';

import '../widgettype.dart';
import 'border_config.dart';

class Model3dConfig extends WidgetConfig {
  String modelUrl; // может быть пустым, если используется localModelPath
  String? localModelPath; // путь к файлу в локальном хранилище
  String? posterUrl;
  bool autoRotate;
  double autoRotateSpeed;
  double autoRotateAxisX;
  double autoRotateAxisY;
  double autoRotateAxisZ;

  Model3dConfig({
    required super.id,
    required super.left,
    required super.top,
    required super.width,
    required super.height,
    required super.borderStyle,
    required super.backgroundColor,
    super.fontSize,
    this.modelUrl = '',
    this.localModelPath,
    this.posterUrl,
    this.autoRotate = true,
    this.autoRotateSpeed = 2.0,
    this.autoRotateAxisX = 0.0,
    this.autoRotateAxisY = 1.0,
    this.autoRotateAxisZ = 0.0,
  }) : super(type: WidgetType.model3d);

  // Фабричный метод по умолчанию – использует URL демо-модели
  factory Model3dConfig.withDefaults({required String id}) {
    return Model3dConfig(
      id: id,
      left: 20,
      top: 20,
      width: 300,
      height: 300,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
      modelUrl:
          'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/main/2.0/DamagedHelmet/glTF/DamagedHelmet.gltf',
    );
  }

  // Получить актуальный источник (приоритет у локального файла)
  String get effectiveUrl {
    if (localModelPath != null && localModelPath!.isNotEmpty) {
      // Для десктопа/мобилы работает file://, для Web не поддерживается
      return 'file://$localModelPath';
    }
    return modelUrl;
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json.addAll({
      'modelUrl': modelUrl,
      'localModelPath': localModelPath,
      'posterUrl': posterUrl,
      'autoRotate': autoRotate,
      'autoRotateSpeed': autoRotateSpeed,
      'autoRotateAxisX': autoRotateAxisX,
      'autoRotateAxisY': autoRotateAxisY,
      'autoRotateAxisZ': autoRotateAxisZ,
    });
    return json;
  }

  factory Model3dConfig.fromJson(Map<String, dynamic> json) {
    return Model3dConfig(
      id: json['id'],
      left: json['left'],
      top: json['top'],
      width: json['width'],
      height: json['height'],
      borderStyle: BorderStyleConfig.fromJson(json['borderStyle']),
      backgroundColor: Color(json['backgroundColor']),
      fontSize: json['fontSize']?.toDouble(),
      modelUrl: json['modelUrl'] ?? '',
      localModelPath: json['localModelPath'],
      posterUrl: json['posterUrl'],
      autoRotate: json['autoRotate'] ?? true,
      autoRotateSpeed: (json['autoRotateSpeed'] ?? 2.0).toDouble(),
      autoRotateAxisX: (json['autoRotateAxisX'] ?? 0.0).toDouble(),
      autoRotateAxisY: (json['autoRotateAxisY'] ?? 1.0).toDouble(),
      autoRotateAxisZ: (json['autoRotateAxisZ'] ?? 0.0).toDouble(),
    );
  }

  @override
  Model3dConfig copyWith({
    double? left,
    double? top,
    double? width,
    double? height,
    BorderStyleConfig? borderStyle,
    Color? backgroundColor,
    double? fontSize,
    String? modelUrl,
    String? localModelPath,
    String? posterUrl,
    bool? autoRotate,
    double? autoRotateSpeed,
    double? autoRotateAxisX,
    double? autoRotateAxisY,
    double? autoRotateAxisZ,
  }) {
    return Model3dConfig(
      id: id,
      left: left ?? this.left,
      top: top ?? this.top,
      width: width ?? this.width,
      height: height ?? this.height,
      borderStyle: borderStyle ?? this.borderStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontSize: fontSize ?? this.fontSize,
      modelUrl: modelUrl ?? this.modelUrl,
      localModelPath: localModelPath ?? this.localModelPath,
      posterUrl: posterUrl ?? this.posterUrl,
      autoRotate: autoRotate ?? this.autoRotate,
      autoRotateSpeed: autoRotateSpeed ?? this.autoRotateSpeed,
      autoRotateAxisX: autoRotateAxisX ?? this.autoRotateAxisX,
      autoRotateAxisY: autoRotateAxisY ?? this.autoRotateAxisY,
      autoRotateAxisZ: autoRotateAxisZ ?? this.autoRotateAxisZ,
    );
  }
}
