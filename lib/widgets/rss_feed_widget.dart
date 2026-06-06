import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

import '../models/rss_feed_config.dart';

class RssFeedWidget extends StatefulWidget {
  final RssFeedConfig config;
  const RssFeedWidget({super.key, required this.config});

  @override
  State<RssFeedWidget> createState() => _RssFeedWidgetState();
}

class _RssFeedWidgetState extends State<RssFeedWidget> {
  List<RssItem> _items = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchFeed();
  }

  @override
  void didUpdateWidget(covariant RssFeedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.feedUrl != widget.config.feedUrl) {
      _fetchFeed();
    }
  }

  Future<void> _fetchFeed() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final response = await http.get(Uri.parse(widget.config.feedUrl));
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}');
      }
      final document = XmlDocument.parse(response.body);
      final items = <RssItem>[];
      // RSS 2.0
      final rssChannel = document.findAllElements('channel').firstOrNull;
      if (rssChannel != null) {
        for (var item in rssChannel.findAllElements('item')) {
          items.add(_parseRssItem(item));
        }
      } else {
        // Atom feed
        final atomEntries = document.findAllElements('entry');
        for (var entry in atomEntries) {
          items.add(_parseAtomEntry(entry));
        }
      }
      setState(() {
        _items = items.take(widget.config.itemsCount).toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  RssItem _parseRssItem(XmlElement element) {
    final title =
        element.findElements('title').firstOrNull?.innerText ?? 'Без заголовка';
    final description =
        element.findElements('description').firstOrNull?.innerText ?? '';
    final link = element.findElements('link').firstOrNull?.innerText ?? '';
    return RssItem(title: title, description: description, link: link);
  }

  RssItem _parseAtomEntry(XmlElement element) {
    final title =
        element.findElements('title').firstOrNull?.innerText ?? 'Без заголовка';
    final description =
        element.findElements('summary').firstOrNull?.innerText ?? '';
    final linkElement = element.findElements('link').firstOrNull;
    final link = linkElement?.getAttribute('href') ?? '';
    return RssItem(title: title, description: description, link: link);
  }

  void _openLink(String link) async {
    if (link.isEmpty) return;
    final uri = Uri.parse(link);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red),
            const SizedBox(height: 8),
            Text('Ошибка: $_error', textAlign: TextAlign.center),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _fetchFeed,
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }
    if (_items.isEmpty) {
      return const Center(child: Text('Нет новостей'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _items.length,
      itemBuilder: (ctx, idx) {
        final item = _items[idx];
        return Card(
          elevation: 2,
          child: ListTile(
            title: Text(
              item.title,
              style: TextStyle(
                color: widget.config.titleColor,
                fontSize: widget.config.titleFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle:
                widget.config.showDescription && item.description.isNotEmpty
                ? Text(
                    item.description.replaceAll(RegExp(r'<[^>]*>'), ''),
                    style: TextStyle(
                      color: widget.config.descriptionColor,
                      fontSize: widget.config.descriptionFontSize,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                : null,
            onTap: () => _openLink(item.link),
          ),
        );
      },
    );
  }
}

class RssItem {
  final String title;
  final String description;
  final String link;
  RssItem({required this.title, required this.description, required this.link});
}
