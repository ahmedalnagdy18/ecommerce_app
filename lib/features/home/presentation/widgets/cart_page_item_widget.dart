import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';

class CartItemWidget extends StatelessWidget {
  final CardInfoEntity cardInfoEntity;
  final void Function() onPressed;
  final String countText;
  const CartItemWidget(
      {super.key,
      required this.cardInfoEntity,
      required this.onPressed,
      required this.countText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 100),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300),
            child: Image.network(
              cardInfoEntity.images?[0] ?? '',
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainTextWidget(
                  text: cardInfoEntity.title ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
                MainTextWidget(
                  text: cardInfoEntity.category ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '+ \$ ${(cardInfoEntity.price! - cardInfoEntity.discountPercentage!).clamp(0.0, double.infinity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        countText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                          onPressed: onPressed, icon: const Icon(Icons.delete)),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
