import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/button_widget.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

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
                  text: '\$ ${widget.cardInfoEntity.price}',
                ),
                AddToCartButton(
                  onPressed: () {
                    context
                        .read<AddToCartCubit>()
                        .addItemToCart(widget.cardInfoEntity);
                  },
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
              widget.cardInfoEntity.description ?? '',
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
                  '\$ - ${widget.cardInfoEntity.discountPercentage}',
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
                  text: widget.cardInfoEntity.category ?? "",
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
                  text: widget.cardInfoEntity.brand!.isEmpty
                      ? widget.cardInfoEntity.brand ?? ''
                      : "...",
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
