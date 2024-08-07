import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/common/text_theme.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_cubit.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_state.dart';
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
      body: BlocBuilder<AddToCartCubit, AddtoCartState>(
        builder: (context, state) {
          if (state is CartState) {
            if (state.cartItems.isEmpty) {
              return const Center(
                child: Text('Your cart is empty'),
              );
            }
            return ListView.builder(
              itemCount: state.cartItems.length,
              itemBuilder: (context, index) {
                final item = state.cartItems[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                  child: Container(
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
                            item.images?[0] ?? '',
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
                                text: item.title ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                              MainTextWidget(
                                text: item.category ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '+ \$ ${(item.price! - item.discountPercentage!).clamp(0, double.infinity).toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<AddToCartCubit>()
                                              .removeItemFromCart(item);
                                        },
                                        icon: const Icon(Icons.delete)),
                                    const SizedBox(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Your cart is empty'),
          );
        },
      ),
    );
  }
}
