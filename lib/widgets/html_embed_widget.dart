import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/html_embed_config.dart';

class HtmlEmbedWidget extends StatefulWidget {
  final HtmlEmbedConfig config;
  const HtmlEmbedWidget({super.key, required this.config});

  @override
  State<HtmlEmbedWidget> createState() => _HtmlEmbedWidgetState();
}

class _HtmlEmbedWidgetState extends State<HtmlEmbedWidget> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  void didUpdateWidget(covariant HtmlEmbedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.url != widget.config.url ||
        oldWidget.config.htmlCode != widget.config.htmlCode) {
      _initController();
    }
  }

  void _initController() {
    final controller = WebViewController()
      ..setJavaScriptMode(
        widget.config.enableJavaScript
            ? JavaScriptMode.unrestricted
            : JavaScriptMode.disabled,
      )
      ..setNavigationDelegate(NavigationDelegate());

    final fullHtml =
        '''
        <!DOCTYPE html>
        <html>
        <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
        <body style="margin:0; padding:0; overflow:auto;">
          ${widget.config.htmlCode}
        </body>
        </html>
      ''';
    controller.loadHtmlString(fullHtml);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.config.borderStyle.radius),
      child: WebViewWidget(controller: _controller),
    );
  }
}
