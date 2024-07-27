import 'package:flutter/material.dart';

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

class DescribtionTextWidget extends StatelessWidget {
  const DescribtionTextWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Description',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: 18,
      ),
    );
  }
}

class SimiBoldTextWidget extends StatelessWidget {
  const SimiBoldTextWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 16,
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
        fontSize: 16,
      ),
    );
  }
}
