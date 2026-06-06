import 'package:flutter/material.dart';

import '../models/model_3d_config.dart';

Future<Model3dConfig?> showModel3dSettingsDialog(
  BuildContext context,
  Model3dConfig config,
) async {
  String modelUrl = config.modelUrl;
  bool autoRotate = config.autoRotate;
  double autoRotateSpeed = config.autoRotateSpeed;
  double axisX = config.autoRotateAxisX;
  double axisY = config.autoRotateAxisY;
  double axisZ = config.autoRotateAxisZ;

  // Контроллеры для текстовых полей
  final speedController = TextEditingController(
    text: autoRotateSpeed.toString(),
  );
  final axisXController = TextEditingController(text: axisX.toString());
  final axisYController = TextEditingController(text: axisY.toString());
  final axisZController = TextEditingController(text: axisZ.toString());

  return showDialog<Model3dConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки 3D модели'),
            content: SizedBox(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'URL модели (gltf/glb/obj)',
                      ),
                      controller: TextEditingController(text: modelUrl)
                        ..addListener(
                          () => modelUrl = (TextEditingController(
                            text: modelUrl,
                          )).text,
                        ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Автоматическое вращение'),
                      value: autoRotate,
                      onChanged: (v) => setState(() => autoRotate = v),
                    ),
                    if (autoRotate) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(
                            child: Text('Скорость (градусов/сек):'),
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: speedController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                final val = double.tryParse(value);
                                if (val != null)
                                  autoRotateSpeed = val.clamp(0.5, 10.0);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Оси вращения (множители направления, -1..1):',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(child: Text('Ось X:')),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: axisXController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                final val = double.tryParse(value);
                                if (val != null) axisX = val.clamp(-1.0, 1.0);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(child: Text('Ось Y:')),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: axisYController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                final val = double.tryParse(value);
                                if (val != null) axisY = val.clamp(-1.0, 1.0);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(child: Text('Ось Z:')),
                          const SizedBox(width: 8),
                          SizedBox(
                            width: 100,
                            child: TextField(
                              controller: axisZController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              onChanged: (value) {
                                final val = double.tryParse(value);
                                if (val != null) axisZ = val.clamp(-1.0, 1.0);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  config.copyWith(
                    modelUrl: modelUrl,
                    autoRotate: autoRotate,
                    autoRotateSpeed: autoRotateSpeed,
                    autoRotateAxisX: axisX,
                    autoRotateAxisY: axisY,
                    autoRotateAxisZ: axisZ,
                  ),
                ),
                child: const Text('Сохранить'),
              ),
            ],
          );
        },
      );
    },
  );
}
