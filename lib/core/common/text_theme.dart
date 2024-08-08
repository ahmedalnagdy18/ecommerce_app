import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

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

class ReadMoreWidget extends StatelessWidget {
  const ReadMoreWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: 3,
      trimMode: TrimMode.Line,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      lessStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
      moreStyle: const TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

class TotalPriceWidget extends StatelessWidget {
  const TotalPriceWidget({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Total: ',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
