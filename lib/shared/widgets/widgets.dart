import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String url;
  const CustomNetworkImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(url),
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
            color: Colors.grey[300],
            child: const Center(child: Text('Loading...')));
      },
      errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[300],
          child: const Center(child: Text('Could not load image.'))),
    );
  }
}
