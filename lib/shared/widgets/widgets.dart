import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

class ToastMessage {
  static success(String message) {
    _message(message, Colors.white, Colors.green);
  }

  static _message(String message, Color backColor, Color textColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        textColor: textColor,
        backgroundColor: backColor,
        timeInSecForIosWeb: 2);
  }

  static error(String message) {
    _message(message, Colors.red, Colors.white);
  }

  static info(String message) {
    _message(message, Colors.black, Colors.white);
  }
}
