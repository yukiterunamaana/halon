import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../models/widget_config.dart';

class ConfigService {
  static Future<void> exportConfig(List<WidgetConfig> widgets) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/dashboard_config.json');
    final jsonList = widgets.map((w) => w.toJson()).toList();
    await file.writeAsString(jsonEncode(jsonList));
  }

  static Future<List<WidgetConfig?>> importConfig() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );
    if (result == null) return [];
    final file = File(result.files.single.path!);
    final content = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(content);
    return jsonList.map((json) => WidgetConfig.fromJson(json)).toList();
  }
}
