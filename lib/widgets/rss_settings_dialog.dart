import 'package:flutter/material.dart';

import '../models/rss_feed_config.dart';
import 'color_picker_dialog.dart';

Future<RssFeedConfig?> showRssSettingsDialog(
  BuildContext context,
  RssFeedConfig config,
) async {
  String feedUrl = config.feedUrl;
  int itemsCount = config.itemsCount;
  Color titleColor = config.titleColor;
  Color descriptionColor = config.descriptionColor;
  double titleFontSize = config.titleFontSize;
  double descriptionFontSize = config.descriptionFontSize;
  bool showDescription = config.showDescription;

  return showDialog<RssFeedConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки RSS-ленты'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: 'URL ленты'),
                    controller: TextEditingController(text: feedUrl)
                      ..addListener(
                        () => feedUrl = (TextEditingController(
                          text: feedUrl,
                        )).text,
                      ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    title: const Text('Количество новостей'),
                    trailing: SizedBox(
                      width: 100,
                      child: Slider(
                        min: 1,
                        max: 20,
                        divisions: 19,
                        value: itemsCount.toDouble(),
                        onChanged: (v) =>
                            setState(() => itemsCount = v.round()),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Цвет заголовков'),
                    trailing: GestureDetector(
                      onTap: () async {
                        final color = await showColorPickerDialog(
                          context,
                          titleColor,
                        );
                        if (color != null) setState(() => titleColor = color);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        color: titleColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Цвет описания'),
                    trailing: GestureDetector(
                      onTap: () async {
                        final color = await showColorPickerDialog(
                          context,
                          descriptionColor,
                        );
                        if (color != null)
                          setState(() => descriptionColor = color);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        color: descriptionColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Размер шрифта заголовка'),
                    trailing: SizedBox(
                      width: 100,
                      child: Slider(
                        min: 10,
                        max: 24,
                        divisions: 14,
                        value: titleFontSize,
                        onChanged: (v) => setState(() => titleFontSize = v),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('Размер шрифта описания'),
                    trailing: SizedBox(
                      width: 100,
                      child: Slider(
                        min: 8,
                        max: 18,
                        divisions: 10,
                        value: descriptionFontSize,
                        onChanged: (v) =>
                            setState(() => descriptionFontSize = v),
                      ),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Показывать описание'),
                    value: showDescription,
                    onChanged: (v) => setState(() => showDescription = v),
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
                    feedUrl: feedUrl,
                    itemsCount: itemsCount,
                    titleColor: titleColor,
                    descriptionColor: descriptionColor,
                    titleFontSize: titleFontSize,
                    descriptionFontSize: descriptionFontSize,
                    showDescription: showDescription,
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
