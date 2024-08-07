import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';

abstract class AddtoCartState {
  const AddtoCartState();
}

class PostsInitial extends AddtoCartState {}

class CartState extends AddtoCartState {
  final List<CardInfoEntity> cartItems;

  CartState({required this.cartItems});
}
