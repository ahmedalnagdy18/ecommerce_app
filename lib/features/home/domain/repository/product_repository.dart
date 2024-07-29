import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';

abstract class Repository {
  Future<List<CardInfoEntity>> getdata();
}
