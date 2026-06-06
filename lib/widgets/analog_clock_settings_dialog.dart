// lib/widgets/analog_clock_settings_dialog.dart
import 'package:flutter/material.dart';

import '../models/analog_clock_config.dart';
import 'color_picker_dialog.dart';

Future<AnalogClockConfig?> showAnalogClockSettingsDialog(
  BuildContext context,
  AnalogClockConfig config,
) async {
  bool showSeconds = config.showSeconds;
  bool showDate = config.showDate;
  Color dialColor = config.dialColor;
  Color handColor = config.handColor;
  Color secondHandColor = config.secondHandColor;
  Color dateColor = config.dateColor;

  return showDialog<AnalogClockConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки часов'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SwitchListTile(
                    title: const Text('Показывать секундную стрелку'),
                    value: showSeconds,
                    onChanged: (v) => setState(() => showSeconds = v),
                  ),
                  SwitchListTile(
                    title: const Text('Показывать дату'),
                    value: showDate,
                    onChanged: (v) => setState(() => showDate = v),
                  ),
                  _colorTile(
                    context,
                    'Цвет циферблата',
                    dialColor,
                    (c) => setState(() => dialColor = c),
                  ),
                  _colorTile(
                    context,
                    'Цвет стрелок',
                    handColor,
                    (c) => setState(() => handColor = c),
                  ),
                  _colorTile(
                    context,
                    'Цвет секундной стрелки',
                    secondHandColor,
                    (c) => setState(() => secondHandColor = c),
                  ),
                  _colorTile(
                    context,
                    'Цвет даты',
                    dateColor,
                    (c) => setState(() => dateColor = c),
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
                    showSeconds: showSeconds,
                    showDate: showDate,
                    dialColor: dialColor,
                    handColor: handColor,
                    secondHandColor: secondHandColor,
                    dateColor: dateColor,
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

Widget _colorTile(
  BuildContext context,
  String title,
  Color color,
  Function(Color) onSelected,
) {
  return ListTile(
    title: Text(title),
    trailing: GestureDetector(
      onTap: () async {
        final c = await showColorPickerDialog(context, color);
        if (c != null) onSelected(c);
      },
      child: Container(width: 40, height: 40, color: color),
    ),
  );
}
