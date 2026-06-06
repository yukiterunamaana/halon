import 'package:flutter/material.dart';

import '../models/image_config.dart';

Future<ImageConfig?> showImageSettingsDialog(
  BuildContext context,
  ImageConfig config,
) async {
  String imageUrl = config.imageUrl;
  BoxFit fit = config.fit;

  return showDialog<ImageConfig>(
    context: context,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки изображения'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'URL изображения',
                  ),
                  controller: TextEditingController(text: imageUrl)
                    ..addListener(
                      () => imageUrl = (TextEditingController(
                        text: imageUrl,
                      )).text,
                    ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<BoxFit>(
                  value: fit,
                  items: const [
                    DropdownMenuItem(value: BoxFit.fill, child: Text('fill')),
                    DropdownMenuItem(
                      value: BoxFit.contain,
                      child: Text('contain'),
                    ),
                    DropdownMenuItem(value: BoxFit.cover, child: Text('cover')),
                    DropdownMenuItem(
                      value: BoxFit.fitWidth,
                      child: Text('fitWidth'),
                    ),
                    DropdownMenuItem(
                      value: BoxFit.fitHeight,
                      child: Text('fitHeight'),
                    ),
                    DropdownMenuItem(value: BoxFit.none, child: Text('none')),
                    DropdownMenuItem(
                      value: BoxFit.scaleDown,
                      child: Text('scaleDown'),
                    ),
                  ],
                  onChanged: (v) => setState(() => fit = v!),
                  decoration: const InputDecoration(
                    labelText: 'Режим масштабирования',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  ctx,
                  config.copyWith(imageUrl: imageUrl, fit: fit),
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
