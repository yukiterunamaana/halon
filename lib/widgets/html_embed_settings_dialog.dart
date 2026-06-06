import 'package:flutter/material.dart';

import '../models/html_embed_config.dart';

Future<HtmlEmbedConfig?> showHtmlEmbedSettingsDialog(
  BuildContext context,
  HtmlEmbedConfig config,
) async {
  String url = config.url;
  bool enableJS = config.enableJavaScript;

  return showDialog<HtmlEmbedConfig>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Text('Настройки HTML Embed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'URL страницы'),
                  controller: TextEditingController(text: url)
                    ..addListener(
                      () => url = (TextEditingController(text: url)).text,
                    ),
                ),
                const SizedBox(height: 8),
                SwitchListTile(
                  title: const Text('Включить JavaScript'),
                  value: enableJS,
                  onChanged: (v) => setState(() => enableJS = v),
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
                  config.copyWith(url: url, enableJavaScript: enableJS),
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
