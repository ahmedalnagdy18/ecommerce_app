import 'package:flutter/material.dart';

class TextAppTheme {
  static const TextStyle mainBoldText = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 24,
  );

  static const TextStyle mainGreyBoldText = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.grey,
    fontSize: 14,
  );

  static const TextStyle titleText = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );

  static const TextStyle descriptionText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const TextStyle simiBoldText = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static const TextStyle mainText = TextStyle(
    color: Colors.black,
    fontSize: 16,
  );
}

class TitleTextWidget extends StatelessWidget {
  const TitleTextWidget({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
    );
  }
}

class MainTextWidget extends StatelessWidget {
  const MainTextWidget(
      {super.key, required this.text, this.overflow, this.maxLines});
  final String text;
  final TextOverflow? overflow;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      overflow: overflow,
      text,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
    );
  }
}
