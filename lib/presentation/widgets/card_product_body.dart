import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/button_widget.dart';
import 'package:flutter_application_test/core/common/text_widget.dart';

class CardProuductWidget extends StatelessWidget {
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
                  text: '\$ $priceText',
                ),
                ButtonWiget(
                  onPressed: () {},
                  buttonText: "Add to card",
                )
              ],
            ),
            const SizedBox(height: 30),
            const DescribtionTextWidget(),
            const SizedBox(height: 12),
            MainTextWidget(
              text: descriptionText,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SimiBoldTextWidget(text: 'Discount'),
                Text(
                  '\$ - $discountPercentage',
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
                const SimiBoldTextWidget(text: 'Category'),
                MainTextWidget(
                  text: categoryText,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SimiBoldTextWidget(text: 'Brand'),
                MainTextWidget(
                  text: brandText.isNotEmpty ? brandText : "...",
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
