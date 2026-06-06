import 'package:flutter/material.dart';

import '../models/border_config.dart';
import 'color_picker_dialog.dart';

Future<BorderStyleConfig?> showStyleEditorDialog(
  BuildContext context,
  BorderStyleConfig current,
) async {
  Color borderColor = current.color;
  double borderWidth = current.width;
  double borderRadius = current.radius;
  Color bgColor = current.color;

  return showDialog<BorderStyleConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки рамки'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Цвет границы'),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    color: borderColor,
                  ),
                  onTap: () async {
                    final c = await showColorPickerDialog(context, borderColor);
                    if (c != null) setState(() => borderColor = c);
                  },
                ),
                ListTile(
                  title: const Text('Толщина границы'),
                  trailing: SizedBox(
                    width: 100,
                    child: Slider(
                      min: 0,
                      max: 10,
                      value: borderWidth,
                      onChanged: (v) => setState(() => borderWidth = v),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('Радиус скругления'),
                  trailing: SizedBox(
                    width: 100,
                    child: Slider(
                      min: 0,
                      max: 30,
                      value: borderRadius,
                      onChanged: (v) => setState(() => borderRadius = v),
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(
                  context,
                  BorderStyleConfig(
                    color: borderColor,
                    width: borderWidth,
                    radius: borderRadius,
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
