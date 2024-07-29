import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/presentation/screens/card_details.dart';

class SearchItem extends StatelessWidget {
  final CardInfoEntity post;
  const SearchItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CardDetails(
              imageUrl: post.images?[0] ?? '',
              price: post.price ?? 0.0,
              title: post.title ?? '',
              description: post.description ?? '',
              discountPercentage: post.discountPercentage ?? 0.0,
              category: post.category ?? '',
              brand: post.brand ?? '',
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 100,
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
                  color: Colors.blueGrey),
              child: Image.network(
                post.images?[0] ?? '',
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CupertinoActivityIndicator(
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainTextWidget(
                    text: post.title ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                  MainTextWidget(
                    text: post.category ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainTextWidget(
                        text: '\$ ${post.price ?? 0.0}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '\$ -${post.discountPercentage ?? 0.0}',
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
      ),
    );
  }
}
