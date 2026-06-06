import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

import '../models/model_3d_config.dart';

class Model3dWidget extends StatefulWidget {
  final Model3dConfig config;
  const Model3dWidget({super.key, required this.config});

  @override
  State<Model3dWidget> createState() => _Model3dWidgetState();
}

class _Model3dWidgetState extends State<Model3dWidget> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _error = null;
  }

  @override
  void didUpdateWidget(covariant Model3dWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config.effectiveUrl != widget.config.effectiveUrl) {
      setState(() => _error = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 8),
            Text(
              'Ошибка загрузки модели: $_error',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => setState(() => _error = null),
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.config.borderStyle.radius),
      child: ModelViewer(
        src: widget.config.effectiveUrl,
        autoRotate: widget.config.autoRotate,
        cameraOrbit:
            '${widget.config.autoRotateAxisY * widget.config.autoRotateSpeed}deg ${widget.config.autoRotateAxisX * widget.config.autoRotateSpeed}deg ${widget.config.autoRotateAxisZ * widget.config.autoRotateSpeed}deg',
        poster: widget.config.posterUrl,
        backgroundColor: widget.config.backgroundColor,
        disableZoom: true,
        disablePan: true,
        disableTap: true,
        ar: false,
      ),
    );
  }
}
