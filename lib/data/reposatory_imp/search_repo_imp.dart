import 'package:flutter_application_test/data/data_source/data_source.dart';
import 'package:flutter_application_test/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/domain/repository/search_repository.dart';

class SearchProductRepositoryImpl implements SearchProductRepository {
  final RemoteDataSource remoteDataSource;

  SearchProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CardInfoEntity>> searchProducts(String query) async {
    try {
      final products = await remoteDataSource.searchProducts(query);
      return products;
    } catch (e) {
      throw Exception("Falied to search ${e}");
    }
  }
}
