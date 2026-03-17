import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {

  final String url;

  const AppImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Container(
            color: Colors.grey[200],
            child: const Icon(Icons.image),
          );
        },
      ),
    );
  }
}