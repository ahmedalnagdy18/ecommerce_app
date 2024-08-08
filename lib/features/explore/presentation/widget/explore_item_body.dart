import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';

class ExploreItemBody extends StatelessWidget {
  final CardInfoEntity cardInfoEntity;

  const ExploreItemBody({super.key, required this.cardInfoEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Banner(
            location: BannerLocation.topStart,
            message: 'Sale',
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300),
              child: Image.network(
                cardInfoEntity.images?[0] ?? '',
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.black,
                    ),
                  );
                },
              ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MainTextWidget(
                      text: '\$ ${cardInfoEntity.price ?? 0.0}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '\$ -${cardInfoEntity.discountPercentage ?? 0.0}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
