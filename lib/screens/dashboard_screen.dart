import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:halon_wattafa/models/analog_clock_config.dart';
import 'package:halon_wattafa/models/image_config.dart';
import 'package:halon_wattafa/widgets/analog_clock_widget.dart';
import 'package:halon_wattafa/widgets/html_embed_widget.dart';

import '../models/board_config.dart';
import '../models/border_config.dart';
import '../models/calendar_config.dart';
import '../models/clock_config.dart';
import '../models/html_embed_config.dart';
import '../models/markdown_note_config.dart';
import '../models/model_3d_config.dart';
import '../models/rss_feed_config.dart';
import '../models/widget_config.dart';
import '../services/config_service.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/clock_widget.dart';
import '../widgets/color_picker_dialog.dart';
import '../widgets/draggable_resizable_widget.dart';
import '../widgets/image_widget.dart';
import '../widgets/markdown_note_widget.dart';
import '../widgets/model_3d_widget.dart';
import '../widgets/rss_feed_widget.dart';
import '../widgettype.dart';
import 'grid_painter.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<WidgetConfig> widgets = [];
  bool isEditing = true;
  double gridStep = 50.0;
  Color bgColor = Colors.white;
  Color gridColor = Colors.black;
  double gridWidth = 1.0;
  bool snapToGrid = true;
  bool showGrid = true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Halonot — Панель управления'),
        actions: [
          IconButton(
            icon: Icon(BoardConfig.showGrid ? Icons.grid_on : Icons.grid_off),
            onPressed: () {
              BoardConfig.showGrid = !BoardConfig.showGrid;
              setState(() {}); // перерисовываем сетку
            },
          ),

          /*          IconButton(
            icon: Icon(showGrid ? Icons.grid_on : Icons.grid_off),
            onPressed: () => setState(() => showGrid = !showGrid),
            tooltip: 'Показать сетку',
          ),*/
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _openGridSettings,
            tooltip: 'Настройки сетки',
          ),
          IconButton(
            icon: const Icon(Icons.vertical_align_center),
            onPressed: _snapAllWidgetsToGrid,
            tooltip: 'Выровнять все виджеты по сетке',
          ),

          Switch(
            value: BoardConfig.snapToGrid,
            onChanged: (v) {
              BoardConfig.snapToGrid = v;
              setState(
                () {},
              ); // виджеты не перерисовываются, но переключатель обновляется
            },
          ),

          /*
          Switch(
            value: snapToGrid,
            onChanged: (v) => setState(() => snapToGrid = v),
            //tooltip: 'Авто-привязка при перемещении/ресайзе',
          ),
          const Text('Auto'),*/
          Switch(
            value: isEditing,
            onChanged: (v) => setState(() => isEditing = v),
          ),
          const Text('Правка'),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: _copyToClipboard,
            tooltip: 'Копировать JSON',
          ),
          IconButton(
            icon: const Icon(Icons.save_alt),
            onPressed: _export,
            tooltip: 'Сохранить в файл',
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: _import,
            tooltip: 'Загрузить из файла',
          ),
        ],
      ),
      body: SizedBox.expand(
        child: Stack(
          children: [
            CustomPaint(
              painter: GridPainter(
                step: gridStep,
                strokeWidth: gridWidth,
                color: gridColor,
              ),
              size: Size.infinite,
            ),
            ...widgets.map((config) {
              return DraggableResizableWidget(
                key: ValueKey(config.id),
                config: config,
                isEditing: isEditing,
                onConfigChanged: _updateWidget,
                onDelete: () => _deleteWidget(config.id),
                child: _buildChildWidget(config),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: isEditing
          ? FloatingActionButton(
              onPressed: () => showDialog(
                context: context,
                builder: (ctx) => SimpleDialog(
                  title: const Text('Добавить виджет'),
                  children: [
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.calendar);
                        Navigator.pop(ctx);
                      },
                      child: const Text('Календарь'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.clock);
                        Navigator.pop(ctx);
                      },
                      child: const Text('Цифровые часы'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.analogClock);
                        Navigator.pop(ctx);
                      },
                      child: const Text('Часы'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.markdownNote);
                        Navigator.pop(ctx);
                      },
                      child: const Text('.md заметка'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.rssFeed);
                        Navigator.pop(ctx);
                      },
                      child: const Text('RSS-лента'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.model3d);
                        Navigator.pop(ctx);
                      },
                      child: const Text('3D-модель'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.image);
                        Navigator.pop(ctx);
                      },
                      child: const Text('Изображение'),
                    ),
                    /*                    SimpleDialogOption(
                      onPressed: () {
                        _addWidget(WidgetType.htmlEmbed);
                        Navigator.pop(ctx);
                      },
                      child: const Text('HTML-вставка'),
                    ),*/
                  ],
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildChildWidget(WidgetConfig config) {
    /*    return Container(
      color: Colors.red,
      child: Center(child: Text(config.id.substring(0, 6))),
    );*/
    switch (config.type) {
      case WidgetType.calendar:
        return CalendarWidget(config: config as CalendarConfig);
      case WidgetType.clock:
        return ClockWidget(config: config as ClockConfig);
      case WidgetType.markdownNote:
        return MarkdownNoteWidget(config: config as MarkdownNoteConfig);
      case WidgetType.rssFeed:
        return RssFeedWidget(config: config as RssFeedConfig);
      case WidgetType.model3d:
        return Model3dWidget(config: config as Model3dConfig);
      case WidgetType.htmlEmbed:
        return HtmlEmbedWidget(config: config as HtmlEmbedConfig);
      case WidgetType.image:
        return ImageWidget(config: config as ImageConfig);
      case WidgetType.analogClock:
        return AnalogClockWidget(config: config as AnalogClockConfig);
      default:
        break;
    }

    throw UnimplementedError();
  }

  Color getGridColor() {
    return gridColor;
  }

  double getGridWidth() {
    return gridWidth;
  }

  double getGridStep() {
    return gridStep;
  }

  void setGridStep(double g) {
    gridStep = g;
  }

  bool getShowGrid() {
    return showGrid;
  }

  void setShowGrid(bool b) {
    showGrid = b;
  }

  void toggleShowGrid() {
    showGrid = !showGrid;
  }

  bool getSnapToGrid() {
    return snapToGrid;
  }

  void setSnapToGrid(bool b) {
    snapToGrid = b;
  }

  void toggleSnapToGrid() {
    snapToGrid = !snapToGrid;
  }

  bool getIsEditAllowed() {
    return isEditing;
  }

  void setEditAllowed(bool b) {
    isEditing = b;
  }

  @override
  void initState() {
    super.initState();
    //_addExampleWidgets();
  }

  void _snapAllWidgetsToGrid() {
    final step = gridStep;
    setState(() {
      widgets = widgets.map((w) {
        double newLeft = (w.left / step).round() * step;
        double newTop = (w.top / step).round() * step;
        double newWidth = (w.width / step).round() * step;
        double newHeight = (w.height / step).round() * step;
        return w.copyWith(
          left: newLeft,
          top: newTop,
          width: newWidth,
          height: newHeight,
        );
      }).toList();
    });
  }

  // Диалог настроек сетки
  void _openGridSettings() async {
    double step = gridStep;
    double stroke = gridWidth;
    Color color = gridColor;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          title: const Text('Настройки сетки'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Шаг (px)'),
                trailing: SizedBox(
                  width: 150,
                  child: Slider(
                    min: 10,
                    max: 100,
                    divisions: 9,
                    value: step,
                    onChanged: (v) => setStateDialog(() => step = v),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Толщина линии'),
                trailing: SizedBox(
                  width: 150,
                  child: Slider(
                    min: 0.5,
                    max: 5,
                    divisions: 9,
                    value: stroke,
                    onChanged: (v) => setStateDialog(() => stroke = v),
                  ),
                ),
              ),
              ListTile(
                title: const Text('Цвет'),
                trailing: GestureDetector(
                  onTap: () async {
                    final newColor = await showColorPickerDialog(
                      context,
                      color,
                    );
                    if (newColor != null)
                      setStateDialog(() => color = newColor);
                  },
                  child: Container(width: 40, height: 40, color: color),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  gridStep = step;
                  gridWidth = stroke;
                  gridColor = color;
                });
                Navigator.pop(context);
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  WidgetConfig _createDefaultCalendarConfig(String id) {
    return CalendarConfig(
      id: id,
      left: 1 * gridStep,
      top: 1 * gridStep,
      width: 7 * gridStep,
      height: 6 * gridStep,
      borderStyle: BorderStyleConfig(color: Colors.black, width: 1, radius: 15),
      backgroundColor: Colors.white,
      fontSize: 14,
      weekdayColor: Colors.black,
      saturdayColor: Colors.blue,
      sundayColor: Colors.red,
      startMonday: true,
    );
  }

  WidgetConfig _createDefaultClockConfig(String id) {
    return ClockConfig(
      id: id,
      left: 1 * gridStep,
      top: 1 * gridStep,
      width: 6 * gridStep,
      height: 3 * gridStep,
      borderStyle: BorderStyleConfig(color: Colors.grey, width: 1, radius: 8),
      backgroundColor: Colors.white,
      fontSize: 28,
      digitFormat: DigitFormat.arabic,
      showSeconds: true,
    );
  }

  void _addWidget(WidgetType type) {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    WidgetConfig newConfig;

    switch (type) {
      case WidgetType.calendar:
        newConfig = _createDefaultCalendarConfig(id);
        break;
      case WidgetType.clock:
        newConfig = _createDefaultClockConfig(id);
        break;
      case WidgetType.markdownNote:
        newConfig = MarkdownNoteConfig.withDefaults(id: id);
        break;
      case WidgetType.rssFeed:
        newConfig = RssFeedConfig.withDefaults(id: id);
        break;
      case WidgetType.model3d:
        newConfig = Model3dConfig.withDefaults(id: id);
      case WidgetType.htmlEmbed:
        newConfig = HtmlEmbedConfig.withDefaults(id: id);
      case WidgetType.analogClock:
        newConfig = AnalogClockConfig.withDefaults(id: id);
      case WidgetType.image:
        newConfig = ImageConfig.withDefaults(id: id);
      case WidgetType.video:
        // TODO: Handle this case.
        throw UnimplementedError();
      case WidgetType.slideshow:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    setState(() => widgets.add(newConfig));
  }

  void _updateWidget(WidgetConfig updated) {
    setState(() {
      final index = widgets.indexWhere((w) => w.id == updated.id);
      if (index != -1) widgets[index] = updated;
    });
  }

  void _deleteWidget(String id) {
    setState(() => widgets.removeWhere((w) => w.id == id));
  }

  Future<void> _copyToClipboard() async {
    // Сериализуем список виджетов в JSON
    final jsonList = widgets.map((w) => w.toJson()).toList();
    final jsonString = jsonEncode(jsonList); // нужен import 'dart:convert';
    await Clipboard.setData(ClipboardData(text: jsonString));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Конфигурация скопирована в буфер обмена'),
        ),
      );
    }
  }

  Future<void> _export() async {
    await ConfigService.exportConfig(widgets);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Конфигурация сохранена')));
    _copyToClipboard();
  }

  Future<void> _import() async {
    final imported = await ConfigService.importConfig();
    if (imported.isNotEmpty) {
      setState(() => widgets = imported as List<WidgetConfig>);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Загружено ${imported.length} виджетов')),
      );
    }
  }
}
