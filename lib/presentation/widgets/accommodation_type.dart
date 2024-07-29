import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/presentation/screens/x_o_task.dart';
import 'package:flutter_application_test/presentation/widgets/product_type_image.dart';

class AccommodationTypeWidget extends StatelessWidget {
  const AccommodationTypeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text('Accommodation Type', style: TextAppTheme.simiBoldText),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 110,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: images.length,
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  images[index] == images[0]
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const GameTask(),
                        ))
                      : null;
                },
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.blueGrey,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    images[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
