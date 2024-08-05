import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/button_widget.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:readmore/readmore.dart';

class CardProuductWidget extends StatefulWidget {
  const CardProuductWidget(
      {super.key,
      required this.priceText,
      required this.descriptionText,
      required this.categoryText,
      required this.brandText,
      required this.discountPercentage});
  final double priceText;
  final String descriptionText;
  final double discountPercentage;
  final String categoryText;
  final String brandText;

  @override
  State<CardProuductWidget> createState() => _CardProuductWidgetState();
}

class _CardProuductWidgetState extends State<CardProuductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25)),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleTextWidget(
                  color: Colors.black,
                  text: '\$ ${widget.priceText}',
                ),
                AddToCartButton(
                  onPressed: () {},
                  buttonText: "Add to card",
                )
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Description',
              style: TextAppTheme.descriptionText,
            ),
            const SizedBox(height: 12),
            ReadMoreText(
              widget.descriptionText,
              trimLines: 3,
              trimMode: TrimMode.Line,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
              lessStyle: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
              moreStyle: const TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount',
                  style: TextAppTheme.simiBoldText,
                ),
                Text(
                  '\$ - ${widget.discountPercentage}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Category',
                  style: TextAppTheme.simiBoldText,
                ),
                MainTextWidget(
                  text: widget.categoryText,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Brand',
                  style: TextAppTheme.simiBoldText,
                ),
                MainTextWidget(
                  text: widget.brandText.isNotEmpty ? widget.brandText : "...",
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
