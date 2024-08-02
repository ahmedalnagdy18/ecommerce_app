import 'package:flutter_application_test/features/home/data/data_source/data_source.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<CardInfoEntity>> getdata() async {
    try {
      return await remoteDataSource.fetchdata();
    } catch (e) {
      rethrow;
    }
  }
}
