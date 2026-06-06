import 'package:flutter/material.dart';

import '../models/clock_config.dart';

Future<ClockConfig?> showClockSettingsDialog(
  BuildContext context,
  ClockConfig config,
) async {
  DigitFormat format = config.digitFormat;
  bool showSeconds = config.showSeconds;

  return showDialog<ClockConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки часов'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<DigitFormat>(
                  initialValue: format,
                  items: const [
                    DropdownMenuItem(
                      value: DigitFormat.arabic,
                      child: Text('Арабские (123)'),
                    ),
                    DropdownMenuItem(
                      value: DigitFormat.roman,
                      child: Text('Римские (I II III)'),
                    ),
                    DropdownMenuItem(
                      value: DigitFormat.easternArabic,
                      child: Text('Восточно-арабские (١٢٣)'),
                    ),
                  ],
                  onChanged: (v) => setState(() => format = v!),
                  decoration: const InputDecoration(labelText: 'Формат цифр'),
                ),
                SwitchListTile(
                  title: const Text('Показывать секунды'),
                  value: showSeconds,
                  onChanged: (v) => setState(() => showSeconds = v),
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
                    digitFormat: format,
                    showSeconds: showSeconds,
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
