import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

Future<Color?> showColorPickerDialog(
  BuildContext context,
  Color initialColor,
) async {
  Color pickedColor = initialColor;
  return showDialog<Color>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Выберите цвет'),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickedColor,
          onColorChanged: (color) => pickedColor = color,
          showLabel: true,
          pickerAreaHeightPercent: 0.8,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, pickedColor),
          child: const Text('ОК'),
        ),
      ],
    ),
  );
}
