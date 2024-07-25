import 'package:flutter_application_test/domain/entities/card_info_entity.dart';
import 'package:flutter_application_test/domain/repository/repository.dart';

class Usecase {
  final Repository repository;

  Usecase({required this.repository});

  Future<List<CardInfoEntity>> call() async {
    return await repository.getdata();
  }
}
