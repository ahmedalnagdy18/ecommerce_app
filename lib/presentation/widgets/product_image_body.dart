import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/presentation/screens/home_page.dart';

class ProductImageBody extends StatelessWidget {
  const ProductImageBody(
      {super.key,
      required this.image,
      required this.titletext,
      required this.containerHeight});
  final String image;
  final String titletext;
  final double containerHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      width: double.infinity,
      decoration: const BoxDecoration(color: Colors.black),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop(MaterialPageRoute(
                          builder: (context) => const HomePage()));
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    )),
                TitleTextWidget(text: titletext, color: Colors.white)
              ],
            ),
          )
        ],
      ),
    );
  }
}
