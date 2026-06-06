import 'package:flutter/material.dart';

import '../models/image_config.dart';

class ImageWidget extends StatelessWidget {
  final ImageConfig config;
  const ImageWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    if (config.imageUrl.isEmpty) {
      return const Center(
        child: Icon(Icons.image, size: 64, color: Colors.grey),
      );
    }
    return Image.network(
      config.imageUrl,
      fit: config.fit,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Icon(Icons.broken_image, size: 64, color: Colors.red),
        );
      },
    );
  }
}
