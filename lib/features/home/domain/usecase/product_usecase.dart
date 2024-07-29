import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/features/home/domain/repository/product_repository.dart';

class ProductUsecase {
  final Repository repository;

  ProductUsecase({required this.repository});

  Future<List<CardInfoEntity>> call() async {
    return await repository.getdata();
  }
}
