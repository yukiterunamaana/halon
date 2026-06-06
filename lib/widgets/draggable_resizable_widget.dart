import 'package:flutter/material.dart';
import 'package:halon_wattafa/models/analog_clock_config.dart';
import 'package:halon_wattafa/widgets/rss_settings_dialog.dart';

import '../models/calendar_config.dart';
import '../models/clock_config.dart';
import '../models/html_embed_config.dart';
import '../models/image_config.dart';
import '../models/markdown_note_config.dart';
import '../models/model_3d_config.dart';
import '../models/rss_feed_config.dart';
import '../models/widget_config.dart';
import 'analog_clock_settings_dialog.dart';
import 'calendar_settings_dialog.dart';
import 'clock_setting_dialog.dart';
import 'html_embed_settings_dialog.dart';
import 'image_settings_dialog.dart';
import 'markdown_settings_dialog.dart';
import 'model_3d_settings_dialog.dart';
import 'style_editor_dialog.dart';

class DraggableResizableWidget extends StatefulWidget {
  final WidgetConfig config;
  final bool isEditing;
  final Widget child;
  final void Function(WidgetConfig newConfig) onConfigChanged;
  final VoidCallback onDelete;

  const DraggableResizableWidget({
    super.key,
    required this.config,
    required this.isEditing,
    required this.child,
    required this.onConfigChanged,
    required this.onDelete,
  });

  @override
  State<DraggableResizableWidget> createState() =>
      _DraggableResizableWidgetState();
}

class _DraggableResizableWidgetState extends State<DraggableResizableWidget> {
  late WidgetConfig _config;

  @override
  void initState() {
    super.initState();
    _config = widget.config;
  }

  void _updateConfig(WidgetConfig newConfig) {
    setState(() => _config = newConfig);
    widget.onConfigChanged(newConfig);
  }

  void _handleDrag(double dx, double dy) {
    double newLeft = _config.left + dx;
    double newTop = _config.top + dy;
    newLeft = newLeft.clamp(0.0, 2000.0);
    newTop = newTop.clamp(0.0, 2000.0);
    _updateConfig(_config.copyWith(left: newLeft, top: newTop));
  }

  void _handleResize(double dw, double dh) {
    double newWidth = (_config.width + dw).clamp(60.0, 800.0);
    double newHeight = (_config.height + dh).clamp(60.0, 800.0);
    _updateConfig(_config.copyWith(width: newWidth, height: newHeight));
  }

  void _editGeneralStyle() async {
    final newBorder = await showStyleEditorDialog(context, _config.borderStyle);
    if (newBorder != null) {
      _updateConfig(_config.copyWith(borderStyle: newBorder));
    }
  }

  void _editSpecificSettings() async {
    WidgetConfig? newCfg;
    if (_config is CalendarConfig) {
      final newCfg = await showCalendarSettingsDialog(
        context,
        _config as CalendarConfig,
      );
      if (newCfg != null) _updateConfig(newCfg);
    } else if (_config is ClockConfig) {
      final newCfg = await showClockSettingsDialog(
        context,
        _config as ClockConfig,
      );
      if (newCfg != null) _updateConfig(newCfg);
    } else if (_config is MarkdownNoteConfig) {
      final newCfg = await showMarkdownSettingsDialog(
        context,
        _config as MarkdownNoteConfig,
      );
      if (newCfg != null) _updateConfig(newCfg);
    } else if (_config is RssFeedConfig) {
      final newCfg = await showRssSettingsDialog(
        context,
        _config as RssFeedConfig,
      );
      if (newCfg != null) _updateConfig(newCfg);
    } else if (_config is Model3dConfig) {
      final newCfg = await showModel3dSettingsDialog(
        context,
        _config as Model3dConfig,
      );
    } else if (_config is HtmlEmbedConfig) {
      final newCfg = await showHtmlEmbedSettingsDialog(
        context,
        _config as HtmlEmbedConfig,
      );
    } else if (_config is ImageConfig) {
      final newCfg = await showImageSettingsDialog(
        context,
        _config as ImageConfig,
      );
    } else if (_config is AnalogClockConfig) {
      final newCfg = await showAnalogClockSettingsDialog(
        context,
        _config as AnalogClockConfig,
      );
    }
    if (newCfg != null) _updateConfig(newCfg);
  }

  Widget _buildToolbar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onPanUpdate: (details) =>
            _handleDrag(details.delta.dx, details.delta.dy),
        child: Container(
          height: 28,
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(_config.borderStyle.radius),
            ),
          ),
          child: Row(
            children: [
              /*              const SizedBox(width: 8),
              Expanded(
                child: Text(switch (_config) {
                  CalendarConfig() => 'Календарь',
                  ClockConfig() => 'Часы',
                  MarkdownNoteConfig() => 'Заметка',
                  RssFeedConfig() => 'RSS-лента',
                  Model3dConfig() => '3D-модель',
                  WidgetConfig() => throw UnimplementedError(),
                }, style: const TextStyle(fontWeight: FontWeight.bold)),
              ),*/
              IconButton(
                icon: const Icon(Icons.palette, size: 16),
                onPressed: _editGeneralStyle,
                tooltip: 'Оформление',
              ),
              IconButton(
                icon: const Icon(Icons.tune, size: 16),
                onPressed: _editSpecificSettings,
                tooltip: 'Настройки',
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 16),
                onPressed: widget.onDelete,
                tooltip: 'Удалить',
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResizeHandle() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onPanUpdate: (details) =>
            _handleResize(details.delta.dx, details.delta.dy),
        child: Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(4),
              bottomRight: Radius.circular(_config.borderStyle.radius - 2),
            ),
          ),
          child: const Icon(Icons.drag_handle, size: 12, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _config.left,
      top: _config.top,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _config.borderStyle.color,
            width: _config.borderStyle.width,
          ),
          borderRadius: BorderRadius.circular(_config.borderStyle.radius),
          color: _config.backgroundColor,
        ),
        child: Stack(
          children: [
            SizedBox(
              width: _config.width,
              height: _config.height,
              child: widget.child,
            ),
            if (widget.isEditing) _buildToolbar(),
            if (widget.isEditing) _buildResizeHandle(),
          ],
        ),
      ),
    );
  }
}
