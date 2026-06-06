import 'package:flutter/material.dart';

import '../models/calendar_config.dart';

Future<CalendarConfig?> showCalendarSettingsDialog(
  BuildContext context,
  CalendarConfig config,
) async {
  Color weekdayColor = config.weekdayColor;
  Color saturdayColor = config.saturdayColor;
  Color sundayColor = config.sundayColor;
  bool startMonday = config.startMonday;

  return showDialog<CalendarConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки календаря'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _colorTile(
                  'Цвет будних дней',
                  Colors.black,
                  (c) => setState(() => weekdayColor = c),
                ),
                _colorTile(
                  'Цвет субботы',
                  Colors.blue,
                  (c) => setState(() => saturdayColor = c),
                ),
                _colorTile(
                  'Цвет воскресенья',
                  Colors.red,
                  (c) => setState(() => sundayColor = c),
                ),
                SwitchListTile(
                  title: const Text('Начинать неделю с понедельника'),
                  value: startMonday,
                  onChanged: (v) => setState(() => startMonday = v),
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
                  config.copyWith(
                    weekdayColor: weekdayColor,
                    saturdayColor: saturdayColor,
                    sundayColor: sundayColor,
                    startMonday: startMonday,
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
  //BuildContext context,
  String title,
  Color color,
  Function(Color) onSelected,
) {
  return ListTile(
    title: Text(title),
    trailing: GestureDetector(
      /*      onTap: () async {
        final c = await showColorPickerDialog(context, color);
        if (c != null) onSelected(c);
      },*/
      child: Container(width: 40, height: 40, color: color),
    ),
  );
}
