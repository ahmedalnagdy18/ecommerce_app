import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/domain/repository/search_repository.dart';

class SearchProductsUsecase {
  final SearchProductRepository repository;

  SearchProductsUsecase({required this.repository});

  Future<List<CardInfoEntity>> execute(String query) {
    return repository.searchProducts(query);
  }
}
