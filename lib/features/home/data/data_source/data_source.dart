import 'dart:convert';
import 'package:flutter_application_test/features/home/data/mapper/card_data_mapper.dart';
import 'package:flutter_application_test/features/home/domain/entities/card_info_entity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_application_test/features/home/data/model/api_model.dart';

class RemoteDataSource {
  Future<List<CardInfoEntity>> fetchdata() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<CardInfoEntity> getData = [];
      for (var element in data['products']) {
        ProductApiModel apiModel = ProductApiModel.fromJson(element);
        getData.add(apiModel.cardMap());
      }
      return getData;
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<CardInfoEntity>> searchProducts(String searchText) async {
    final response = await http.get(
      Uri.parse('https://dummyjson.com/products/search?q=$searchText'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      List<CardInfoEntity> getData = [];
      for (var element in data['products']) {
        ProductApiModel apiModel = ProductApiModel.fromJson(element);
        getData.add(apiModel.cardMap());
      }
      return getData;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
