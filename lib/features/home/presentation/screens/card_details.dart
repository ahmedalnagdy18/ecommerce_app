import 'package:flutter/material.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/card_product_body.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/product_image_body.dart';

class CardDetails extends StatelessWidget {
  final CardInfoEntity cardInfoEntity;

  const CardDetails({
    super.key,
    required this.cardInfoEntity,
  });

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
              image: (cardInfoEntity.images ?? []).firstOrNull ?? '',
              titletext: cardInfoEntity.title ?? '',
            ),
            Expanded(
              child: CardProuductWidget(cardInfoEntity: cardInfoEntity),
            )
          ],
        ),
      ),
    );
  }
}
