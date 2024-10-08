import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/button_widget.dart';
import 'package:flutter_application_test/core/common/message_alert.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardProuductWidget extends StatefulWidget {
  final CardInfoEntity cardInfoEntity;

  const CardProuductWidget({
    super.key,
    required this.cardInfoEntity,
  });

  @override
  State<CardProuductWidget> createState() => _CardProuductWidgetState();
}

class _CardProuductWidgetState extends State<CardProuductWidget> {
  @override
  Widget build(BuildContext context) {
    final cardInfo = widget.cardInfoEntity;

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
                  text: '\$ ${cardInfo.price ?? 'N/A'}',
                ),
                AddToCartButton(
                  onPressed: () {
                    const snackbar = SnackbarWidget(
                      text: 'Item Added Successfully',
                      backgroundColor: Colors.black,
                    );
                    snackbar.showCustomSnackBar(context);
                    context.read<AddToCartCubit>().addItemToCart(cardInfo);
                    Navigator.of(context).pop();
                  },
                  buttonText: "Add to cart",
                )
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Description',
              style: TextAppTheme.descriptionText,
            ),
            const SizedBox(height: 12),
            ReadMoreWidget(
                text: cardInfo.description ?? 'No description available'),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount',
                  style: TextAppTheme.simiBoldText,
                ),
                Text(
                  '\$ - ${cardInfo.discountPercentage?.toString() ?? '0.00'}',
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
                  text: cardInfo.category ?? 'Unknown',
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
                  text: cardInfo.brand?.isNotEmpty == true
                      ? cardInfo.brand!
                      : 'No brand info',
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
