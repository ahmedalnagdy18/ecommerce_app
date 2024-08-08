import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/message_alert.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_cubit.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_state.dart';
import 'package:flutter_application_test/features/home/presentation/widgets/cart_page_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AddToCart();
  }
}

class _AddToCart extends StatelessWidget {
  const _AddToCart();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<AddToCartCubit, AddtoCartState>(
                builder: (context, state) {
                  if (state is CartState) {
                    if (state.cartItems.isEmpty) {
                      return const Center(
                        child: Text('Your cart is empty'),
                      );
                    }

                    final itemCounts = <String, int>{};
                    for (var item in state.cartItems) {
                      final itemId = item.id.toString();
                      if (itemCounts.containsKey(itemId)) {
                        itemCounts[itemId] = itemCounts[itemId]! + 1;
                      } else {
                        itemCounts[itemId] = 1;
                      }
                    }

                    return Column(
                      children: [
                        Expanded(
                          child: ListView(
                            children: itemCounts.entries.map((entry) {
                              final item = state.cartItems.firstWhere(
                                  (i) => i.id.toString() == entry.key);
                              final count = entry.value;

                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 14),
                                  child: CartItemWidget(
                                    cardInfoEntity: item,
                                    countText: 'x$count',
                                    onPressed: () {
                                      const snackbar = SnackbarWidget(
                                        text: 'Item deleted Successfully',
                                        backgroundColor: Colors.grey,
                                      );
                                      snackbar.showCustomSnackBar(context);
                                      context
                                          .read<AddToCartCubit>()
                                          .removeItemFromCart(item);
                                    },
                                  ));
                            }).toList(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlocBuilder<AddToCartCubit, AddtoCartState>(
                            builder: (context, state) {
                              if (state is CartState) {
                                final totalPrice = context
                                    .read<AddToCartCubit>()
                                    .calculateTotalPrice();
                                return TotalPriceWidget(
                                  text: '\$ ${totalPrice.toStringAsFixed(2)}',
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(
                    child: Text('Your cart is empty'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
