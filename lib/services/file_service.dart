import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  /// Открывает диалог выбора 3D-модели и сохраняет её в папку приложения.
  /// Возвращает путь к сохранённому файлу или null, если выбор отменён.
  static Future<String?> pickAndSaveModel() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['gltf', 'glb', 'obj'],
    );
    if (result == null) return null;
    final file = File(result.files.single.path!);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = result.files.single.name;
    final savedFile = File('${appDir.path}/models/$fileName');
    await savedFile.parent.create(recursive: true);
    await file.copy(savedFile.path);
    return savedFile.path;
  }
}
