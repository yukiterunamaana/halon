import 'package:flutter/material.dart';

import '../models/markdown_note_config.dart';
import 'color_picker_dialog.dart';

Future<MarkdownNoteConfig?> showMarkdownSettingsDialog(
  BuildContext context,
  MarkdownNoteConfig config,
) async {
  String content = config.content;
  Color textColor = config.textColor;
  double textScale = config.textScale;

  return showDialog<MarkdownNoteConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Редактировать заметку'),
            content: SizedBox(
              width: 400,
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        labelText: 'Текст (Markdown)',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: content)
                        ..addListener(
                          () => content = (TextEditingController(
                            text: content,
                          )).text,
                        ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text('Цвет текста'),
                    trailing: GestureDetector(
                      onTap: () async {
                        final color = await showColorPickerDialog(
                          context,
                          textColor,
                        );
                        if (color != null) setState(() => textColor = color);
                      },
                      child: Container(width: 40, height: 40, color: textColor),
                    ),
                  ),
                  ListTile(
                    title: const Text('Масштаб текста'),
                    trailing: SizedBox(
                      width: 150,
                      child: Slider(
                        min: 0.5,
                        max: 2.0,
                        divisions: 15,
                        value: textScale,
                        onChanged: (v) => setState(() => textScale = v),
                      ),
                    ),
                  ),
                ],
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
                    content: content,
                    textColor: textColor,
                    textScale: textScale,
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
