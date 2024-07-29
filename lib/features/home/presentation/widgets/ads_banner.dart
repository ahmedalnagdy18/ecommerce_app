import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/product_type_image.dart';

class AdsBannerWidget extends StatelessWidget {
  const AdsBannerWidget(
      {super.key,
      required this.onPageChanged,
      required this.controller,
      required this.position});
  final Function(int) onPageChanged;
  final PageController controller;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            children: [
              PageView.builder(
                controller: controller,
                itemCount: 4,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.orange,
                    ),
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 22),
                    child: Image.network(
                      images2[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: DotsIndicator(
                  dotsCount: 4,
                  position: position,
                  decorator: DotsDecorator(
                    size: const Size.square(10),
                    activeSize: const Size(12, 12),
                    activeShape: const CircleBorder(
                      side: BorderSide(
                          color: Colors.black, style: BorderStyle.solid),
                    ),
                    activeColor: Colors.grey.shade700,
                    color: Colors.white,
                    spacing: const EdgeInsets.all(3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
