import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';

abstract class SearchProductRepository {
  Future<List<CardInfoEntity>> searchProducts(String query);
}
