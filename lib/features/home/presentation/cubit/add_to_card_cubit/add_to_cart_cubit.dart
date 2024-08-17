import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/presentation/cubit/add_to_card_cubit/add_to_cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCartCubit extends Cubit<AddtoCartState> {
  AddToCartCubit() : super(CartState(cartItems: []));

  void addItemToCart(CardInfoEntity item) {
    final currentState = state as CartState;
    final updatedCart = List<CardInfoEntity>.from(currentState.cartItems)
      ..add(item);
    emit(CartState(cartItems: updatedCart));
  }

  void removeItemFromCart(CardInfoEntity item) {
    final currentState = state as CartState;
    final updatedCart = List<CardInfoEntity>.from(currentState.cartItems)
      ..remove(item);
    emit(CartState(cartItems: updatedCart));
  }

  double calculateTotalPrice() {
    if (state is CartState) {
      final cartItems = (state as CartState).cartItems;
      return cartItems.fold(0.0, (total, item) {
        final itemEffectivePrice = (item.price! - item.discountPercentage!)
            .clamp(0.0, double.infinity);
        return total + itemEffectivePrice;
      });
    }
    return 0.0;
  }
}
