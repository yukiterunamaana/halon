import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/markdown_note_config.dart';

class MarkdownNoteWidget extends StatelessWidget {
  final MarkdownNoteConfig config;
  const MarkdownNoteWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: MarkdownBody(
        data: config.content,
        styleSheet: MarkdownStyleSheet(
          p: TextStyle(
            color: config.textColor,
            fontSize: (config.fontSize ?? 14) * config.textScale,
          ),
          h1: TextStyle(
            color: config.textColor,
            fontSize: (24) * config.textScale,
            fontWeight: FontWeight.bold,
          ),
          h2: TextStyle(
            color: config.textColor,
            fontSize: (20) * config.textScale,
            fontWeight: FontWeight.bold,
          ),
          // можно донастроить другие стили
        ),
      ),
    );
  }
}
