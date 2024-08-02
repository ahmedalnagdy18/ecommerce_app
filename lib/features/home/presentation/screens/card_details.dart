import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/card_product_body.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/product_image_body.dart';

class CardDetails extends StatelessWidget {
  final double price;
  final String title;
  final String imageUrl;
  final String description;
  final double discountPercentage;
  final String category;
  final String brand;

  const CardDetails(
      {super.key,
      required this.imageUrl,
      required this.price,
      required this.title,
      required this.description,
      required this.discountPercentage,
      required this.category,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageBody(
              containerHeight: queryData.size.height * 0.40,
              image: imageUrl,
              titletext: title,
            ),
            Expanded(
              child: CardProuductWidget(
                brandText: brand,
                categoryText: category,
                descriptionText: description,
                discountPercentage: discountPercentage,
                priceText: price,
              ),
            )
          ],
        ),
      ),
    );
  }
}
