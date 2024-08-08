import 'package:flutter/material.dart';

class SnackbarWidget extends StatelessWidget {
  const SnackbarWidget(
      {super.key, required this.text, required this.backgroundColor});
  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 1),
        content: Text(text),
        action: SnackBarAction(
          label: 'Undo',
          textColor: Colors.white,
          onPressed: () {},
        ));
  }

  void showCustomSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackbarWidget(
        text: text,
        backgroundColor: backgroundColor,
      ).build(context) as SnackBar,
    );
  }
}
