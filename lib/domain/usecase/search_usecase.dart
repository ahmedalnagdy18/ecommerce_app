import 'package:flutter_application_test/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/domain/repository/search_repository.dart';

class SearchProductsUsecase {
  final SearchProductRepository repository;

  SearchProductsUsecase({required this.repository});

  Future<List<CardInfoEntity>> execute(String query) {
    return repository.searchProducts(query);
  }
}
